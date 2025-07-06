local opt = vim.opt
local g = vim.g

-- UI
opt.number = true                 -- show line numbers
opt.relativenumber = true         -- hybrid line numbers
opt.cursorline = true             -- highlight current line
opt.signcolumn = "yes"            -- always show sign column
opt.termguicolors = true          -- 24-bit RGB
opt.scrolloff = 8                 -- keep lines above/below cursor
opt.sidescrolloff = 8
opt.wrap = false                  -- no line wrapping
opt.linebreak = true              -- wrap at word boundary if wrap is on

-- Indentation
opt.expandtab = true              -- use spaces instead of tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true             -- case-insensitive by default
opt.smartcase = true              -- but case-sensitive if uppercase used
opt.incsearch = true              -- show matches as you type
opt.hlsearch = true               -- highlight all matches

-- Files
opt.swapfile = false              -- no .swp files
opt.backup = false                -- no backup files
opt.undofile = true               -- persistent undo
opt.undolevels = 10000            -- lots of undo history

-- Completion
opt.wildmenu = true
opt.wildmode = { "longest", "full" }

-- Clipboard
opt.clipboard = "unnamedplus"    -- use system clipboard by default

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Performance
opt.lazyredraw = true            -- faster macro execution
opt.updatetime = 250             -- lower = faster CursorHold events
opt.timeoutlen = 300             -- lower = snappier mappings

-- Misc
opt.mouse = "a"                   -- enable mouse in all modes
opt.hidden = true                 -- allow unsaved buffers in background
opt.completeopt = { "menu", "menuone", "noselect" } -- good UX
opt.conceallevel = 2             -- conceal markdown, json, etc.

-- UI Noise reduction
opt.showmode = false             -- we use a statusline instead
opt.ruler = false
opt.laststatus = 3               -- global statusline (Neovim 0.7+)

-- Netrw
vim.g.netrw_browse_split = 4     -- Open files in previous window (the main one)
vim.g.netrw_altv = 1             -- Vertical splits open to the right
vim.g.netrw_winsize = 30         -- Sidebar width
vim.g.netrw_liststyle = 3        -- Tree view style
vim.g.netrw_banner = 0           -- No banner

-- Bufferline
vim.cmd([[
  highlight BufferLineInactive guifg=#666666 guibg=NONE
  highlight BufferLineActive guifg=#ffffff guibg=#5f87af gui=bold
]])

function _G.bufferline()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local current = vim.api.nvim_get_current_buf()
  local line = ""

  for i, buf in ipairs(buffers) do
    local name = vim.fn.fnamemodify(buf.name, ":t") or "[No Name]"
    local hl = (buf.bufnr == current) and "%#BufferLineActive#" or "%#BufferLineInactive#"
    line = line .. hl .. " " .. name .. " "
  end

  return line .. "%#Normal#" -- reset highlighting at the end
end
