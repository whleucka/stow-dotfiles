local plugin_list = {}

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
  if file ~= "init.lua" and file:match("%.lua$") then
    local name = file:gsub("%.lua$", "")
    local ok, plugin = pcall(require, "plugins." .. name)
    if ok and type(plugin) == "table" then
      table.insert(plugin_list, plugin)
    else
      vim.notify("❌ Failed to load plugin: " .. file, vim.log.levels.ERROR)
    end
  end
end

return {
  start = plugin_list,
  opt = {}, -- extend later if needed
}
