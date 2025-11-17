vim.pack.add {
  "https://github.com/tpope/vim-fugitive"
}

local wk = require("which-key")
wk.add({
  {
    "<leader>g",
    group = "Git (fugitive)",
    { "<leader>gs", ":Git<CR>",           desc = "Status" },
    { "<leader>gb", ":Git blame<CR>",     desc = "Blame" },
    { "<leader>gl", ":0Gclog<CR>",        desc = "Log" },
    { "<leader>gO", ":Git checkout ",     desc = "Checkout" },
    { "<leader>gP", ":Git push<CR>",      desc = "Push" },
    { "<leader>gp", ":Git pull<CR>",      desc = "Pull" },
    { "<leader>gf", ":Git fetch<CR>",     desc = "Fetch" },
    { "<leader>ga", ":Git add %<CR>",     desc = "Add current file" },
    { "<leader>gC", ":Git commit -v<CR>", desc = "Commit" },
    { "<leader>gm", ":Git merge ",        desc = "Merge" },
    { "<leader>gd", ":Gvdiffsplit!<CR>",  desc = "Diff" },
    { "<leader>gD", ":diffoff!<CR>",      desc = "Quit diff mode" },
  },
})
