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

-- C++ specific settings
vim.bo.commentstring = '// %s'
vim.bo.syntax = 'cpp'

-- Function to set window-local options
local function set_window_options()
    vim.wo.foldmethod = 'syntax'
    vim.wo.foldlevelstart = 99
end

-- Set window-local options using an autocmd
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.cpp",
    callback = set_window_options
})

