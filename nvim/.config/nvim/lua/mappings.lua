-- Plugins
vim.keymap.set('n', '<F1>', ':PackerSync<CR>')
vim.keymap.set('n', '<F2>', ':PackerUpdate<CR>')

-- Close neovim
vim.keymap.set('n', '<C-c>', ':qall!<CR>')

-- Quick save
vim.keymap.set('n', '<leader>w', ':update!<CR>')


-- Tests
vim.keymap.set('n', '<leader>t', ':make --bootstrap vendor/autoload.php --testdox tests<CR>')

-- Clipboard
vim.keymap.set('n', '<leader>p', '"*p')
vim.keymap.set('n', '<leader>y', '"*y')

-- Folds
vim.keymap.set('n', '<leader><space>', 'za')
vim.keymap.set('o', '<leader><space>', '<C-C>za')
vim.keymap.set('v', '<leader><space>', 'zf')

-- Telescope
vim.keymap.set('n', '<C-p>', ':Telescope git_files<CR>')
vim.keymap.set('n', '<Enter><Enter>', ':Telescope oldfiles<CR>')
vim.keymap.set('n', '<C-f>', ':Telescope find_files<CR>')
vim.keymap.set('n', '<C-b>', ':Telescope buffers<CR>')
vim.keymap.set('n', '<C-g>', ':Telescope live_grep<CR>')

-- Spelling
vim.keymap.set('n', '<leader>s', 'z=')

-- FuGITive
vim.keymap.set('n', '<leader>gs', ':G<CR>')
vim.keymap.set('n', '<leader>gb', ':G branch<SPACE>')
vim.keymap.set('n', '<leader>gbl', ':G blame<CR>')
vim.keymap.set('n', '<leader>gl', ':Gclog<CR>')
vim.keymap.set('n', '<leader>gd', ':G diff<CR><CR>')
vim.keymap.set('n', '<leader>gco', ':G checkout<SPACE>')
vim.keymap.set('n', '<leader>gcb', ':G checkout -b<SPACE>')
vim.keymap.set('n', '<leader>gcm', ':G checkout master')
vim.keymap.set('n', '<leader>gp', ':G push<CR>')
vim.keymap.set('n', '<leader>gpsu', ':G push --set-upstream origin<SPACE>')
vim.keymap.set('n', '<leader>gmnf', ':G merge --no-ff<SPACE>')

-- Text manipulation
-- Move text and format
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
-- Make Y behave like D, C
vim.keymap.set('n', 'Y', 'yg$')
-- Keeping it centred
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')
-- Undo breakpoints
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', '!', '!<c-g>u')
vim.keymap.set('i', '?', '?<c-g>u')
vim.keymap.set('i', '$', '$<c-g>u')

-- Navigation
-- Quick fix
vim.keymap.set('n', '<leader>[', ':cp<CR>')
vim.keymap.set('n', '<leader>]', ':cn<CR>')
-- Tabs (note, we use buffers)
--vim.keymap.set('n', '<leader>1', '1gt')
--vim.keymap.set('n', '<leader>2', '2gt')
--vim.keymap.set('n', '<leader>3', '3gt')
--vim.keymap.set('n', '<leader>4', '4gt')
--vim.keymap.set('n', '<leader>5', '5gt')
--vim.keymap.set('n', '<leader>6', '6gt')
--vim.keymap.set('n', '<leader>7', '7gt')
--vim.keymap.set('n', '<leader>8', '8gt')
--vim.keymap.set('n', '<leader>9', '9gt')
--vim.keymap.set('n', '<leader>0', ':tablast<CR>')
vim.keymap.set('n', '<leader>1', ':BufferGoto 1<CR>')
vim.keymap.set('n', '<leader>2', ':BufferGoto 2<CR>')
vim.keymap.set('n', '<leader>3', ':BufferGoto 3<CR>')
vim.keymap.set('n', '<leader>4', ':BufferGoto 4<CR>')
vim.keymap.set('n', '<leader>5', ':BufferGoto 5<CR>')
vim.keymap.set('n', '<leader>6', ':BufferGoto 6<CR>')
vim.keymap.set('n', '<leader>7', ':BufferGoto 7<CR>')
vim.keymap.set('n', '<leader>8', ':BufferGoto 8<CR>')
vim.keymap.set('n', '<leader>9', ':BufferGoto 9<CR>')
vim.keymap.set('n', '<leader>0', ':BufferLast<CR>')
vim.keymap.set('n', '<C-j>', ':BufferPrevious<CR>')
vim.keymap.set('n', '<C-k>', ':BufferNext<CR>')
vim.keymap.set('n', '<C-Left>', ':BufferMovePrevious<CR>')
vim.keymap.set('n', '<C-Right>', ':BufferMoveNext<CR>')
vim.keymap.set('n', '<leader>x', ':BufferClose<CR>')
vim.keymap.set('n', '<leader>xx', ':BufferCloseAllButCurrent<CR>')
-- Splits
--vim.keymap.set('n', '<leader>h', '<C-W><C-H>')
--vim.keymap.set('n', '<leader>j', '<C-W><C-J>')
--vim.keymap.set('n', '<leader>k', '<C-W><C-K>')
--vim.keymap.set('n', '<leader>l', '<C-W><C-L>')
-- Resize
vim.keymap.set("n", "<S-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<S-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<S-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<S-Right>", ":vertical resize -2<CR>")

-- No Highlight
vim.keymap.set('n', '<ESC>', ':noh<CR>')

-- Exit insert
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

-- BOL/EOL 
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')
