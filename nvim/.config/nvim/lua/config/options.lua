local opt = vim.opt
local g = vim.g
local bo = vim.bo
local wo = vim.wo

-- UI
opt.number = true         -- show line numbers
opt.relativenumber = true -- hybrid line numbers
opt.cursorline = true     -- highlight current line
opt.signcolumn = "yes"    -- always show sign column
opt.termguicolors = true  -- 24-bit RGB
opt.scrolloff = 8         -- keep lines above/below cursor
opt.sidescrolloff = 8
opt.wrap = false          -- no line wrapping
opt.linebreak = true      -- wrap at word boundary if wrap is on

-- Indentation
bo.shiftwidth = 2
bo.tabstop = 2
bo.softtabstop = 2
bo.expandtab = true -- use spaces instead of tabs
bo.autoindent = true
bo.smartindent = true

-- Search
opt.ignorecase = true -- case-insensitive by default
opt.smartcase = true  -- but case-sensitive if uppercase used
opt.incsearch = true  -- show matches as you type
opt.hlsearch = true   -- highlight all matches

-- Files
opt.swapfile = false   -- no .swp files
opt.backup = false     -- no backup files
opt.undofile = true    -- persistent undo
opt.undolevels = 10000 -- lots of undo history

-- Folds
wo.foldenable = true
wo.foldlevel = 99
opt.foldlevelstart = 99
wo.foldmethod = 'expr'
wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--opt.foldcolumn = '1'  -- or 'auto'
opt.fillchars = 'fold: '

-- Completion
opt.wildmenu = true
opt.wildmode = { "longest", "full" }

-- Clipboard
if vim.fn.has("nvim-0.10") == 1 then
  g.clipboard = {
    name = 'osc52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
else
  vim.opt.clipboard = "unnamedplus"
end

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.lazyredraw = true -- faster macro execution
opt.updatetime = 2000 -- lower = faster CursorHold events
opt.timeoutlen = 500  -- lower = snappier mappings

-- Misc
opt.mouse = "a"      -- enable mouse in all modes
opt.hidden = true    -- allow unsaved buffers in background
opt.conceallevel = 2 -- conceal markdown, json, etc.
opt.completeopt = { "menu", "menuone", "noselect" }

-- UI Noise reduction
opt.showmode = false -- we use a statusline instead
opt.ruler = false
opt.laststatus = 2

-- Netrw
g.netrw_browse_split = 4 -- Open files in previous window (the main one)
g.netrw_altv = 1         -- Vertical splits open to the right
g.netrw_winsize = 30     -- Sidebar width
g.netrw_liststyle = 3    -- Tree view style
g.netrw_banner = 0       -- No banner
