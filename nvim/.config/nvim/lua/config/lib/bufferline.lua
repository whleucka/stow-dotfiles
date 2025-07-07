vim.cmd([[
  highlight BufferLineInactive guifg=#666666 guibg=NONE
  highlight BufferLineActive guifg=#ffffff guibg=#5f87af gui=bold
]])

function _G.bufferline()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local current = vim.api.nvim_get_current_buf()
  local line = ""

  for i, buf in ipairs(buffers) do
    local name = vim.fn.fnamemodify(buf.name, ":t") or "[No Name]"
    local hl = (buf.bufnr == current) and "%#BufferLineActive#" or "%#BufferLineInactive#"
    line = line .. hl .. " " .. name .. " "
  end

  return line .. "%#Normal#" -- reset highlighting at the end
end
