-- This file will contain all non-plugin specific keymaps
local explorer = require("lib.system.explorer")
local terminal = require("lib.system.terminal")
local opts = require("lib.system.utils").keymap.opts
local map = require("lib.system.utils").keymap.map

vim.g.mapleader = " "

-- Basic shit
map("n", "<leader>w", ":update<CR>", opts)
map("n", "<leader>q", ":bp | bd #<CR>", opts)
map("n", "<leader>qq", ":q<CR>", opts)
map("n", "<leader>Q", ":qa<CR>", opts)
map("n", "<Esc>", ":nohlsearch<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
map("n", "q", "<Nop>", opts)

-- Yank entire file to system clipboard
map("n", "<leader>Y", 'ggVG"+y', opts)
-- Yank to system clipboard
map({ "n", "v" }, "y", '"+y', opts)

-- LSP
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "gt", vim.lsp.buf.type_definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map({ "n", "v" }, "<C-p>", function()
  vim.lsp.buf.format()
  vim.notify("Format complete")
end, opts)

-- Terminal
map("n", "<leader>th", function()
  terminal.toggle({
    key = "shell-horizontal",
    cmd = vim.o.shell,
    direction = "horizontal",
    size = 12
  })
end, opts)
map("n", "<leader>tv", function()
  terminal.toggle({
    key = "shell-vertical",
    cmd = vim.o.shell,
    direction = "vertical",
    size = 75
  })
end, opts)
map("n", "<leader>tf", function()
  terminal.toggle({
    key = "shell-float",
    cmd = vim.o.shell,
    float = true,
    width = '60%',
    height = '70%',
    border = "rounded",
  })
end, opts)
map("n", "<C-/>", function()
  terminal.toggle({
    key = "shell-smart",
    cmd = vim.o.shell,
  })
end, opts)
map("n", "<leader>tt", function()
  terminal.toggle({
    key = "top",
    cmd = "command -v htop >/dev/null && htop || top",
    float = true,
    width = '80%',
    height = '80%',
    border = "rounded",
  })
end, opts)
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
map("t", "<C-c>", [[<C-\><C-n>:close<CR>]], opts)

-- AI
map("n", "<leader>ai", function()
  terminal.toggle({
    cmd = "gemini",
    key = "gemini"
  })
end, opts)

-- Scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Center screen on search result jump
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Indent lines
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Moving lines
map("v", "J", ":m '>+1<CR>gv-gv", opts)
map("v", "K", ":m '<-2<CR>gv-gv", opts)

-- Grep files
map("n", "<leader>g", explorer.grep_files, opts)

-- Find files
map("n", "<leader>f", explorer.find_files, opts)
