-- Disable
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<Nop>", { silent = true, noremap = true })

-- Create undo breakpoints
vim.keymap.set('i', '<space>', " <C-g>u")

-- Saving and quitting
vim.keymap.set('n', '<leader>w', ':update<CR>', { silent = true, noremap = true, desc = "Save" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true, noremap = true, desc = "Close window" })

-- Increment / Decrement
vim.keymap.set({'n', 'v'}, '<c-=>', '<C-a>', { silent = true, noremap = true, desc = "Increment" })
vim.keymap.set({'n', 'v'}, '<c-->', '<C-x>', { silent = true, noremap = true, desc = "Decrement" })

-- Select all
vim.keymap.set('n', '<c-bs>', 'gg<S-v>G', { silent = true, noremap = true, desc = "Select all" })

-- Delete backwards
vim.keymap.set('n', '<a-bs>', 'db', { silent = true, noremap = true, desc = "Delete word backwards" })
vim.keymap.set('i', '<a-bs>', '<esc>ldbi', { silent = true, noremap = true, desc = "Delete word backwards" })

-- Leave insert mode
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

-- Buffers
vim.keymap.set('n', '<leader>c',  ":bdelete<cr>", { silent = true, noremap = true, desc = "Destroy buffer" })
vim.keymap.set('n', '<leader>bn',  ":enew<cr>", { silent = true, noremap = true, desc = "New buffer" })
vim.keymap.set('n', 'H',  ":bprev<cr>", { silent = true, noremap = true, desc = "Previous buffer" })
vim.keymap.set('n', 'L',  ":bnext<cr>", { silent = true, noremap = true, desc = "Next buffer" })

-- Tabs
vim.keymap.set('n', '[t',  ":tabprev<cr>", { silent = true, noremap = true, desc = "Previous buffer" })
vim.keymap.set('n', ']t',  ":tabnext<cr>", { silent = true, noremap = true, desc = "Next buffer" })

-- Sourcing
vim.keymap.set('n', '<c-s>', ':so<CR>', { silent = true, noremap = true, desc = "Source buffer" })

-- Harpoon
vim.keymap.set('n', '<leader>h', ':lua require("harpoon.mark").add_file()<cr>', { noremap = true, desc = 'Hapoon file' })
vim.keymap.set('n', '<leader>fh', ':lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true, desc = 'Hapoon quick menu' })
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
vim.keymap.set('n', '[h', ':lua require("harpoon.ui").nav_prev()<cr>', { noremap = true, desc = 'Hapoon prev' })
vim.keymap.set('n', ']h', ':lua require("harpoon.ui").nav_next()<cr>', { noremap = true, desc = 'Hapoon prev' })

-- Splits
local focusmap = function(direction)
    vim.keymap.set('n', '<c-'..direction..'>', function()
        require('focus').split_command(direction)
    end, { desc = string.format('Create or move to split (%s)', direction) })
end

-- Use `<Leader>h` to split the screen to the left, same as command FocusSplitLeft etc
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')

-- Lazy
vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { desc = "Lazy", silent = true, noremap = true })
vim.keymap.set('n', '<leader>ls', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true, noremap = true })
vim.keymap.set('n', '<leader>ls', ':Lazy update<CR>', { desc = "Lazy update", silent = true, noremap = true })
vim.keymap.set('n', '<leader>lc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true, noremap = true })
vim.keymap.set('n', '<leader>lp', ':Lazy profile<CR>', { desc = "Lazy clean", silent = true, noremap = true })

-- Quickfix
vim.keymap.set('n', '[q', ':cp<CR>', { desc = 'Go to previous quickfix', silent = true, noremap = true })
vim.keymap.set('n', ']q', ':cn<CR>', { desc = 'Go to next quickfix', silent = true, noremap = true })

-- Primeagen remaps
vim.keymap.set("n", "J", "mzJ`z", { silent = true, noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true, noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true })

--vim.keymap.set("x", "<leader>p", [["_dP]])
--vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- Yank current line
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Moving lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
