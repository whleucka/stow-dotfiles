vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  }
})

local config = require("config.catppuccin")
require("catppuccin").setup(config)

vim.cmd.colorscheme "catppuccin"
