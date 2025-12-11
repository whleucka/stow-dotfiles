vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/whleucka/bodybuilder-nvim"
})

require("bodybuilder").setup({
  model = "gemma3:270m",
  keymap = "<leader>af",
})
