local map = vim.keymap.set

-- Disable
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map("n", "Q", "<Nop>", { silent = true, noremap = true })
map("n", "q", "<Nop>", { silent = true, noremap = true })

-- Create undo breakpoints
map('i', '<space>', " <C-g>u")

-- Undo some stuff
map('n', '<leader>u', ':UndotreeToggle<CR>', {silent = true, noremap = true})

-- Saving and quitting
map('n', '<leader>w', ':update<CR>', { silent = true, noremap = true, desc = "Save (update)" })
map('n', '<leader>W', ':w!<CR>', { silent = true, noremap = true, desc = "Save (force)" })
map('n', '<leader>q', ':q<CR>', { silent = true, noremap = true, desc = "Exit window" })
map('n', '<leader>Q', ':qa!<CR>', { silent = true, noremap = true, desc = "Exit Neovim (force)" })
map('n', '<leader>c', ":BufferLinePickClose<cr>", { silent = true, noremap = true, desc = "Close buffer" })

-- Buffers
map('n', '<leader><enter>', function()
    vim.cmd.enew()
    vim.cmd[[ Dashboard ]]
end, { silent = true, noremap = true, desc = "Show dashboard" })
map('n', '<leader><space>', ":BufferLinePick<cr>", { silent = true, noremap = true, desc = "Pick buffer" })
map('n', '<S-h>', ":BufferLineCyclePrev<cr>", { silent = true, noremap = true, desc = "Previous buffer" })
map('n', '<S-l>', ":BufferLineCycleNext<cr>", { silent = true, noremap = true, desc = "Next buffer" })
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

-- Select all
map('n', '<leader>a', 'ggVG', { silent = true, noremap = true, desc = "Select all" })

-- Delete backwards
map('n', '<a-bs>', 'db', { silent = true, noremap = true, desc = "Delete word backwards" })
map('i', '<a-bs>', '<esc>ldbi', { silent = true, noremap = true, desc = "Delete word backwards" })

-- Leave insert mode
map('i', 'jk', '<ESC>', { silent = true })
map('i', 'kj', '<ESC>', { silent = true })


-- Trouble
map("n", "<leader>xx", function() require("trouble").toggle() end, { silent = true, noremap = true, desc = "Trouble (toggle)" } )
map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, { silent = true, noremap = true, desc = "Trouble Workspace Diagnostics"  })
map("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, { silent = true, noremap = true, desc = "Trouble Document Diagnostics"  })
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { silent = true, noremap = true, desc = "Trouble Quickfix List"  })
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { silent = true, noremap = true, desc = "Trouble Location List"  })
map("n", "gR", function() require("trouble").toggle("lsp_references") end, { silent = true, noremap = true, desc = "Trouble LSP references"  })

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
map('n', '<c-s>', ':so<CR>', { silent = true, noremap = true, desc = "Source buffer" })

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

-- Focus
-- <leader>direction to create/switch to split
local focusmap = function(direction)
    map('n', '<leader>' .. direction, function()
        require('focus').split_command(direction)
    end, { desc = string.format('Create or move to split (%s)', direction) })
end

-- Create split or move to split
focusmap('h')
focusmap('j')
focusmap('k')
focusmap('l')

-- Resize splits (on the select window to resize)
map('n', "<C-Right>", '<C-w><', { desc = 'Increase Window Width', noremap = true, silent = true })
map('n', "<C-Left>", '<C-w>>', { desc = 'Decrease Window Width', noremap = true, silent = true })
map('n', "<C-Up>", '<C-w>+', { desc = 'Increase Window Height', noremap = true, silent = true })
map('n', "<C-Down>", '<C-w>-', { desc = 'Decrease Window Height', noremap = true, silent = true })

-- Lazy
map('n', '<leader>p', ':Lazy<CR>', { desc = "Lazy", silent = true, noremap = true })
map('n', '<leader>ps', ':Lazy sync<CR>', { desc = "Lazy sync", silent = true, noremap = true })
map('n', '<leader>ps', ':Lazy update<CR>', { desc = "Lazy update", silent = true, noremap = true })
map('n', '<leader>pc', ':Lazy clean<CR>', { desc = "Lazy clean", silent = true, noremap = true })
map('n', '<leader>pp', ':Lazy profile<CR>', { desc = "Lazy profile", silent = true, noremap = true })

-- Primeagen remaps
map("n", "J", "mzJ`z", { silent = true, noremap = true })
map("n", "n", "nzzzv", { silent = true, noremap = true })
map("n", "N", "Nzzzv", { silent = true, noremap = true })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 5 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
map('n', 'j', "v:count == 5 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })

-- DAP
map('n', '<F5>', function() require('dap').continue() end, { silent = true, desc = "DAP continue" })
map('n', '<F10>', function() require('dap').step_over() end, { silent = true, desc = "DAP step over" })
map('n', '<F11>', function() require('dap').step_into() end, { silent = true, desc = "DAP step into" })
map('n', '<F12>', function() require('dap').step_out() end, { silent = true, desc = "DAP step out" })
map('n', '<leader>du', function() require('dapui').toggle() end, { silent = true, desc = "DAP UI toggle" })
map('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { silent = true, desc = "DAP toggle breakpoint" })
map('n', '<Leader>db', function() require('dap').set_breakpoint() end, { silent = true, desc = "DAP set breakpoint" })
map('n', '<Leader>dm', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { silent = true, desc = "DAP log point msg" })
map('n', '<Leader>dR', function() require('dap').repl.open() end, { silent = true, desc = "DAP REPL open" })
map('n', '<Leader>dr', function() require('dap').run_last() end, { silent = true, desc = "DAP run last" })
map({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end, { silent = true, desc = "DAP hover" })
map({'n', 'v'}, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end, { silent = true, desc = "DAP preview" })
map('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end, { silent = true, desc = "DAP frames" })
map('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end, { silent = true, desc = "DAP scopes" })


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
