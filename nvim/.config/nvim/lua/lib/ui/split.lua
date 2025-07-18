local M = {}

-- Configurable thresholds
local MIN_WIDTH_FOR_VSPLIT = 150
local MIN_HEIGHT_FOR_HSPLIT = 40

--- Creates a smart split and returns the window ID
-- @param preference 'vertical' | 'horizontal' | nil
-- @return number window_id
function M.smart_split(preference)
  local cur_win = vim.api.nvim_get_current_win()
  local width = vim.api.nvim_win_get_width(cur_win)
  local height = vim.api.nvim_win_get_height(cur_win)

  local use_vsplit

  if preference == "vertical" then
    use_vsplit = true
  elseif preference == "horizontal" then
    use_vsplit = false
  else
    use_vsplit = width >= MIN_WIDTH_FOR_VSPLIT or height < MIN_HEIGHT_FOR_HSPLIT
  end

  vim.cmd(use_vsplit and "vsplit" or "split")
  return vim.api.nvim_get_current_win()
end

return M
