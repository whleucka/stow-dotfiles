local map = vim.keymap.set
local opts = { silent = true }
local explorer = require("config.lib.explorer")

vim.g.mapleader = " "

-- Basic shit
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>qq", ":qa<CR>", opts)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
map("n", "q", "<nop>", opts)

-- Yank file
map("n", "<leader>Y", "ggVGy", opts)

-- Buffers
map("n", "H", ":bprevious<CR>", opts)
map("n", "L", ":bnext<CR>", opts)
map("n", "<leader>bd", ":bp | bd #<CR>", opts)

-- Splits
map("n", "<leader>\\", ":vsplit<CR>", opts)
map("n", "<leader>-", ":split<CR>",  opts)

-- Terminal
map("n", "<leader>t", function()
  require("config.lib.terminal").toggle()
end, opts)
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
map("t", "jk", [[<C-\><C-n>]], opts)
map("t", "kj", [[<C-\><C-n>]], opts)


-- Window nav
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Quickfix
map("n", "q[", ":cprev<CR>zz", opts)
map("n", "q]", ":cnext<CR>zz", opts)

-- File explorer
map("n", "<leader>e", explorer.toggle_netrw, opts)

-- Search files
vim.keymap.set("n", "<leader>s", explorer.grep_files)

-- Find files
vim.keymap.set("n", "<leader>f", explorer.find_files)
