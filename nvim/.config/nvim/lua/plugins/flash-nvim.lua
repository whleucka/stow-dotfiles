vim.pack.add {
  "https://github.com/folke/flash.nvim",
}

local flash = require("flash")
local wk = require("which-key")

wk.add({
  {
    mode = "o",
    {
      "r", flash.remote, desc = "Remote flash",
    },
  },
  {
    mode = { "n", "x", "o" },
    { "s", flash.jump,       desc = "Flash" },
    { "S", flash.treesitter, desc = "Flash treesitter" },
  },
  {
    mode = { "o", "x" },
    { "R", flash.treesitter_search, desc = "Treesitter search" },
  },
})
