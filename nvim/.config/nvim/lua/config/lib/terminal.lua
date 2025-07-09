local M = {}

local term_buf = nil
local term_win = nil

function M.toggle()
  -- If terminal is visible, hide it
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  -- If terminal buffer doesn't exist, create it and start terminal
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    vim.cmd("split")
    vim.cmd("resize 15")
    term_win = vim.api.nvim_get_current_win()
    term_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(term_win, term_buf)
    vim.fn.termopen(vim.o.shell)
  else
    -- Reopen existing terminal buffer in split
    vim.cmd("split")
    vim.cmd("resize 15")
    term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(term_win, term_buf)
  end

  -- Disable line numbers
  vim.wo.number = false
  vim.wo.relativenumber = false
end

return M
