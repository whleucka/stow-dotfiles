vim.pack.add({
  {
    src = "https://github.com/nvimdev/dashboard-nvim",
  }
})

local config = require("config.dashboard")
local wk = require("which-key")
require('dashboard').setup(config)

wk.add({
  '<leader><leader>', ":Dashboard<CR>", desc = "Dashboard"
})
