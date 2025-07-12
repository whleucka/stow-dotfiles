-- A simple plugin manager for Neovim.
local M = {}

-- The base path for all plugins.
local base_path = vim.fn.stdpath("data") .. "/site/pack/base"

-- Default plugin configuration structure.
local default = {
  start = {},
  opt = {},
}

--- Returns the full path for a given plugin.
--- @param type string "start" or "opt"
--- @param name string The name of the plugin
--- @return string The absolute path to the plugin
local function get_plugin_path(type, name)
  return string.format("%s/%s/%s", base_path, type, name)
end

--- Checks if a plugin directory exists.
--- @param type string "start" or "opt"
--- @param name string The name of the plugin
--- @return boolean
local function plugin_exists(type, name)
  return vim.fn.isdirectory(get_plugin_path(type, name)) == 1
end

--- Clones a plugin from a git repository.
--- @param plugin table The plugin table, expecting `name` and `url` keys.
--- @param type string "start" or "opt"
local function clone_plugin(plugin, type)
  local path = get_plugin_path(type, plugin.name)
  if not plugin_exists(type, plugin.name) then
    vim.notify(string.format("📦 Installing [%s] (%s)...", plugin.name, type))
    local cmd = string.format("git clone --quiet %s %s", plugin.url, path)
    os.execute(cmd)
    vim.notify(string.format("✅ Installed %s → %s", plugin.name, path))
  else
    vim.notify(string.format("🟢 %s (%s) already installed.", plugin.name, type), vim.log.levels.INFO)
  end
end

--- Installs plugins defined in the configuration.
--- Creates the necessary directories and clones the plugins.
--- @param opts table The plugin configuration, expects `start` and `opt` tables.
function M.install(opts)
  opts = opts or {}
  local options = vim.tbl_deep_extend("force", default, opts)

  vim.fn.mkdir(base_path .. "/start", "p")
  vim.fn.mkdir(base_path .. "/opt", "p")

  for _, plugin in ipairs(options.start or {}) do
    clone_plugin(plugin, "start")
  end

  for _, plugin in ipairs(options.opt or {}) do
    clone_plugin(plugin, "opt")
  end
end

--- Updates all installed plugins by pulling the latest changes from git.
function M.update()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = base_path .. "/" .. type
    if vim.fn.isdirectory(type_path) == 1 then
      for _, dir in ipairs(vim.fn.readdir(type_path)) do
        local full_path = type_path .. "/" .. dir
        if vim.fn.isdirectory(full_path .. "/.git") == 1 then
          vim.notify("🔄 Updating " .. dir)
          os.execute(string.format("git -C %s pull --quiet", full_path))
        end
      end
    end
  end
  vim.notify("✅ Plugin update complete.")
end

--- Lazily loads an optional plugin.
--- @param plugin string The name of the plugin to load.
function M.lazy(plugin)
  vim.cmd(string.format("packadd %s", plugin))
end

--- Lists all installed plugins.
function M.list()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = base_path .. "/" .. type
    if vim.fn.isdirectory(type_path) == 1 then
      local plugins = vim.fn.readdir(type_path)
      if #plugins > 0 then
        print("📦 " .. type .. " plugins:")
        for _, name in ipairs(plugins) do
          print("   └─ " .. name)
        end
      else
        print("📦 " .. type .. " plugins: (none)")
      end
    else
      print("📦 " .. type .. " plugins: (directory missing)")
    end
  end
end

--- Runs the setup function for configured start plugins.
--- @param opts table The plugin configuration.
function M.setup(opts)
  opts = opts or {}
  local options = vim.tbl_deep_extend("force", default, opts)
  local type = "start" -- Only setup start plugins automatically

  for _, plugin in ipairs(options[type] or {}) do
    if plugin_exists(type, plugin.name) then
      if plugin.setup then
        local ok, err = pcall(plugin.setup)
        if not ok then
          vim.notify("Error in setup for " .. plugin.name .. ": " .. err, vim.log.levels.ERROR)
        end
      end
    else
      vim.notify("Plugin not found: " .. plugin.name, vim.log.levels.WARN)
    end
  end
end

--- Removes any installed plugins that are no longer in the configuration.
--- (Not yet implemented)
function M.clean()
  vim.notify("`PluginClean` is not yet implemented.", vim.log.levels.WARN)
end

-- Create user commands for plugin management.
vim.api.nvim_create_user_command("PluginInstall", function()
  M.install(require("whleucka.plugins"))
end, {})

vim.api.nvim_create_user_command("PluginUpdate", M.update, {})

vim.api.nvim_create_user_command("PluginList", M.list, {})

vim.api.nvim_create_user_command("PluginClean", M.clean, {})

return M
