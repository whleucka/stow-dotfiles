vim.pack.add({
  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
  }
})

local wk = require("which-key")
local gitsigns = require("gitsigns")
wk.add({
    {
      "<leader>gh",
      group = "Hunk",
      { "<leader>ghs", gitsigns.stage_hunk,          desc = "Stage" },
      { "<leader>ghr", gitsigns.reset_hunk,          desc = "Reset" },
      { "<leader>ghp", gitsigns.preview_hunk,        desc = "Preview" },
      { "<leader>ghi", gitsigns.preview_hunk_inline, desc = "Preview inline" },
      {
        "<leader>ghb",
        function()
          gitsigns.blame_line({ full = true })
        end,
        desc = "Blame line"
      },
    }
})
