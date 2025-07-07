vim.cmd([[
  highlight StatusLine guibg=#1e1e2e guifg=#cdd6f4
  highlight StatusLineMode guibg=#89b4fa guifg=#1e1e2e gui=bold
  highlight StatusLineFile guibg=NONE guifg=#cba6f7
  highlight StatusLineGit guibg=NONE guifg=#a6e3a1
  highlight StatusLineExtra guibg=NONE guifg=#bac2de
]])

function _G.statusline()
  local mode_map = {
    n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE",
    [""] = "V-BLOCK", c = "COMMAND", R = "REPLACE",
  }

  local mode = mode_map[vim.fn.mode()] or "OTHER"
  local filename = vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "[No Name]"
  local filetype = vim.bo.filetype
  local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local percent = math.floor((line / vim.fn.line("$")) * 100)

  -- Optional: Git branch
  local branch = vim.b.gitsigns_head or ""
  local git_section = branch ~= "" and string.format(" %s ", branch) or ""

  local left = string.format(" %%#StatusLineMode# %s ", mode)
  local mid = string.format("%%#StatusLineFile# %s ", filename)
  local git = git_section ~= "" and string.format("%%#StatusLineGit# %s", git_section) or ""
  local right = string.format("%%=%%#StatusLineExtra# %s | %s | %d:%d (%d%%%%) ",
    filetype, encoding, line, col, percent)

  return left .. mid .. git .. right
end

vim.o.statusline = "%!v:lua.statusline()"
