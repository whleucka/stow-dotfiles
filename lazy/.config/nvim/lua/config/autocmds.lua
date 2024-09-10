-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Fix OSC52 yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
        local copy_to_unnamedplus = require('vim.ui.clipboard.osc52').copy('+')
        copy_to_unnamedplus(vim.v.event.regcontents)
        local copy_to_unnamed = require('vim.ui.clipboard.osc52').copy('*')
        copy_to_unnamed(vim.v.event.regcontents)
    end
})

-- For nvimgelion
-- vim.api.nvim_create_autocmd({ 'ColorScheme', 'FileType' }, {
--   callback = function ()
--     vim.cmd([[
--       hi IndentBlanklineChar gui=nocombine guifg=#444C55
--       hi IndentBlanklineSpaceChar gui=nocombine guifg=#444C55
--       hi IndentBlanklineContextChar gui=nocombine guifg=#FB5E2A
--       hi IndentBlanklineContextStart gui=underline guisp=#FB5E2A
--     ]])
--   end,
-- })
