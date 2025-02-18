-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Exit insert mode
map("i", "jk", "<C-c>", { desc = "Exit insert mode" })
map("i", "kj", "<C-c>", { desc = "Exit insert mode" })

-- Save / update
map("n", "<leader>w", ":update<cr>", { desc = "Update" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- File picker
map("n", "<c-p>", function() require('fzf-lua').git_files() end, { desc = "Open recent files" })

-- Disable
map("n", "q", "<nop>")
