local map = vim.keymap.set

-- Disabled
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("n", "Q", "<Nop>", { silent = true, noremap = true })
map("n", "q", "<Nop>", { silent = true, noremap = true })

-- Lazy
map('n', '<leader>p', ':Lazy<CR>', { desc = "Lazy", silent = true, noremap = true })
map('n', '<leader>ps', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true, noremap = true })
map('n', '<leader>ps', ':Lazy update<CR>', { desc = "Lazy update", silent = true, noremap = true })
map('n', '<leader>pc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true, noremap = true })
map('n', '<leader>pp', ':Lazy profile<CR>', { desc = "Lazy profile", silent = true, noremap = true })

--- Focus
local focusmap = function(direction)
    map('n', '<C-' .. direction .. '>', function()
        require('focus').split_command(direction)
    end, { desc = string.format('Create or move to split (%s)', direction) })
end

-- Create split or move to split
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')

-- Sourcing
map('n', '<c-s>', ':so<CR>', { silent = true, noremap = true, desc = "Source buffer" })

-- Delete backwards
map('n', '<a-bs>', 'db', { silent = true, noremap = true, desc = "Delete word backwards" })
map('i', '<a-bs>', '<esc>ldbi', { silent = true, noremap = true, desc = "Delete word backwards" })

-- Leave insert mode
map('i', 'jk', '<ESC>', { silent = true })
map('i', 'kj', '<ESC>', { silent = true })

-- Undo some stuff
map('n', '<leader>u', ':UndotreeToggle<CR>', {silent = true, noremap = true})

-- Saving and quitting
map('n', '<leader>w', ':update<CR>', { silent = true, noremap = true, desc = "Save (update)" })
map('n', '<leader>W', ':w!<CR>', { silent = true, noremap = true, desc = "Save (force)" })
map('n', '<leader>q', ':q<CR>', { silent = true, noremap = true, desc = "Exit window" })
map('n', '<leader>Q', ':qa!<CR>', { silent = true, noremap = true, desc = "Exit Neovim (force)" })

-- Buffers
map('n', '<leader>c', ":BufferLinePickClose<cr>", { silent = true, noremap = true, desc = "Close buffer" })
map('n', '<leader><space>', ":BufferLinePick<cr>", { silent = true, noremap = true, desc = "Pick buffer" })
map('n', '<S-h>', ":BufferLineCyclePrev<cr>", { silent = true, noremap = true, desc = "Previous buffer" })
map('n', '<S-l>', ":BufferLineCycleNext<cr>", { silent = true, noremap = true, desc = "Next buffer" })
map('n', '<leader>d', function()
    vim.cmd.enew()
    vim.cmd[[ Dashboard ]]
end, { silent = true, noremap = true, desc = "Show dashboard" })
map('n', '<leader>1', ':BufferLineGoToBuffer 1<cr>', { silent = true, noremap = true, desc = "Go to Buffer 1" })
map('n', '<leader>2', ':BufferLineGoToBuffer 2<cr>', { silent = true, noremap = true, desc = "Go to Buffer 2" })
map('n', '<leader>3', ':BufferLineGoToBuffer 3<cr>', { silent = true, noremap = true, desc = "Go to Buffer 3" })
map('n', '<leader>4', ':BufferLineGoToBuffer 4<cr>', { silent = true, noremap = true, desc = "Go to Buffer 4" })
map('n', '<leader>5', ':BufferLineGoToBuffer 5<cr>', { silent = true, noremap = true, desc = "Go to Buffer 5" })
map('n', '<leader>6', ':BufferLineGoToBuffer 6<cr>', { silent = true, noremap = true, desc = "Go to Buffer 6" })
map('n', '<leader>7', ':BufferLineGoToBuffer 7<cr>', { silent = true, noremap = true, desc = "Go to Buffer 7" })
map('n', '<leader>8', ':BufferLineGoToBuffer 8<cr>', { silent = true, noremap = true, desc = "Go to Buffer 8" })
map('n', '<leader>9', ':BufferLineGoToBuffer 9<cr>', { silent = true, noremap = true, desc = "Go to Buffer 9" })
map('n', '<leader>0', ':BufferLineGoToBuffer 10<cr>', { silent = true, noremap = true, desc = "Go to Buffer 10" })

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
map('n', "<C-p>", ":lua require('fzf-lua').git_files()<cr>", { silent = true, noremap = true, desc = "Find git files"})
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

-- Primeagen remaps
map("n", "J", "mzJ`z", { silent = true, noremap = true })
map("n", "n", "nzzzv", { silent = true, noremap = true })
map("n", "N", "Nzzzv", { silent = true, noremap = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 5 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
map('n', 'j', "v:count == 5 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- Neotest
map("n", "<leader>ns", ":lua require'neotest'.summary.toggle()<cr>",
    { silent = true, desc = "Neotest Summary" })
map("n", "<leader>nr", ":lua require'neotest'.run.run()<cr>", { silent = true, desc = "Neotest Run" })
map("n", "<leader>nd", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>",
    { silent = true, desc = "Neotest DAP" })
map("n", "<leader>no", ":lua require'neotest'.output_panel()<cr>",
    { silent = true, desc = "Neotest Output Panel" })

-- Terminal
map("t", "<esc><esc>", "<c-\\><c-n>")
-- Define a global variable to track terminal state
_G.fterm_open = false
_G.fterm_first_open = true

-- Define a custom toggle function
function _G.toggle_fterm()
    local fterm = require('FTerm')
    if _G.fterm_open then
        -- Terminal is currently open, toggle it off
        fterm.toggle()
        _G.fterm_open = false
    else
        -- Terminal is currently closed, toggle it on
        fterm.toggle()
        if _G.fterm_first_open then
            -- Enter insert mode the first time the terminal is opened
            vim.cmd('startinsert')
            _G.fterm_first_open = false
        else
            -- Ensure the terminal is in normal mode for subsequent toggles
            vim.cmd('stopinsert')
        end
        _G.fterm_open = true
    end
end

-- Key mapping to toggle terminal and enter insert mode if shown
vim.api.nvim_set_keymap('n', '<C-t>', ':lua toggle_fterm()<CR>', { silent = true, noremap = true, desc = "Toggle floating terminal" })

-- Custom Terminals
local term_wins = {nil, nil, nil, nil}
local term_bufs = {nil, nil, nil, nil}

-- Function to create or switch to terminal
local function open_terminal(term_index)
    -- Check if the terminal buffer already exists
    if term_bufs[term_index] and vim.api.nvim_buf_is_valid(term_bufs[term_index]) then
        -- If the window is valid, switch to it
        if term_wins[term_index] and vim.api.nvim_win_is_valid(term_wins[term_index]) then
            vim.api.nvim_set_current_win(term_wins[term_index])
        else
            -- Otherwise, open the buffer in a new split and update the window id
            vim.cmd('split')
            vim.cmd('wincmd J')
            vim.api.nvim_set_current_buf(term_bufs[term_index])
            term_wins[term_index] = vim.api.nvim_get_current_win()
        end
    else
        -- Create a new terminal buffer if it doesn't exist
        vim.cmd('split')
        vim.cmd('wincmd J')
        vim.cmd('term')
        term_wins[term_index] = vim.api.nvim_get_current_win()
        term_bufs[term_index] = vim.api.nvim_get_current_buf()
    end

    -- Set the height of the terminal window
    vim.api.nvim_win_set_height(term_wins[term_index], 12)
    vim.wo.winfixheight = true

    -- Enter insert mode
    vim.cmd('startinsert')
end

-- Key mappings for terminals
vim.api.nvim_set_keymap('n', '<leader>t', '', { noremap = true, silent = true, desc = "Open terminal in horizontal split", callback = function() open_terminal(1) end })
