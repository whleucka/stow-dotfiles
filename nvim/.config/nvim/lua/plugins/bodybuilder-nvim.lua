vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/whleucka/bodybuilder-nvim"
})

-- See https://github.com/ollama/ollama
require("bodybuilder").setup({
  model = "llama3.2",
  url = "http://192.168.0.103:11434/api/generate",
  keymap = "<leader>af",
})
