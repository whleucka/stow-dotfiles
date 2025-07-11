local map = vim.keymap.set
local opts = { silent = true, noremap = true }
local explorer = require("whleucka.lib.explorer")
local buffer = require("whleucka.lib.buffer")
local terminal = require("whleucka.lib.terminal")

vim.g.mapleader = " "

-- Basic shit
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>qq", ":qa<CR>", opts)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
map("n", "q", "<Nop>", { expr = true, silent = true })

-- Reload config
map("n", "<F5>", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^whleucka") then
      package.loaded[name] = nil
    end
  end

  require("whleucka")

  vim.notify("🔁 Reloaded config!")
end, opts)

-- Yank entire file to system clipboard
map("n", "<leader>Y", 'ggVG"+y', opts)
-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', opts)


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

-- Git
map("n", "<leader>gb", function()
  local file = vim.fn.expand("%:p")
  local blame_cmd = string.format("git blame --color-by-age --date=short %s", file)
  terminal.toggle({
    key = "git-blame",
    cmd = blame_cmd,
  })
end, opts)
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
end, opts)
map("n", "<leader>gd", function()
  terminal.toggle({
    key = "git-diff",
    cmd = "git diff HEAD --color=always",
  })
end, opts)
map("n", "<leader>gs", function()
  terminal.toggle({
    key = "git-status",
    cmd = "git status",
  })
end, opts)
map("n", "<leader>gl", function()
  terminal.toggle({
    key = "git-log",
    cmd = 'git log --graph --abbrev-commit --decorate --date=relative --format="%C(yellow)%h%Creset%C(auto)%d %Cgreen%ad %Cblue%an%Creset %s"',
  })
end, opts)

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

-- Resizing splits
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":resize -2<CR>", opts)
map("n", "<C-Right>", ":resize +2<CR>", opts)

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
