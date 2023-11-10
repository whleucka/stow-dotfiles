vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Saving and quitting
vim.keymap.set('n', '<leader>w', ':update<CR>', { silent = true, noremap = true, desc = "Save" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true, noremap = true, desc = "Close window" })

-- Leave insert mode
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

-- Buffers
vim.keymap.set('n', '<leader>c', ':bd<CR>', { silent = true, noremap = true, desc = "Destroy buffer" })

-- Sourcing
vim.keymap.set('n', '<c-s>', ':so<CR>', { silent = true, noremap = true, desc = "Source buffer" })

-- Formatting
vim.keymap.set('n', '<c-f>', function()
	vim.lsp.buf.format { async = true }
end, { silent = true, noremap = true, desc = "Format buffer" })

-- Harpoon
vim.keymap.set('n', '<leader>h', ':lua require("harpoon.mark").add_file()<cr>', { noremap = true, desc = 'Hapoon file' })
vim.keymap.set('n', '<leader>hh', ':lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true, desc = 'Hapoon quick menu' })
vim.keymap.set('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<cr>', { noremap = true, desc = 'Hapoon nav(1)' })
vim.keymap.set('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<cr>', { noremap = true, desc = 'Hapoon nav(2)' })
vim.keymap.set('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<cr>', { noremap = true, desc = 'Hapoon nav(3)' })
vim.keymap.set('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<cr>', { noremap = true, desc = 'Hapoon nav(4)' })
vim.keymap.set('n', '<leader>5', ':lua require("harpoon.ui").nav_file(5)<cr>', { noremap = true, desc = 'Hapoon nav(5)' })
vim.keymap.set('n', '<leader>6', ':lua require("harpoon.ui").nav_file(6)<cr>', { noremap = true, desc = 'Hapoon nav(6)' })
vim.keymap.set('n', '<leader>7', ':lua require("harpoon.ui").nav_file(7)<cr>', { noremap = true, desc = 'Hapoon nav(7)' })
vim.keymap.set('n', '<leader>8', ':lua require("harpoon.ui").nav_file(8)<cr>', { noremap = true, desc = 'Hapoon nav(8)' })
vim.keymap.set('n', '<leader>9', ':lua require("harpoon.ui").nav_file(9)<cr>', { noremap = true, desc = 'Hapoon nav(9)' })
vim.keymap.set('n', '<leader>0', ':lua require("harpoon.ui").nav_file(0)<cr>', { noremap = true, desc = 'Hapoon nav(0)' })
vim.keymap.set('n', '<F9>', ':lua require("harpoon.term").gotoTerminal(1)<cr>', { noremap = true, desc = 'Hapoon terminal(1)' })
vim.keymap.set('n', '<F10>', ':lua require("harpoon.term").gotoTerminal(2)<cr>', { noremap = true, desc = 'Hapoon terminal(2)' })
vim.keymap.set('n', '<F11>', ':lua require("harpoon.term").gotoTerminal(3)<cr>', { noremap = true, desc = 'Hapoon terminal(3)' })
vim.keymap.set('n', '<F12>', ':lua require("harpoon.term").gotoTerminal(4)<cr>', { noremap = true, desc = 'Hapoon terminal(4)' })
vim.keymap.set('n', 'H', ':lua require("harpoon.ui").nav_prev()<cr>', { noremap = true, desc = 'Hapoon prev' })
vim.keymap.set('n', 'L', ':lua require("harpoon.ui").nav_next()<cr>', { noremap = true, desc = 'Hapoon prev' })

-- Splits
vim.keymap.set('n', '|', '<C-w>v', { silent = true, noremap = true })
vim.keymap.set('n', '\\', '<C-w>s', { silent = true, noremap = true })

-- Lazy
vim.keymap.set('n', '<leader>pu', ':Lazy update<CR>', { desc = "Lazy update", silent = true, noremap = true })
vim.keymap.set('n', '<leader>ps', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true, noremap = true })
vim.keymap.set('n', '<leader>pc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true, noremap = true })
vim.keymap.set('n', '<leader>pp', ':Lazy profile<CR>', { desc = "Lazy profile", silent = true, noremap = true })
vim.keymap.set('n', '<leader>pd', ':Lazy debug<CR>', { desc = "Lazy debug", silent = true, noremap = true })

-- Quickfix
vim.keymap.set('n', '[q', ':cp<CR>', { desc = 'Go to previous quickfix', silent = true, noremap = true })
vim.keymap.set('n', ']q', ':cn<CR>', { desc = 'Go to next quickfix', silent = true, noremap = true })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message', silent = true, noremap = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message', silent = true, noremap = true })

-- Primeagen remaps
vim.keymap.set("n", "J", "mzJ`z", { silent = true, noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true, noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true })
vim.keymap.set("n", "Q", "<nop>", { silent = true, noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Moving lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
