---@diagnostic disable: missing-fields
return {
  'akinsho/bufferline.nvim',
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
            text = " WILL HLEUCKA",
            separator = true,
            text_align = "center"
          }
        },
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
