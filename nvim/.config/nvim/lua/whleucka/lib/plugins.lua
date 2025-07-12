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
local function get_plugin_path(type, name)
  return string.format("%s/%s/%s", base_path, type, name)
end

--- Checks if a plugin directory exists.
local function plugin_exists(type, name)
  return vim.fn.isdirectory(get_plugin_path(type, name)) == 1
end

--- Clones a plugin from a git repository.
local function clone_plugin(plugin, type)
  if not plugin.name then
    plugin.name = plugin.url:match(".*/(.-)%.git$") or plugin.url:match(".*/(.-)$")
  end
  local path = get_plugin_path(type, plugin.name)
  if not plugin_exists(type, plugin.name) then
    vim.notify(string.format("📦 Installing [%s] (%s)...", plugin.name, type))
    local cmd = string.format("git clone --quiet %s %s", plugin.url, path)
    os.execute(cmd)
    vim.notify(string.format("✅ Installed %s → %s", plugin.name, path))
  else
    vim.notify(string.format("✅ %s (%s) already installed.", plugin.name, type), vim.log.levels.INFO)
  end
  vim.notify("✅ Plugin installation complete.")
end

--- Installs plugins defined in the configuration.
--- Creates the necessary directories and clones the plugins.
function M.install()
  local plugins = require("whleucka.plugins")
  local options = vim.tbl_deep_extend("force", default, plugins)

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

--- Lists all installed plugins.
function M.list()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = base_path .. "/" .. type
    if vim.fn.isdirectory(type_path) == 1 then
      local plugins = vim.fn.readdir(type_path)
      if #plugins > 0 then
        vim.notify("📦 " .. type .. " plugins:")
        for _, name in ipairs(plugins) do
          vim.notify("   └─ " .. name)
        end
      else
        vim.notify("📦 " .. type .. " plugins: (none)")
      end
    else
      vim.notify("📦 " .. type .. " plugins: (directory missing)")
    end
  end
end

--- Runs the setup function for configured start plugins.
function M.setup(opts)
  local plugins = require("whleucka.plugins")
  local options = vim.tbl_deep_extend("force", default, plugins)
  local type = "start" -- Only setup start plugins automatically

  for _, plugin in ipairs(options[type] or {}) do
    if plugin_exists(type, plugin.name) then
      if plugin.setup then
        local ok, err = pcall(plugin.setup)
        if not ok then
          vim.notify("⚠️ Error in setup for " .. plugin.name .. ": " .. err, vim.log.levels.ERROR)
        end
      end
    else
      local msg = string.format("⁉️ Plugin not found: %s (Try running :PluginInstall)", plugin.name)
      vim.notify(msg, vim.log.levels.WARN)
    end
  end
end

--- Removes any installed plugins that are no longer in the configuration.
function M.clean()
  local plugins = require("whleucka.plugins")
  local options = vim.tbl_deep_extend("force", default, plugins)

  -- Get list of expected plugin names
  local expected = {}
  for _, plugin in ipairs(options.start or {}) do
    expected["start/" .. plugin.name] = true
  end
  for _, plugin in ipairs(options.opt or {}) do
    expected["opt/" .. plugin.name] = true
  end

  local removed = {}

  -- Iterate over start and opt folders
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = base_path .. "/" .. type
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
    vim.notify("🗑️ Removed unused plugins:")
    for _, name in ipairs(removed) do
      vim.notify("   └─ " .. name)
    end
  else
    vim.notify("✅ No unused plugins to clean.")
  end
end

vim.api.nvim_create_user_command("PluginInstall", M.install, {})
vim.api.nvim_create_user_command("PluginUpdate", M.update, {})
vim.api.nvim_create_user_command("PluginList", M.list, {})
vim.api.nvim_create_user_command("PluginClean", M.clean, {})
vim.api.nvim_create_user_command("PluginSync", function()
  M.install()
  M.update()
  M.clean()
end, {})

return M
