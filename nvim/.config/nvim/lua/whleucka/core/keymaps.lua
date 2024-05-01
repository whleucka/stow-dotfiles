-- Disable
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<Nop>", { silent = true, noremap = true })
vim.keymap.set("n", "q", "<Nop>", { silent = true, noremap = true })

-- Create undo breakpoints
vim.keymap.set('i', '<space>', " <C-g>u")

-- Saving and quitting
vim.keymap.set('n', '<leader>w', ':update<CR>', { silent = true, noremap = true, desc = "Save" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true, noremap = true, desc = "Close window" })
vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { silent = true, noremap = true, desc = "Exit" })

-- Increment / Decrement
vim.keymap.set({ 'n', 'v' }, '<c-=>', '<C-a>', { silent = true, noremap = true, desc = "Increment" })
vim.keymap.set({ 'n', 'v' }, '<c-->', '<C-x>', { silent = true, noremap = true, desc = "Decrement" })

-- Select all
vim.keymap.set('n', '<C-\\>', 'gg<S-v>G', { silent = true, noremap = true, desc = "Select all" })

-- Delete backwards
vim.keymap.set('n', '<a-bs>', 'db', { silent = true, noremap = true, desc = "Delete word backwards" })
vim.keymap.set('i', '<a-bs>', '<esc>ldbi', { silent = true, noremap = true, desc = "Delete word backwards" })

-- Leave insert mode
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

-- Buffers
vim.keymap.set('n', '<leader>c', ":bdelete<cr>", { silent = true, noremap = true, desc = "Destroy buffer" })
vim.keymap.set('n', '<leader>bn', ":enew<cr>", { silent = true, noremap = true, desc = "New buffer" })
vim.keymap.set('n', '<S-h>', ":bprev<cr>", { silent = true, noremap = true, desc = "Previous buffer" })
vim.keymap.set('n', '<S-l>', ":bnext<cr>", { silent = true, noremap = true, desc = "Next buffer" })

-- Tabs
vim.keymap.set('n', '[t', ":tabprev<cr>", { silent = true, noremap = true, desc = "Previous tab" })
vim.keymap.set('n', ']t', ":tabnext<cr>", { silent = true, noremap = true, desc = "Next tab" })

-- Quickfix
vim.keymap.set('n', '[q', ':cp<CR>', { desc = 'Go to previous quickfix', silent = true, noremap = true })
vim.keymap.set('n', ']q', ':cn<CR>', { desc = 'Go to next quickfix', silent = true, noremap = true })

-- Sourcing
vim.keymap.set('n', '<c-s>', ':so<CR>', { silent = true, noremap = true, desc = "Source buffer" })

-- Focus
local focusmap = function(direction)
    vim.keymap.set('n', '<c-' .. direction .. '>', function()
        require('focus').split_command(direction)
    end, { desc = string.format('Create or move to split (%s)', direction) })
end

-- Create split or move to split
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')

vim.keymap.set('n', "<F9>", ':FocusToggle<cr>', { desc = 'Focus Toggle', silent = true })
vim.keymap.set('n', "<F10>", ':FocusEqualise<cr>', { desc = 'Focus Equalise', silent = true })
vim.keymap.set('n', "<F11>", function()
    vim.cmd[[ FocusEnable ]]
    vim.cmd[[ FocusMaximise ]]
end, { desc = 'Focus Maximize', silent = true })
vim.keymap.set('n', "<F12>", ':FocusAutoresize<cr>', { desc = 'Focus Auto-resize', silent = true })

-- Resize splits
vim.keymap.set('n', "<C-Left>", '<C-w><', { desc = 'Decrease Window Width', silent = true })
vim.keymap.set('n', "<C-Right>", '<C-w>>', { desc = 'Increase Window Width', silent = true })
vim.keymap.set('n', "<C-Down>", '<C-w>-', { desc = 'Decrease Window Height', silent = true })
vim.keymap.set('n', "<C-Up>", '<C-w>+', { desc = 'Increase Window Height', silent = true })

-- Lazy
vim.keymap.set('n', '<leader>l', ':Lazy<CR>', { desc = "Lazy", silent = true, noremap = true })
vim.keymap.set('n', '<leader>ls', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true, noremap = true })
vim.keymap.set('n', '<leader>ls', ':Lazy update<CR>', { desc = "Lazy update", silent = true, noremap = true })
vim.keymap.set('n', '<leader>lc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true, noremap = true })
vim.keymap.set('n', '<leader>lp', ':Lazy profile<CR>', { desc = "Lazy clean", silent = true, noremap = true })

-- Primeagen remaps
vim.keymap.set("n", "J", "mzJ`z", { silent = true, noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true, noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 5 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 5 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Moving lines around
vim.keymap.set("v", "J", ":m '>+6<CR>gv=gv", { silent = true, desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<3<CR>gv=gv", { silent = true, desc = "Move line up" })

-- DAP
-- Adapted from https://grumpy-learning.com/blog/2028/04/03/neovim-and-xdebug/
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<cr>", { silent = true, desc = "DAP Continue" })
vim.keymap.set("n", "<F6>", ":lua require'dap'.step_over()<cr>", { silent = true, desc = "DAP Step Over" })
vim.keymap.set("n", "<F7>", ":lua require'dap'.step_into()<cr>", { silent = true, desc = "DAP Step Into" })
vim.keymap.set("n", "<F8>", ":lua require'dap'.step_out()<cr>", { silent = true, desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>do", ":lua require'dapui'.toggle()<cr>", { silent = true, desc = "DAP Open UI" })
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>",
    { silent = true, desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>", { silent = true, desc = "DAP REPL Open" })
vim.keymap.set("n", "<leader>dl", ":lua require'dap'.run_last()<cr>", { silent = true, desc = "DAP Run Last" })
vim.keymap.set("n", "<leader>dc", ":lua require'telescope'.extensions.dap.commands{}<cr>",
    { silent = true, desc = "DAP Commands" })
vim.keymap.set("n", "<leader>df", ":lua require'telescope'.extensions.dap.frames{}<cr>",
    { silent = true, desc = "DAP Frames" })
vim.keymap.set({ 'n', 'v' }, '<leader>dh', ":lua require('dap.ui.widgets').hover()<cr>",
    { silent = true, desc = "DAP Hover" })
vim.keymap.set({ 'n', 'v' }, '<leader>dp', ":lua require('dap.ui.widgets').preview()<cr>",
    { silent = true, desc = "DAP Preview" })

-- Neotest
vim.keymap.set("n", "<leader>ts", ":lua require'neotest'.summary.toggle()<cr>",
    { silent = true, desc = "Neotest Summary" })
vim.keymap.set("n", "<leader>tr", ":lua require'neotest'.run.run()<cr>", { silent = true, desc = "Neotest Run" })
vim.keymap.set("n", "<leader>td", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>",
    { silent = true, desc = "Neotest DAP" })
vim.keymap.set("n", "<leader>to", ":lua require'neotest'.output_panel()<cr>",
    { silent = true, desc = "Neotest Output Panel" })

-- Terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<C-t>", function()
    vim.cmd.new()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)
vim.keymap.set("n", "<C-;>", ":lua require('FTerm').toggle()<cr>", { silent = true, desc = "Toggle Terminal"})
