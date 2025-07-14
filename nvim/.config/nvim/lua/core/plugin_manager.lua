local M = {}
local log = require("lib.utils").log
local base_path = vim.fn.stdpath("data") .. "/site/pack/base"
local base = require("plugins")

-- Config
local default_config = {
  path = base_path,
  plugins = base,
}
vim.inspect(default_config)

M.config = vim.deepcopy(default_config)

-- Functions
local function bootstrap(plugin)
  local ok, err = pcall(plugin.config)
  if not ok then
    log.error(string.format("Error in config for %s: %s", plugin.name, err))
  end
end

local function get_plugin_path(type, name)
  return string.format("%s/%s/%s", M.config.path, type, name)
end

local function plugin_exists(type, name)
  return vim.fn.isdirectory(get_plugin_path(type, name)) == 1
end

local function clone(plugin, type)
  local path = get_plugin_path(type, plugin.name)
  if not plugin_exists(type, plugin.name) then
    log.info(string.format("Installing [%s] (%s)...", plugin.name, type))
    os.execute(string.format("git clone --quiet %s %s", plugin.url, path))
    log.success(string.format("Installed %s → %s", plugin.name, path))
    return true
  else
    log.success(string.format("%s (%s) already installed.", plugin.name, type))
    return false
  end
end

local function build(plugin)
    log.info("Building " .. plugin.name)
    local plugin_dir = vim.fn.stdpath("data") .. "/site/pack/base/start/" .. plugin.name
    local output = vim.fn.system("cd " .. plugin_dir .. " && " .. plugin.build)
    vim.notify(output)
    if vim.v.shell_error ~= 0 then
      log.error(string.format("Build failed for %s: %s", plugin.name, output))
    end
end

local function plugin_install()
  local plugins = M.config.plugins
  vim.inspect(plugins)
  local path = M.config.path
  local start_path = path .. "/start"
  local opt_path = path .. "/opt"

  -- Create base directories
  vim.fn.mkdir(start_path, "p")
  vim.fn.mkdir(opt_path, "p")

  -- Install start plugins
  for _, plugin in ipairs(plugins.start or {}) do
    -- Clone dependencies
    for _, dependency in ipairs(plugin.dependencies or {}) do
      local should_build = clone(dependency, "start")
      -- Check for build step
      if dependency.build and should_build then
        build(dependency)
      end
    end
    -- Clone plugin
    clone(plugin, "start")
  end

  -- Install opt plugins
  -- for _, plugin in ipairs(plugins.opt or {}) do
  --   clone(plugin, "opt")
  -- end

  log.success("Plugin installation complete.")
end

local function plugin_update()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = M.config.path .. "/" .. type
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

local function plugin_list()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = string.format("%s/%s", M.config.path, type)
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
    local type_path = M.config.path .. "/" .. type
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

local function plugin_sync()
  plugin_clean()
  plugin_install()
  plugin_update()
end

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
