vim.pack.add {
  "https://github.com/nvim-lualine/lualine.nvim"
}

local config = require("config.lualine")
require('lualine').setup(config)
