-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Restore cursor position ]]
local save_pos = vim.api.nvim_create_augroup("SaveIt", {clear = true})
vim.api.nvim_create_autocmd("BufRead", {
    desc = "Restore last cursor position",
    group = save_pos,
    pattern = '*',
    command = [[call setpos(".", getpos("'\""))]]
})
local leave = vim.api.nvim_create_augroup("LeaveIt", {clear = true})
vim.api.nvim_create_autocmd("VimLeave", {
    desc = "Set cursor position on exit",
    group = leave,
    pattern = '*',
    command = "wshada!"
})


