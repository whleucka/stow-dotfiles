return {
  'akinsho/bufferline.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  after = "catppuccin",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = 'thin',
        offsets = {
          {
            filetype = "neo-tree",
            text = "🇺🇦~*! Слава Україні !*~ 🇨🇦",
            separator = true,
            text_align = "center"
          }
        },
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
