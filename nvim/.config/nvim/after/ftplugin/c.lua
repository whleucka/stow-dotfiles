-- Set the indentation style
vim.bo.tabstop = 4         -- Number of spaces that a <Tab> in the file counts for
vim.bo.shiftwidth = 4      -- Number of spaces to use for each step of (auto)indent
vim.bo.softtabstop = 4     -- Number of spaces a <Tab> counts for while performing editing operations
vim.bo.expandtab = true    -- Use spaces instead of tabs

-- Smart indentation
vim.bo.smartindent = true  -- Do smart autoindenting when starting a new line
vim.bo.autoindent = true   -- Copy indent from current line when starting a new line

-- Additional settings for convenience
vim.bo.formatoptions = vim.bo.formatoptions .. 'cro'

-- C specific settings
vim.bo.commentstring = '/* %s */'    -- Set the comment style to /* */ for C
vim.bo.syntax = 'c'                  -- Ensure syntax highlighting is set to C

-- Function to set window-local options
local function set_window_options()
    vim.wo.foldmethod = 'syntax'
    vim.o.foldlevelstart = 99
end

-- Set window-local options using an autocmd
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.c",
    callback = set_window_options
})

