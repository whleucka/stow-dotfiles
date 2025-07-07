local opt = vim.opt
local g = vim.g

-- UI
opt.number = true                   -- show line numbers
opt.relativenumber = true           -- hybrid line numbers
opt.cursorline = true               -- highlight current line
opt.signcolumn = "yes"              -- always show sign column
opt.termguicolors = true            -- 24-bit RGB
opt.scrolloff = 8                   -- keep lines above/below cursor
opt.sidescrolloff = 8
opt.wrap = false                    -- no line wrapping
opt.linebreak = true                -- wrap at word boundary if wrap is on

-- Indentation
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true             -- use spaces instead of tabs
vim.bo.autoindent = true
vim.bo.smartindent = true

-- Search
opt.ignorecase = true               -- case-insensitive by default
opt.smartcase = true                -- but case-sensitive if uppercase used
opt.incsearch = true                -- show matches as you type
opt.hlsearch = true                 -- highlight all matches

-- Files
opt.swapfile = false                -- no .swp files
opt.backup = false                  -- no backup files
opt.undofile = true                 -- persistent undo
opt.undolevels = 10000              -- lots of undo history

-- Completion
opt.wildmenu = true
opt.wildmode = { "longest", "full" }

-- Clipboard
opt.clipboard = "unnamedplus"       -- use system clipboard by default

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.lazyredraw = true               -- faster macro execution
opt.updatetime = 250                -- lower = faster CursorHold events
opt.timeoutlen = 300                -- lower = snappier mappings

-- Misc
opt.mouse = "a"                     -- enable mouse in all modes
opt.hidden = true                   -- allow unsaved buffers in background
opt.conceallevel = 2                -- conceal markdown, json, etc.
opt.completeopt = { "menu", "menuone", "noselect" }

-- UI Noise reduction
opt.showmode = false                -- we use a statusline instead
opt.ruler = false
opt.laststatus = 3                  -- global statusline (Neovim 0.7+)

-- Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_browse_split = 4     -- Open files in previous window (the main one)
-- vim.g.netrw_altv = 1             -- Vertical splits open to the right
-- vim.g.netrw_winsize = 30         -- Sidebar width
-- vim.g.netrw_liststyle = 3        -- Tree view style
-- vim.g.netrw_banner = 0           -- No banner
