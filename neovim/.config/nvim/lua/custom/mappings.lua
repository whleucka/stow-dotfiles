-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Save
vim.keymap.set('n', '<leader>w', ':update<CR>', { silent = true })
vim.keymap.set('n', '<leader><space>', ':update<CR>', { silent = true })

-- Quit
vim.keymap.set('n', '<leader>q', ':bd<CR>', { silent = true })
vim.keymap.set('n', '<leader>qq', ':q!<CR>', { silent = true })
vim.keymap.set('n', '<C-q>', ':qa!<CR>', { silent = true })

-- Lazy
vim.keymap.set('n', '<leader>pu', ':Lazy update<CR>', { desc = "Lazy update", silent = true })
vim.keymap.set('n', '<leader>ps', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true })
vim.keymap.set('n', '<leader>pc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '[q', ":cprev<CR>", { desc = 'Go to previous quickfix list', silent = true })
vim.keymap.set('n', ']q', ":cnext<CR>", { desc = 'Go to next quickfix list', silent = true })
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- File tree
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })

-- Neogit
vim.keymap.set('n', '<C-g>', ':Neogit kind=auto<CR>', { silent = true })

-- Telescope
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzy find in buffer' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find finds in current working directory' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = 'Find previously opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find open buffers' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Find help tags' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep, { desc = 'Find a string in your current working directory' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Find diagnostic list' })
vim.keymap.set('n', '<leader>fq', require('telescope.builtin').quickfix, { desc = 'Find quickfix list' })

-- Terminal
vim.keymap.set('n', '<C-\\>', ':ToggleTerm direction=float<CR>', { silent = true })
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { silent = true })
vim.keymap.set('n', '<leader>th', ':ToggleTerm size=10 direction=horizontal<CR>', { silent = true })
vim.keymap.set('n', '<leader>tv', ':ToggleTerm size=70 direction=vertical<CR>', { silent = true })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- Splits
vim.keymap.set('n', '|', '<C-w>v', { silent = true })
vim.keymap.set('n', '\\', '<C-w>s', { silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- Buffer navigation
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { silent = true })
vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { silent = true })

-- Formatting
vim.keymap.set('n', '<leader>lf', ':Format<CR>', { silent = true })

-- Leave insert mode
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
