vim.pack.add({
  {
    src = "https://github.com/stevearc/oil.nvim"
  },
  {
    src = "https://github.com/nvim-tree/nvim-web-devicons",
  }
})

require("oil").setup()

local wk = require("which-key")
wk.add({
  { "<leader>o", ":Oil<CR>", desc = "Oil" },
})
