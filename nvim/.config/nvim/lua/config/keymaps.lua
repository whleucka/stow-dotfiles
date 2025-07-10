local map = vim.keymap.set
local opts = { silent = true, noremap = true }
local explorer = require("config.lib.explorer")
local buffer = require("config.lib.buffer")
local terminal = require("config.lib.terminal")

vim.g.mapleader = " "

-- Basic shit
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>qq", ":qa<CR>", opts)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
map("n", "q", "<Nop>", opts)

-- Yanking
map("v", "<leader>y", '"+y', opts)
map("n", "<leader>Y", "ggVGy", opts)

-- Buffers
map("n", "H", function()
  buffer.switch(false)
end, opts)
map("n", "L", function()
  buffer.switch(true)
end, opts)
map("n", "<leader>bd", ":bp | bd #<CR>", opts)

-- Splits
map("n", "<leader>\\", ":vsplit<CR>", opts)
map("n", "<leader>-", ":split<CR>",  opts)

-- Terminal
map("n", "<leader>ts", function()
  terminal.toggle({
    cmd = vim.o.shell,
    direction = "horizontal",
    key = "shell",
    size = 12
  })
end, opts)
map("n", "<leader>tv", function()
  terminal.toggle({
    cmd = vim.o.shell,
    direction = "vertical",
    key = "shell",
    size = 75
  })
end, opts)
map("n", "<leader>tf", function()
  terminal.toggle({
    cmd = vim.o.shell,
    key = "shell-float",
    float = true,
    width = 150,
    height = 40,
    border = "rounded",
    startinsert = true,
  })
end, opts)
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
map("t", "<Esc>", [[<C-\><C-n>:close<CR>]], opts)

-- Git
map("n", "<leader>gb", function()
  local file = vim.fn.expand("%:p")
  local blame_cmd = string.format("git blame --color-by-age --date=short %s", file)
  terminal.toggle({
    key = "git-blame",
    cmd = blame_cmd,
  })
end, opt)
map("n", "<leader>gbl", function()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local blame_cmd = string.format("git blame --color-by-age --date=short -L %d,%d %s", line, line, file)
  terminal.toggle({
    key = "git-blame-line",
    cmd = blame_cmd,
    direction = "horizontal",
    size = 10
  })
end, opt)
map("n", "<leader>gd", function()
  terminal.toggle({
    key = "git-diff",
    cmd = "git diff HEAD --color=always",
  })
end, opt)
map("n", "<leader>gs", function()
  terminal.toggle({
    key = "git-status",
    cmd = "git status",
  })
end, opt)
map("n", "<leader>gl", function()
  terminal.toggle({
    key = "git-log",
    cmd = 'git log --graph --abbrev-commit --decorate --date=relative --format="%C(yellow)%h%Creset%C(auto)%d %Cgreen%ad %Cblue%an%Creset %s"',
  })
end, opt)

-- AI
map("n", "<leader>ai", function()
  terminal.toggle({
    cmd = "gemini",
    key = "gemini"
  })
end, opt)


-- Scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Indent lines
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Moving lines
map("v", "J", ":m '>+1<CR>gv-gv", opts)
map("v", "K", ":m '<-2<CR>gv-gv", opts)

-- Window nav
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Quickfix
map("n", "q[", ":cprev<CR>zz", opts)
map("n", "q]", ":cnext<CR>zz", opts)

-- File explorer
-- map("n", "<leader>e", explorer.toggle_netrw, opts)

-- Search files
map("n", "<leader>s", explorer.grep_files, opts)

-- Find files
map("n", "<leader>f", explorer.find_files, opts)
