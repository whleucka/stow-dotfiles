vim.pack.add({
  {
    src = "https://github.com/onsails/lspkind.nvim",
  },
  {
    src = "https://github.com/Saghen/blink.cmp",
    version = "v1.6.0"
  }
})

local config = require("config.blink")
require("blink.cmp").setup(config)
