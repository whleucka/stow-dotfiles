return {
    "nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "php", "javascript", "json", "html", "css", "bash", "rust", "c" },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    scope_incremental = "<TAB>",
                    node_incremental = "<CR>",
                    node_decremental = "<BS>",
                },
            },
        })
    end,
}
