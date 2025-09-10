vim.pack.add({
  {
    src = "https://github.com/akinsho/bufferline.nvim",
  }
})
require("bufferline").setup {
  highlights = require("catppuccin.groups.integrations.bufferline").get_theme()
}
