return {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    lazy = true,
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
}
