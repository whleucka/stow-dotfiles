-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Exit insert mode
map("i", "jk", "<C-c>", { desc = "Exit insert mode" })
map("i", "kj", "<C-c>", { desc = "Exit insert mode" })

-- Disable
map("n", "q", "<nop>")
