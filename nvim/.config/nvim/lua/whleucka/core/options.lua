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
vim.g.python3_host_prog = "/usr/bin/python"

-- Folding
-- source of truth for folding
--vim.o.foldmethod = "expr"
--vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
---- avoid taking up room with an extra column
--vim.o.foldcolumn = "0"
---- helps with navigating a large file as not all the contents will be expanded initially.
--vim.o.foldlevel = 99
--vim.o.foldlevelstart = 1
---- this limits how deeply code gets folded
--vim.o.foldnestmax = 4
