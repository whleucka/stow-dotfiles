local M = {}

local function is_real_buffer(buf)
  return vim.api.nvim_buf_is_valid(buf)
    and vim.api.nvim_buf_is_loaded(buf)
    and vim.api.nvim_buf_get_option(buf, "buftype") == ""
    and vim.api.nvim_buf_get_option(buf, "filetype") ~= "netrw"
end

local function get_real_buffers()
  local buffers = vim.api.nvim_list_bufs()
  local real = {}
  for _, buf in ipairs(buffers) do
    if is_real_buffer(buf) then
      table.insert(real, buf)
    end
  end
  return real
end

function M.switch(forward)
  local current = vim.api.nvim_get_current_buf()
  local buffers = get_real_buffers()
  if #buffers <= 1 then return end

  local index
  for i, buf in ipairs(buffers) do
    if buf == current then
      index = i
      break
    end
  end

  if not index then return end

  local next_index
  if forward then
    next_index = (index % #buffers) + 1
  else
    next_index = (index - 2 + #buffers) % #buffers + 1
  end

  vim.api.nvim_set_current_buf(buffers[next_index])
end

return M
