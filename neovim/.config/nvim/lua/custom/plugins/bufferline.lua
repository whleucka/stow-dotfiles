return {
  'akinsho/bufferline.nvim',
  after = "catppuccin",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup {
      options = {
        diagnostics = "nvim_lsp"
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
