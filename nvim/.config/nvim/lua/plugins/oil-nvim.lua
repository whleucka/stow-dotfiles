vim.pack.add {
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons"
}

require("oil").setup({
  view_options = {
    show_preview = false,
  },
})

local wk = require("which-key")
wk.add({
  { "<leader>o", ":Oil<CR>", desc = "Oil" },
})
