return {
  'akinsho/bufferline.nvim',
  after = "catppuccin",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    vim.opt.termguicolors = true
    require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
        custom = {
          all = {
            fill = { bg = "#1e1e2e" },
          },
          mocha = {
            background = { fg = mocha.text },
          },
          latte = {
            background = { fg = "#000000" },
          },
        },
      },
    }
  end
}
