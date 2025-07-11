local opt = vim.opt
local g = vim.g
local cmd = vim.cmd
local set_hl = vim.api.nvim_set_hl
local colour = require("catppuccin.palettes").get_palette "macchiato"

-- Theme
cmd.colorscheme("catppuccin")
function hl(type, opts)
  set_hl(0, type, opts)
end
hl("BufferLineBackground", { fg = colour.subtext0, bg = colour.base })
hl("BufferLineInactive", { fg = "#666666", bg = colour.base })
hl("BufferLineActive", { fg = "#444444", bg = colour.yellow, bold = true })
hl("StatusLine",  { fg = colour.subtext0, bg = "none" })
hl("StatusLineMode",  { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
hl("StatusLineFile",  { fg = "#cba6f7", bg = "none" })
hl("StatusLineGit",  { fg = "#a6e3a1", bg = "none" })
hl("StatusLineExtra",  { fg = "#bac2de", bg = "none" })

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

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.lazyredraw = true               -- faster macro execution
opt.updatetime = 2000                -- lower = faster CursorHold events
opt.timeoutlen = 500                -- lower = snappier mappings

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
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
-- g.netrw_browse_split = 4     -- Open files in previous window (the main one)
-- g.netrw_altv = 1             -- Vertical splits open to the right
-- g.netrw_winsize = 30         -- Sidebar width
-- g.netrw_liststyle = 3        -- Tree view style
-- g.netrw_banner = 0           -- No banner
