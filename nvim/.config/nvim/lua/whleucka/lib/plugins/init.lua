local M = {}

local base_path = vim.fn.stdpath("data") .. "/site/pack/base"

local default = {
  start = {},
  opt = {},
}

local function get_plugin_path(type, name)
  return string.format("%s/%s/%s", base_path, type, name)
end

local function plugin_exists(type, name)
  return vim.fn.isdirectory(get_plugin_path(type, name)) == 1
end

local function clone_plugin(plugin, type)
  local path = get_plugin_path(type, plugin.name)
  if not plugin_exists(type, plugin.name) then
    local cmd = string.format("git clone --quiet %s %s", plugin.url, path)
    print(string.format("📦 Installing [%s] (%s)...", plugin.name, type))
    os.execute(cmd)
    print(string.format("✅ Installed %s → %s", plugin.name, path))
  else
    print(string.format("🟢 %s (%s) already installed.", plugin.name, type))
  end
end

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

function M.update()
  for _, type in ipairs({ "start", "opt" }) do
    local type_path = base_path .. "/" .. type
    for _, dir in ipairs(vim.fn.readdir(type_path)) do
      local full_path = type_path .. "/" .. dir
      if vim.fn.isdirectory(full_path .. "/.git") == 1 then
        print("🔄 Updating " .. dir)
        os.execute(string.format("cd %s && git pull --quiet > /dev/null 2>&1", full_path))
      end
    end
  end
  print("✅ Plugin update complete.")
end

function M.lazy(plugin)
  local cmd = string.format("packadd %s", plugin)
  vim.cmd(cmd)
end

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

function M.clean()
  print("WIP")
end

vim.api.nvim_create_user_command("PluginInstall", function()
  M.install(require("whleucka.plugins"))
end, {})
vim.api.nvim_create_user_command("PluginUpdate", M.update, {})
vim.api.nvim_create_user_command("PluginList", M.list, {})

return M
