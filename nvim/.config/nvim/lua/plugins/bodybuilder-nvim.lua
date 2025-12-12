vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/whleucka/bodybuilder.nvim"
})

-- See https://github.com/ollama/ollama
local config = require("config.bodybuilder")
require("bodybuilder").setup(config)
