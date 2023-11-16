local grp = vim.api.nvim_create_augroup("GENERAL", { clear = true })

-- Highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = grp,
    desc = 'Highlight after yank',
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 })
    end,
})

-- Restore last cursor position
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    group = grp,
    desc = 'Return cursor to last position',
    pattern = '*',
    command = 'silent! normal! g`"zv',
})

-- Remove white space on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = grp,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- Start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
    group   = grp,
    pattern = '*',
    command = 'startinsert | set winfixheight'
})

-- Exit help page pressing q
vim.api.nvim_create_autocmd("FileType", {
    group = grp,
    pattern = {
        "help",
        "startuptime",
        "qf",
        "lspinfo",
        "man",
        "checkhealth",
    },
    command = [[
            nnoremap <buffer><silent> q :close<CR>
            set nobuflisted
            ]],
})

-- Terminal keys
local function set_terminal_keymaps()
    local opts = {}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = [[term://*]],
    callback = set_terminal_keymaps
})

-- Resize windows/splits
local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })

vim.api.nvim_create_autocmd(
    'VimResized',
    {
        group = wr_group,
        pattern = '*',
        command = 'wincmd =',
        desc = 'Automatically resize windows when the host window size changes.'
    }
)
