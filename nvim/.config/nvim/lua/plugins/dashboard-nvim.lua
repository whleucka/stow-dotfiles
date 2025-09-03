vim.pack.add({
  {
    src = "https://github.com/nvimdev/dashboard-nvim",
  }
})

local config = require("config.dashboard")
require('dashboard').setup(config)
