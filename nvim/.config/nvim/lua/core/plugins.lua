-- Core plugins module
-- The goal of this file is to build the plugin manager config
local log = require("lib.utils").log
local data_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start"
local module_path = vim.fn.stdpath("config") .. "/lua/plugins"

-- Is this a lua file?
local function is_lua_file(file)
  return file:match("%.lua$")
end

-- Get lua module name
local function get_module_name(file)
  return file:gsub("%.lua$", "")
end

-- Get plugin basename
local function basename(url)
  return url:match("([^/]+)$")
end

-- Create plugins path
local function create_plugins_data_path(data_path)
    vim.fn.mkdir(data_path, "p")
end

-- Get the plugin path
local function get_plugin_path(data_path, name)
  return string.format("%s/%s", data_path, name)
end

-- Massage the plugins recursively
local function massage(data_path, plugins)
  for _, plugin in ipairs(plugins or {}) do
    if plugin.dependencies then
      plugin.dependencies = massage(data_path, plugin.dependencies)
    end
    -- Use the basename if name is not set
    if plugin.name == nil then
      plugin.name = basename(plugin.url)
    end
    -- Add plugin path
    plugin.path = get_plugin_path(data_path, plugin.name)
  end
  return plugins
end

-- Use pcall to require all the plugins in the specified path
-- The plugin tables are stored in the config
local function get_plugins(module_path)
  local plugins = {}
  local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins"
  for _, file in ipairs(vim.fn.readdir(module_path)) do
    if is_lua_file(file) then
      local name = get_module_name(file)
      local ok, plugin = pcall(require, "plugins." .. name)
      if ok and type(plugin) == "table" then
        table.insert(plugins, plugin)
      else
        log.error("Failed to load plugin: " .. file)
      end
    end
  end
  return plugins
end

local M = {
  config = {
    data_path = data_path,
    module_path = module_path,
    plugins = {},
  }
}

function M.setup(user_config)
  local plugin_manager = require("lib.plugin_manager")
  -- Merge the config
  M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

  -- Prepare the plugins
  create_plugins_data_path(M.config.data_path)
  local plugins = get_plugins(M.config.module_path)
  M.config.plugins = massage(M.config.data_path, plugins)

  -- Load plugins
  plugin_manager.load_plugins()
end

return M
