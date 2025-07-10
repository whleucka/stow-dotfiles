function _G.bufferline()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local current = vim.api.nvim_get_current_buf()
  local line = ""

  for _, buf in ipairs(buffers) do
    local bt = vim.bo[buf.bufnr].buftype
    if bt == "" or bt == "acwrite" then
      local name = buf.name ~= "" and vim.fn.fnamemodify(buf.name, ":t") or "No Name " .. buf.bufnr
      local hl = (buf.bufnr == current) and "%#BufferLineActive#" or "%#BufferLineInactive#"
      line = line .. hl .. " [" .. name .. "] "
    end
  end

  -- Apply background for leftover space so bg isn’t black
  return line .. "%#BufferLineBackground#"
end
