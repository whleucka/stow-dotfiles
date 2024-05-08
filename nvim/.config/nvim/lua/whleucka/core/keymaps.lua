local map = vim.keymap.set

-- Disable
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("n", "Q", "<Nop>", { silent = true, noremap = true })
map("n", "q", "<Nop>", { silent = true, noremap = true })

-- Create undo breakpoints
map('i', '<space>', " <C-g>u")

-- Saving and quitting
map('n', '<leader>w', ':update<CR>', { silent = true, noremap = true, desc = "Save" })
map('n', '<leader>q', ':q<CR>', { silent = true, noremap = true, desc = "Close window" })
map('n', '<leader>Q', ':qa!<CR>', { silent = true, noremap = true, desc = "Exit" })

-- Select all
map('n', '<leader><bs>', 'gg<S-v>G', { silent = true, noremap = true, desc = "Select all" })

-- Delete backwards
map('n', '<a-bs>', 'db', { silent = true, noremap = true, desc = "Delete word backwards" })
map('i', '<a-bs>', '<esc>ldbi', { silent = true, noremap = true, desc = "Delete word backwards" })

-- Leave insert mode
map('i', 'jk', '<ESC>', { silent = true })
map('i', 'kj', '<ESC>', { silent = true })

-- Buffers
map('n', '<leader>c', ":bdelete<cr>", { silent = true, noremap = true, desc = "Destroy buffer" })
map('n', '<leader>n', function()
    vim.cmd.enew()
    vim.cmd[[ Dashboard ]]
end, { silent = true, noremap = true, desc = "New buffer" })
map('n', '<S-h>', ":bprev<cr>", { silent = true, noremap = true, desc = "Previous buffer" })
map('n', '<S-l>', ":bnext<cr>", { silent = true, noremap = true, desc = "Next buffer" })

-- Trouble
map("n", "<leader>xx", function() require("trouble").toggle() end)
map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
map("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
map("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- TODO comments
map('n', '[t', function()
  require("todo-comments").jump_prev()
end, { silent = true, noremap = true, desc = "Previous todo comment" })
map('n', ']t', function()
  require("todo-comments").jump_next()
end, { silent = true, noremap = true, desc = "Next todo comment" })

-- Quickfix
map('n', '[q', ':cp<CR>', { desc = 'Go to previous quickfix', silent = true, noremap = true })
map('n', ']q', ':cn<CR>', { desc = 'Go to next quickfix', silent = true, noremap = true })

-- Sourcing
map('n', '<leader><space>', ':so<CR>', { silent = true, noremap = true, desc = "Source buffer" })

-- Folds
map('n', '[f', "zk", { silent = true, noremap = true, desc = "Next fold" })
map('n', ']f', "zj", { silent = true, noremap = true, desc = "Prev fold" })
map('n', '<tab>',
  function() return require('fold-cycle').open() end,
  {silent = true, desc = 'Fold-cycle: open folds'})
map('n', '<s-tab>',
  function() return require('fold-cycle').close() end,
  {silent = true, desc = 'Fold-cycle: close folds'})
map('n', 'zC',
  function() return require('fold-cycle').close_all() end,
  {remap = true, silent = true, desc = 'Fold-cycle: close all folds'})

-- File navigation
map('n', "<leader>fm", ":lua require('fzf-lua').manpages()<cr>", { silent = true, noremap = true, desc = "Find man" })
map('n', "<leader>ff", ":lua require('fzf-lua').files()<cr>", { silent = true, noremap = true, desc = "Find files" })
map('n', "<leader>fo", ":lua require('fzf-lua').oldfiles()<cr>", { silent = true, noremap = true, desc = "Find old files" })
map('n', "<leader>fb", ":lua require('fzf-lua').buffers()<cr>", { silent = true, noremap = true, desc = "Find buffers" })
map('n', "<leader>fs", ":lua require('fzf-lua').blines()<cr>", { silent = true, noremap = true, desc = "Find buffer lines" })
map('n', "<leader>fg", ":lua require('fzf-lua').live_grep_native()<cr>", { silent = true, noremap = true, desc = "Find grep match" })
map('n', "<leader>fq", ":lua require('fzf-lua').quickfix()<cr>", { silent = true, noremap = true, desc = "Find quickfix" })
map('n', "<leader>fl", ":lua require('fzf-lua').loclist()<cr>", { silent = true, noremap = true, desc = "Find location list" })
map('n', "<leader>ft", ":lua require('fzf-lua').tags()<cr>", { silent = true, noremap = true, desc = "Find tags" })
map('n', "<leader>fc", ":lua require('fzf-lua').colorschemes()<cr>", { silent = true, noremap = true, desc = "Find color scheme" })

-- Focus
local focusmap = function(direction)
    map('n', '<c-' .. direction .. '>', function()
        require('focus').split_command(direction)
    end, { desc = string.format('Create or move to split (%s)', direction) })
end

-- Create split or move to split
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')

map('n', "<F9>", ':FocusToggle<cr>', { desc = 'Focus Toggle', silent = true })
map('n', "<F10>", ':FocusEqualise<cr>', { desc = 'Focus Equalise', silent = true })
map('n', "<F11>", function()
    vim.cmd[[ FocusEnable ]]
    vim.cmd[[ FocusMaximise ]]
end, { desc = 'Focus Maximize', silent = true })
map('n', "<F12>", ':FocusAutoresize<cr>', { desc = 'Focus Auto-resize', silent = true })

-- Resize splits
map('n', "<C-Left>", '<C-w><', { desc = 'Decrease Window Width', silent = true })
map('n', "<C-Right>", '<C-w>>', { desc = 'Increase Window Width', silent = true })
map('n', "<C-Down>", '<C-w>-', { desc = 'Decrease Window Height', silent = true })
map('n', "<C-Up>", '<C-w>+', { desc = 'Increase Window Height', silent = true })

-- Lazy
map('n', '<leader>z', ':Lazy<CR>', { desc = "Lazy", silent = true, noremap = true })
map('n', '<leader>zs', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true, noremap = true })
map('n', '<leader>zs', ':Lazy update<CR>', { desc = "Lazy update", silent = true, noremap = true })
map('n', '<leader>zc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true, noremap = true })
map('n', '<leader>zp', ':Lazy profile<CR>', { desc = "Lazy profile", silent = true, noremap = true })

-- Primeagen remaps
map("n", "J", "mzJ`z", { silent = true, noremap = true })
map("n", "n", "nzzzv", { silent = true, noremap = true })
map("n", "N", "Nzzzv", { silent = true, noremap = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 5 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
map('n', 'j', "v:count == 5 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- DAP
-- Adapted from https://grumpy-learning.com/blog/2028/04/03/neovim-and-xdebug/
map("n", "<F5>", ":lua require'dap'.continue()<cr>", { silent = true, desc = "DAP Continue" })
map("n", "<F6>", ":lua require'dap'.step_over()<cr>", { silent = true, desc = "DAP Step Over" })
map("n", "<F7>", ":lua require'dap'.step_into()<cr>", { silent = true, desc = "DAP Step Into" })
map("n", "<F8>", ":lua require'dap'.step_out()<cr>", { silent = true, desc = "DAP Step Out" })
map("n", "<leader>do", ":lua require'dapui'.toggle()<cr>", { silent = true, desc = "DAP Open UI" })
map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>",
    { silent = true, desc = "DAP Toggle Breakpoint" })
map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>", { silent = true, desc = "DAP REPL Open" })
map("n", "<leader>dl", ":lua require'dap'.run_last()<cr>", { silent = true, desc = "DAP Run Last" })
map({ 'n', 'v' }, '<leader>dh', ":lua require('dap.ui.widgets').hover()<cr>",
    { silent = true, desc = "DAP Hover" })
map({ 'n', 'v' }, '<leader>dp', ":lua require('dap.ui.widgets').preview()<cr>",
    { silent = true, desc = "DAP Preview" })

-- Neotest
map("n", "<leader>ts", ":lua require'neotest'.summary.toggle()<cr>",
    { silent = true, desc = "Neotest Summary" })
map("n", "<leader>tr", ":lua require'neotest'.run.run()<cr>", { silent = true, desc = "Neotest Run" })
map("n", "<leader>td", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>",
    { silent = true, desc = "Neotest DAP" })
map("n", "<leader>to", ":lua require'neotest'.output_panel()<cr>",
    { silent = true, desc = "Neotest Output Panel" })

-- Terminal
map("t", "<esc><esc>", "<c-\\><c-n>")
map("n", "<C-t>", function()
    vim.cmd.new()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)
map("n", "<C-;>", ":lua require('FTerm').toggle()<cr>", { silent = true, desc = "Toggle Terminal"})
