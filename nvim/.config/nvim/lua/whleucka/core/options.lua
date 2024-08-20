-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.rnu = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- No swap files
vim.o.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- Default indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Last status / cmd height
vim.o.cmdheight = 0
vim.o.laststatus = 3

-- Providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = "/usr/bin/python3"

-- Folding
-- Use Tree-sitter for folds
vim.o.foldmethod = 'expr'
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.o.foldlevelstart = 1   -- Close all folds by default
vim.o.foldminlines = 1     -- Minimum lines required for a fold to be created
vim.o.foldnestmax = 3      -- Maximum nested folds (adjust as needed)

-- Optional: Keep fold text concise
vim.o.foldtext = [[substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g') . '...' . trim(getline(v:foldend))]]

-- Enable folding
vim.o.foldenable = true
