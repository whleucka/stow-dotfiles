local M = {}

local term_buf = nil
local term_win = nil

function M.gemini_cli()
  -- If gemini is visible, hide it
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  -- If gemini buffer doesn't exist, create it and start terminal
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    vim.cmd("vsplit")
    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(term_win, term_buf)
    vim.cmd('terminal gemini -- ' .. vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.'))
  else
    -- Reopen existing gemini buffer in split
    vim.cmd("vsplit")
    term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(term_win, term_buf)
  end

  -- Disable line numbers
  vim.wo.number = false
  vim.wo.relativenumber = false
end

return M
