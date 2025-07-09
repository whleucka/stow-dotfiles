local M = {}

M.blame_line = function()
  local filepath = vim.fn.expand('%:p')
  local line = vim.fn.line('.')

  -- Run git blame on the specific line
  local cmd = string.format("git blame -L %d,%d -- %s", line, line, filepath)
  local result = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("Git blame failed: " .. table.concat(result, "\n"), vim.log.levels.ERROR)
    return
  end

  -- Open a new scratch buffer in a horizontal split
  vim.cmd('split')
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.filetype = 'gitblame'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
end

M.diff_current_file = function()
  local filepath = vim.fn.expand('%:p')
  local relpath = vim.fn.fnamemodify(filepath, ':.') -- repo-relative path

  -- Open vertical split and run the command in a terminal buffer
  vim.cmd('vsplit')
  vim.cmd('terminal git diff --color=always -- ' .. relpath)
  vim.cmd('startinsert')
end

return M
