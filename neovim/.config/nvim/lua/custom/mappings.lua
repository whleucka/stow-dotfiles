-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Neogit
vim.keymap.set('n', '<leader>gs', ':Neogit kind=auto<CR>', { silent = true, desc = "Neogit" })
vim.keymap.set('n', '<leader>gb', ":G blame<CR>", { silent = true, desc = "Git blame" })
vim.keymap.set('n', '<leader>gl', ":BlameLineToggle<CR>", { silent = true, desc = "Git blame (virtual text)" })

-- Save
vim.keymap.set('n', '<leader>w', ':update<CR>', { silent = true })
vim.keymap.set('n', '<leader><space>', function()
  vim.cmd("so")
end, { silent = true })

-- Quit
vim.keymap.set('n', '<leader>c', ':bd<CR>', { silent = true, desc = "Close buffer" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true, desc = "Close window" })
vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { silent = true })

-- Lazy
vim.keymap.set('n', '<leader>pu', ':Lazy update<CR>', { desc = "Lazy update", silent = true })
vim.keymap.set('n', '<leader>ps', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true })
vim.keymap.set('n', '<leader>pc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true })

-- Quickfix
vim.keymap.set('n', '[q', ':cn<CR>', { desc = 'Go to previous quickfix' })
vim.keymap.set('n', ']q', ':cp<CR>', { desc = 'Go to next quickfix' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- File tree
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })

-- Telescope
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzy find in buffer' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files,
  { desc = 'Find finds in current working directory' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = 'Find previously opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find open buffers' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Find help tags' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep,
  { desc = 'Find a string in your current working directory' })
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

-- Buffer navigation
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', { silent = true, desc = "Previous buffer" })
vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', { silent = true, desc = "Next buffer" })

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
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")
