local M = {}
local log = require("lib.utils").log
local plugin_root = vim.fn.stdpath("data") .. "/site/pack/plugins"
local plugins = require("plugins")

-- Configuration
local default_config = {
  plugin_root = plugin_root,
  plugins = plugins,
  loaded = {}
}

M.config = vim.deepcopy(default_config)

-- This will run the config function in the plugin configuration
local function run_config(plugin)
  local ok, err = pcall(plugin.config)
  if not ok then
    log.error(string.format("Error in config for %s: %s", plugin.name, err))
  end
end

-- Get plugin type path (opt, start)
local function get_plugin_type_path(type)
  return string.format("%s/%s", M.config.plugin_root, type)
end

-- Get the plugin path
local function get_plugin_path(type, name)
  return string.format("%s/%s", get_plugin_type_path(type), name)
end

-- Does the plugin exist?
local function plugin_exists(type, name)
  return vim.fn.isdirectory(get_plugin_path(type, name)) == 1
end

-- Stream cmd output to vim notify
local function run_shell_command_stream(plugin, cmd)
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local handle
  handle = vim.loop.spawn("sh", {
    args = { "-c", cmd },
    stdio = { nil, stdout, stderr },
  }, function(code, _)
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

-- Build plugin (run shell command)
local function build(type, plugin)
  log.info(string.format("Building %s in the background.", plugin.name))
  local plugin_path = get_plugin_path(type, plugin.name)
  local cmd = string.format("cd %s && %s", plugin_path, plugin.build)
  run_shell_command_stream(plugin, cmd)
end

-- Create plugin directories
local function create_plugin_directories()
  for _, type in ipairs({ "start", "opt" }) do
    local path = get_plugin_type_path(type)
    vim.fn.mkdir(path, "p")
  end
end

-- Clone plugin (git clone)
local function clone_plugin(type, plugin)
  local plugin_path = get_plugin_path(type, plugin.name)
  if not plugin_exists(type, plugin.name) then
    log.system(string.format("Installing [%s] (%s)...", plugin.name, type))
    os.execute(string.format("git clone --quiet %s %s", plugin.url, plugin_path))
    log.success(string.format("Installed %s → %s", plugin.name, plugin_path))
    return true
  else
    log.info(string.format("%s (%s) already installed.", plugin.name, type))
    return false
  end
end

-- Pull plugin (git pull)
local function pull_plugin(type, plugin)
  local plugin_path = get_plugin_path(type, plugin.name)
  -- If a git directory exists, pull update
  if vim.fn.isdirectory(plugin_path .. "/.git") == 1 then
    log.system(string.format("Updating [%s] (%s)...", plugin.name, type))
    os.execute(string.format("git -C %s pull --quiet", plugin_path))
    log.success(string.format("Updated %s → %s", plugin.name, plugin_path))
  end
end

-- Install & build plugins recursively
local function install(type, plugins)
  for _, plugin in ipairs(plugins or {}) do
    -- Install dependencies
    if plugin.dependencies then
      install(type, plugin.dependencies)
    end
    -- Install plugin
    local cloned = clone_plugin(type, plugin)
    if plugin.build and cloned then
      build(type, plugin)
    end
  end
end

-- Plugin install command
local function plugin_install()
  create_plugin_directories()
  for _, type in ipairs({ "start", "opt" }) do
    install(type, M.config.plugins[type])
  end
  log.success("Plugin installation complete.")
end

-- Load plugins
local function load_plugins(type, plugins)
  -- Sort the plugins by priority
  table.sort(plugins, function(a, b)
    local a_p = a.priority or 0
    local b_p = b.priority or 0
    return a_p < b_p
  end)
  for _, plugin in ipairs(plugins or {}) do
    table.insert(M.config.loaded, string.format("(%s) %s", type, plugin.name))
    if plugin_exists(type, plugin.name) then
      -- Load dependencies
      if plugin.dependencies then
        load_plugins(type, plugin.dependencies)
      end
      -- Run plugin config
      if plugin.config then
        run_config(plugin)
      end
    else
      log.warn(string.format("Plugin not found: %s (Try running :PluginInstall)", plugin.name))
    end
  end
end

-- Update & build plugins recursively
local function update(type, plugins)
  for _, plugin in ipairs(plugins or {}) do
    -- Update dependencies
    if plugin.dependencies then
      update(type, plugin.dependencies)
    end
    -- Update plugin
    pull_plugin(type, plugin)
    if plugin.build then
      build(type, plugin)
    end
  end
end

-- Update plugin command
local function plugin_update()
  for _, type in ipairs({ "start", "opt" }) do
    update(type, M.config.plugins[type])
  end
  log.success("Plugin update complete.")
end

-- Plugin list command
local function plugin_loaded()
  log.info("Loaded plugins")
  for _, name in ipairs(M.config.loaded or {}) do
    vim.notify("   └─ " .. name)
  end
end

--- Plugin list command
local function plugin_list()
  for _, type in ipairs({ "start", "opt" }) do
    log.info(type .. " plugins:")
    for _, plugin in ipairs(M.config.plugins[type] or {}) do
      if plugin_exists(type, plugin.name) then
        vim.notify("   └─ " .. plugin.name)
      end
    end
  end
end

-- Recursively build list of expected plugins
local function get_expected(plugins, expected)
  for _, plugin in ipairs(plugins or {}) do
    if plugin.dependencies then
      expected = get_expected(plugin.dependencies, expected)
    end
    -- Insert into expected
    local key = plugin.name
    expected[key] = true
  end
  return expected
end

-- Plugin clean command
-- Removes unused plugins
local function plugin_clean()
  local removed = {}
  for _, type in ipairs({ "start", "opt" }) do
    local expected = get_expected(M.config.plugins[type], {})
    local path = get_plugin_type_path(type)
    for _, name in ipairs(vim.fn.readdir(path)) do
      local key = name
      if not expected[key] then
        local plugin_path = get_plugin_path(type, name)
        vim.fn.delete(plugin_path, "rf")
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

-- Plugin sync command
local function plugin_sync()
  plugin_clean()
  plugin_install()
  plugin_update()
end

-- Global setup
function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
  -- Start plugins get loaded automagically
  load_plugins("start", M.config.plugins.start)
end

-- Commands
vim.api.nvim_create_user_command("PluginInstall", plugin_install, {})
vim.api.nvim_create_user_command("PluginUpdate", plugin_update, {})
vim.api.nvim_create_user_command("PluginList", plugin_list, {})
vim.api.nvim_create_user_command("PluginLoaded", plugin_loaded, {})
vim.api.nvim_create_user_command("PluginClean", plugin_clean, {})
vim.api.nvim_create_user_command("PluginSync", plugin_sync, {})

return M
