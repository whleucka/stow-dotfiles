local map = vim.keymap.set
local opts = { silent = true, noremap = true }
local explorer = require("lib.system.explorer")
local terminal = require("lib.system.terminal")

vim.g.mapleader = " "

-- Basic shit
map("n", "<leader>w", ":update<CR>", opts)
map("n", "<leader>q", ":bp | bd #<CR>", opts)
map("n", "<C-w>", ":q!<CR>", opts)
map("n", "<leader>qq", ":qa<CR>", opts)
map("n", "<Esc>", ":nohlsearch<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)
map("n", "q", "<Nop>", opts)

-- Yank entire file to system clipboard
map("n", "<leader>Y", 'ggVG"+y', opts)
-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', opts)

-- Git
map("n", "<leader>gs",  ":G<CR>", opts)                         -- git status
map("n", "<leader>gdf", ":Gdiff<CR>", opts)                     -- diff current file
map("n", "<leader>gdt", ":G difftool<CR>", opts)                -- external diff tool
map("n", "<leader>gb",  ":G blame<CR>", opts)                   -- git blame
map("n", "<leader>gpl", ":G pull<CR>", opts)                    -- git pull
map("n", "<leader>gpu", ":G push<CR>", opts)                    -- git push
map("n", "<leader>gco", ":G checkout<Space>", opts)            -- checkout branch
map("n", "<leader>gbr", ":G branch<CR>", opts)                  -- list branches
map("n", "<leader>gm",  ":G merge<Space>", opts)                -- git merge
map("n", "<leader>gmt", ":G mergetool<CR>", opts)               -- git mergetool
map("n", "<leader>gl",  ":G log<CR>", opts)                     -- git log
map("n", "<leader>ga",  ":G add .<CR>", opts)                   -- git add all
map("n", "<leader>gc",  ":G commit<Space>", opts)               -- git commit
map("n", "<leader>gcm", ":G commit -m ''<Left>", opts)          -- commit with inline message
map("n", "<leader>grb", ":G rebase -i HEAD~", opts)             -- rebase
map("n", "<leader>gW",  ":Gwrite<CR>", opts)                    -- stage file
map("n", "<leader>gR",  ":Gread<CR>", opts)                     -- reset file

-- Buffers
map("n", "H", ":BufferLineCyclePrev<CR>", opts)
map("n", "L", ":BufferLineCycleNext<CR>", opts)
map("n", "<C-,>", ":BufferLineMovePrev<CR>", opts)
map("n", "<C-.>", ":BufferLineMoveNext<CR>", opts)
map("n", "<leader>bd", ":bp | bd #<CR>", opts)
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>br", ":BufferLineCloseRight<CR>", opts)
-- Formatting
map({ "n", "v" }, "<leader>bf", function()
  vim.lsp.buf.format()
  vim.notify("Format complete")
end, opts)


-- Splits
map("n", "<leader>\\", ":vsplit<CR>", opts)
map("n", "<leader>-", ":split<CR>", opts)

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

-- File explorer
map("n", "<leader>e", ":Neotree toggle<CR>", opts)

-- Search files
map("n", "<leader>s", explorer.grep_files, opts)

-- Find files
map("n", "<leader>f", explorer.find_files, opts)

-- Splits
map('n', '<C-Left>', require('smart-splits').resize_left)
map('n', '<C-Down>', require('smart-splits').resize_down)
map('n', '<C-Up>', require('smart-splits').resize_up)
map('n', '<C-Right>', require('smart-splits').resize_right)

map('n', '<C-h>', require('smart-splits').move_cursor_left)
map('n', '<C-j>', require('smart-splits').move_cursor_down)
map('n', '<C-k>', require('smart-splits').move_cursor_up)
map('n', '<C-l>', require('smart-splits').move_cursor_right)

map('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
map('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
map('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
map('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
