return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "ibhagwan/fzf-lua",
    },
    config = true,
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    }
}
