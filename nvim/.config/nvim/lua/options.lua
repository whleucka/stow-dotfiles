-- Options
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

-- General
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.guicursor=''
--cmd 'set mouse+=a'
opt.hidden = true
opt.errorbells = false

-- Text rendering
opt.encoding = 'utf-8'
opt.wrap = false
opt.scrolloff = 8
opt.textwidth = 80
opt.list = true

-- Indentation
opt.shiftround = true
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

-- Status line
opt.showmode = false
opt.laststatus=3

-- Line numbers
opt.nu = true
opt.relativenumber = true

-- Undo
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.undodir= fn.stdpath('config') .. '/undodir'

-- CMD / Sign column
opt.cmdheight = 2
opt.signcolumn = 'yes:1'
opt.updatetime = 750
opt.shortmess:append("c")

-- Searching
opt.hlsearch = true
opt.cursorline = true
opt.incsearch = true
opt.smartcase = true
opt.ignorecase = true
opt.showmatch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Folding
vim.cmd([[
  set nofoldenable
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]])

-- Clipboard
cmd 'set clipboard+=unnamedplus'

-- Italics
cmd 'set t_ZH=^[[3m'
cmd 'set t_ZR=^[[23m'

-- Kitty stuff
cmd "let &t_ut=''"

-- Theme
opt.termguicolors = true
g.gruvbox_contrast_dark = 'hard'
g.gruvbox_transparent_bg = 1
g.gruvbox_bold = 1
g.gruvbox_italic = 1
g.gruvbox_italicize_comments = 1
--g.gruvbox_italicize_strings = 1
cmd 'colorscheme gruvbox'
cmd 'hi Normal guibg=NONE ctermbg=NONE guisp=#ff3030'

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=500})
augroup END
]])
