function _G.statusline()
  local mode_map = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    [""] = "V-BLOCK",
    c = "COMMAND",
    R = "REPLACE",
  }

  local mode = mode_map[vim.fn.mode()] or "OTHER"
  local filename = vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "[No Name]"
  local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "[No type]"
  local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local percent = math.floor((line / vim.fn.line("$")) * 100)

  local left = string.format(" %%#StatusLineMode# %s ", mode)
  local mid = string.format("%%#StatusLineFile# %s ", filename)
  local git = "%{FugitiveStatusline()}"
  local right = string.format("%%=%%#StatusLineExtra# | %s | %s | %d:%d (%d%%%%) ",
    filetype, encoding, line, col, percent)

  return left .. mid .. git .. right
end

vim.o.statusline = "%!v:lua.statusline()"
