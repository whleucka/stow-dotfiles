-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Save
vim.keymap.set('n', '<leader>w', ':update<CR>', { silent = true })
-- Quit
vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true })
-- Buffer
vim.keymap.set('n', '<leader>c', ':bd<CR>', { silent = true})

-- File tree
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })

-- Terminal
vim.keymap.set('n', '<C-\\>', ':ToggleTerm dir=.<CR>', { silent = true })
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { silent = true })
vim.keymap.set('n', '<leader>th', ':ToggleTerm size=10 direction=horizontal<CR>', { silent = true })
vim.keymap.set('n', '<leader>tv', ':ToggleTerm size=70 direction=vertical<CR>', { silent = true })
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Splits
vim.keymap.set('n', '|', '<C-w>v', { silent = true })
vim.keymap.set('n', '\\', '<C-w>s', { silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', {silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', {silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', {silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', {silent = true })

-- Buffer navigation
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>', {silent = true })
vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>', {silent = true })


-- Leave insert mode
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
