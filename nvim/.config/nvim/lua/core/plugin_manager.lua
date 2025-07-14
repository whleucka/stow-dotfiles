local M = {}
local log = require("lib.utils").log
local plugin_root = vim.fn.stdpath("data") .. "/site/pack/plugins"
local plugins = require("plugins")

-- Configuration
local default_config = {
  plugin_root = plugin_root,
  plugins = plugins,
}
vim.inspect(default_config)

M.config = vim.deepcopy(default_config)

-- Boostrap the plugin
-- This will run the config function in the plugin configuration
local function bootstrap(plugin)
  local ok, err = pcall(plugin.config)
  if not ok then
    log.error(string.format("Error in config for %s: %s", plugin.name, err))
  end
end

-- Get the plugin path
local function get_plugin_path(type, name)
  return string.format("%s/%s/%s", M.config.plugin_root, type, name)
end

-- Does the plugin exist?
local function plugin_exists(type, name)
  return vim.fn.isdirectory(get_plugin_path(type, name)) == 1
end

-- Clone plugin
-- This will use git to fetch the plugin from the repository
local function plugin_clone(plugin, type)
  local path = get_plugin_path(type, plugin.name)
  if not plugin_exists(type, plugin.name) then
    log.system(string.format("Installing [%s] (%s)...", plugin.name, type))
    os.execute(string.format("git clone --quiet %s %s", plugin.url, path))
    log.success(string.format("Installed %s → %s", plugin.name, path))
    return true
  else
    log.success(string.format("%s (%s) already installed.", plugin.name, type))
    return false
  end
end

-- Stream cmd output to vim notify
local function run_shell_command_stream(plugin, cmd)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local handle
  handle = vim.loop.spawn("sh", {
    args = { "-c", cmd },
    stdio = {nil, stdout, stderr},
  }, function(code, signal)
    stdout:close()
    stderr:close()
    handle:close()

    vim.schedule(function()
      if code == 0 then
        log.success(string.format("[%s] Build complete", plugin.name))
      else
        log.error(string.format("[%s] Exit code %s: %s", plugin.name, code, cmd))
      end
    end)
  end)

  local function on_read(err, data)
    if err then
      vim.schedule(function()
        log.error(string.format("[%s] Error: %s", plugin.name, err))
      end)
    end
    if data then
      for line in string.gmatch(data, "[^\r\n]+") do
        vim.schedule(function()
          log.system(string.format("[%s] %s", plugin.name, line))
        end)
      end
    end
  end

  vim.loop.read_start(stdout, on_read)
  vim.loop.read_start(stderr, on_read)
end

-- Build plugin
-- This will run the build command in a shell
local function build(plugin)
    log.system(string.format("Building %s in the background.", plugin.name))
    local plugin_dir = M.config.plugin_root .. "/start/" .. plugin.name
    local cmd = "cd " .. plugin_dir .. " && " .. plugin.build
    run_shell_command_stream(plugin, cmd)
end

-- Install plugin
-- This will install plugin and dependencies
local function plugin_install()
  local plugins = M.config.plugins
  vim.inspect(plugins)
  local path = M.config.plugin_root
  local start_path = path .. "/start"
  local opt_path = path .. "/opt"

  -- Create base directories
  vim.fn.mkdir(start_path, "p")
  vim.fn.mkdir(opt_path, "p")
  local has_build = false

  -- Install & build start plugins
  for _, plugin in ipairs(plugins.start or {}) do
    for _, dependency in ipairs(plugin.dependencies or {}) do
      local installed = plugin_clone(dependency, "start")
      if dependency.build and installed then
        build(dependency)
        has_build = true
      end
    end
    -- Clone plugin
    local installed = plugin_clone(plugin, "start")
    if plugin.build and installed then
      build(plugin)
      has_build = true
    end
  end

  -- Install opt plugins
  -- for _, plugin in ipairs(plugins.opt or {}) do
  --   plugin_clone(plugin, "opt")
  -- end

  log.success("Plugin installation complete.")
  if has_build then
    log.info("Build in progress. Please wait until complete.")
  end
end

-- Update plugin
-- This will use git to pull the most recent changes
local function plugin_update()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = M.config.plugin_root .. "/" .. type
    if vim.fn.isdirectory(type_path) == 1 then
      for _, dir in ipairs(vim.fn.readdir(type_path)) do
        local full_path = type_path .. "/" .. dir
        if vim.fn.isdirectory(full_path .. "/.git") == 1 then
          log.info("Updating " .. dir)
          os.execute(string.format("git -C %s pull --quiet", full_path))
        end
      end
    end
  end

  log.success("Plugin update complete.")
end

-- List installed plugins
local function plugin_list()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = string.format("%s/%s", M.config.plugin_root, type)
    if vim.fn.isdirectory(type_path) == 1 then
      local plugins = vim.fn.readdir(type_path)
      if #plugins > 0 then
        log.info(type .. " plugins:")
        for _, name in ipairs(plugins) do
          vim.notify("   └─ " .. name)
        end
      else
        log.info(type .. " plugins: (none)")
      end
    else
      log.info(type .. " plugins: (directory missing)")
    end
  end
end

-- Clean plugin directory
local function plugin_clean()
  local plugins = M.config.plugins

  -- Get list of expected plugin names
  local expected = {}
  for _, plugin in ipairs(plugins.start or {}) do
    expected["start/" .. plugin.name] = true
    if plugin.dependencies then
      for _, dependency in ipairs(plugin.dependencies) do
        expected["start/" .. dependency.name] = true
      end
    end
  end
  for _, plugin in ipairs(plugins.opt or {}) do
    expected["opt/" .. plugin.name] = true
    if plugin.dependencies then
      for _, dependency in ipairs(plugin.dependencies) do
        expected["opt/" .. dependency.name] = true
      end
    end
  end

  local removed = {}

  -- Iterate over start and opt folders
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = M.config.plugin_root .. "/" .. type
    for _, dir in ipairs(vim.fn.readdir(type_path)) do
      local key = type .. "/" .. dir
      if not expected[key] then
        local full_path = type_path .. "/" .. dir
        vim.fn.delete(full_path, "rf")
        table.insert(removed, key)
      end
    end
  end

  if #removed > 0 then
    log.info("Removed unused plugins:")
    for _, name in ipairs(removed) do
      vim.notify("   └─ " .. name)
    end
  else
    log.success("No unused plugins to clean.")
  end
end

-- Clean, Install, and Update existing plugins to latest version
local function plugin_sync()
  plugin_clean()
  plugin_install()
  plugin_update()
end

-- Global setup
function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
  for _, plugin in ipairs(M.config.plugins.start or {}) do
    if plugin_exists("start", plugin.name) then
      -- Check for dependencies
      for _, dependency in ipairs(plugin.dependencies or {}) do
        if dependency.config then
          bootstrap(dependency)
        end
      end
      if plugin.config then
        bootstrap(plugin)
      end
    else
      log.warn(string.format("Plugin not found: %s (Try running :PluginInstall)", plugin.name))
    end
  end
end

-- Commands
vim.api.nvim_create_user_command("PluginInstall", plugin_install, {})
vim.api.nvim_create_user_command("PluginUpdate", plugin_update, {})
vim.api.nvim_create_user_command("PluginList", plugin_list, {})
vim.api.nvim_create_user_command("PluginClean", plugin_clean, {})
vim.api.nvim_create_user_command("PluginSync", plugin_sync, {})

return M
