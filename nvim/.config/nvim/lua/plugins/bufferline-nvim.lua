vim.pack.add({
  {
    src = "https://github.com/akinsho/bufferline.nvim",
  }
})
if vim.g.colors_name == "catppuccin" then
  local ok, bufferline = pcall(require, "bufferline")
  if ok then
    bufferline.setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
else
    require("bufferline").setup()
end
