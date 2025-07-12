return {
  url = "https://github.com/neovim/nvim-lspconfig",
  name = "nvim-lspconfig",
  setup = function()
    -- PHP
    vim.lsp.enable("intelephense")
    -- Bash
    vim.lsp.enable('bashls')
  end
}
