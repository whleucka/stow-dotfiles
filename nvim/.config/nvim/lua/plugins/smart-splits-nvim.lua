vim.pack.add({
  {
    src = "https://github.com/mrjones2014/smart-splits.nvim",
    name = "smart-splits",
  }
})

local config = require("config.smart-splits")
require("smart-splits").setup(config)

local wk = require("which-key")
wk.add({
  {
    mode = "n",
    { "<A-h>", require('smart-splits').resize_left, desc = "Split Resize Left" },
    { "<A-j>", require('smart-splits').resize_down, desc = "Split Resize Down" },
    { "<A-k>", require('smart-splits').resize_up, desc = "Split Resize Up" },
    { "<A-l>", require('smart-splits').resize_right, desc = "Split Resize Right" },

    { "<C-h>", require('smart-splits').move_cursor_left, desc = "Split Move Cursor Left" },
    { "<C-j>", require('smart-splits').move_cursor_down, desc = "Split Move Cursor Down" },
    { "<C-k>", require('smart-splits').move_cursor_up, desc = "Split Move Cursor Up" },
    { "<C-l>", require('smart-splits').move_cursor_right, desc = "Split Move Cursor Right" },
    { "<C-p>", require('smart-splits').move_cursor_previous, desc = "Split Move Cursor Previous" },

    { "<leader><leader>h", require('smart-splits').swap_buf_left, desc = "Split Swap Buffer Left" },
    { "<leader><leader>j", require('smart-splits').swap_buf_down, desc = "Split Swap Buffer Down" },
    { "<leader><leader>k", require('smart-splits').swap_buf_up, desc = "Split Swap Buffer Up" },
    { "<leader><leader>l", require('smart-splits').swap_buf_right, desc = "Split Swap Buffer Right" },
  },
})
