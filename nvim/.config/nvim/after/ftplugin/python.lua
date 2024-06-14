-- Set the indentation style
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

-- Smart indentation
vim.bo.smartindent = true
vim.bo.autoindent = true

-- Additional settings for convenience
vim.bo.formatoptions = vim.bo.formatoptions .. 'cro'

-- Python specific settings
vim.bo.commentstring = '# %s'
vim.bo.syntax = 'python'

-- Function to set window-local options
local function set_window_options()
    vim.wo.foldmethod = 'indent'
    vim.o.foldlevelstart = 99
end

-- Set window-local options using an autocmd
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.py",
    callback = set_window_options
})

