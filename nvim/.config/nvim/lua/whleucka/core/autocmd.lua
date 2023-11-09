local grp = vim.api.nvim_create_augroup("GENERAL", { clear = true })

-- Highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight after yank',
    group = grp,
    callback = function ()
        vim.highlight.on_yank({higroup="IncSearch", timeout=120})
    end,
})

-- Restore last cursor position
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
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
