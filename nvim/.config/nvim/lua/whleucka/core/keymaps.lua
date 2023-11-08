vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Saving and quitting
vim.keymap.set('n', '<leader>w', ':update<CR>', { silent = true, desc = "Save" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true, desc = "Close window" })

-- Buffers
vim.keymap.set('n', '<leader>c', ':bd<CR>', { silent = true, desc = "Destroy buffer" })
vim.keymap.set('n', 'H', ':bp<CR>', { silent = true, desc = "Previous buffer" })
vim.keymap.set('n', 'L', ':bn<CR>', { silent = true, desc = "Next buffer" })

-- Sourcing
vim.keymap.set('n', '<c-s>', ':so<CR>', { silent = true, desc = "Source buffer" })

-- Lazy
vim.keymap.set('n', '<leader>pu', ':Lazy update<CR>', { desc = "Lazy update", silent = true })
vim.keymap.set('n', '<leader>ps', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true })
vim.keymap.set('n', '<leader>pc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true })
vim.keymap.set('n', '<leader>pp', ':Lazy profile<CR>', { desc = "Lazy profile", silent = true })
vim.keymap.set('n', '<leader>pd', ':Lazy debug<CR>', { desc = "Lazy debug", silent = true })

-- Splits
vim.keymap.set('n', '|', '<C-w>v', { silent = true })
vim.keymap.set('n', '\\', '<C-w>s', { silent = true })

-- Quickfix
vim.keymap.set('n', '[q', ':cp<CR>', { desc = 'Go to previous quickfix', silent = true })
vim.keymap.set('n', ']q', ':cn<CR>', { desc = 'Go to next quickfix', silent = true })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message', silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message', silent = true })

-- Formatting
vim.keymap.set('n', '<leader>lf', ':Format<CR>', { silent = true, desc = "Format buffer" })

-- Leave insert mode
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- BOL/EOL
vim.keymap.set('n', '<leader>h', '_', { silent = true, desc = "Jump to beginning of line" })
vim.keymap.set('n', '<leader>l', '$', { silent = true, desc = "Jump to end of line" })
--vim.keymap.set('n', '<leader>j', 'G', { silent = true, desc = "Jump to bottom of file" })
--vim.keymap.set('n', '<leader>k', 'gg', { silent = true, desc = "Jump to top of file" })

-- Moving lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Primeagen remaps
vim.keymap.set("n", "J", "mzJ`z", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "Q", "<nop>", { silent = true })
