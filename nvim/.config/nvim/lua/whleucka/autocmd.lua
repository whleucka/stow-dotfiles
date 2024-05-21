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

-- Start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
    group   = grp,
    pattern = '*',
    command = 'startinsert | set winfixheight'
})

-- Terminal keys
local function set_terminal()
    local set = vim.opt_local
    local opts = {}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)

    set.number = false
    set.relativenumber = false
    set.scrolloff = 0
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd("TermOpen", {
    group = grp,
    pattern = [[term://*]],
    callback = set_terminal
})

-- Inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(args.buf, true)
        end
        -- whatever other lsp config you want
    end
})
