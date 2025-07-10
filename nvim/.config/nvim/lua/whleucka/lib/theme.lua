local theme = {
  base      = "#292c3c",
  mantle    = "#232634",
  crust     = "#1e2030",
  surface0  = "#403f4e",
  surface1  = "#595a6e",
  surface2  = "#757688",
  overlay0  = "#8e8fa8",
  overlay1  = "#a8a9be",
  overlay2  = "#bfc0d3",
  text      = "#d9dce8",
  subtext1  = "#c5c7d9",
  subtext0  = "#b0b3c5",
  rosewater = "#f4c7c3",
  flamingo  = "#f5a5a8",
  pink      = "#f0a6ca",
  mauve     = "#d9a9f6",
  red       = "#ef7186",
  maroon    = "#ef8a9a",
  peach     = "#fab68f",
  yellow    = "#fae09e",
  green     = "#aceb8a",
  teal      = "#8ce9d0",
  sky       = "#8bdaf7",
  sapphire  = "#74caff",
  blue      = "#89b4fa",
  lavender  = "#cbb9fa",
}

-- Set the background
vim.o.background = "dark"
vim.cmd("hi clear")
vim.cmd("syntax reset")

-- Apply highlights
local set = vim.api.nvim_set_hl

set(0, "Normal",       { fg = theme.text,     bg = theme.base })
set(0, "Comment",      { fg = theme.yellow, italic = true })
set(0, "Constant",     { fg = theme.peach })
set(0, "String",       { fg = theme.green })
set(0, "Function",     { fg = theme.blue })
set(0, "Keyword",      { fg = theme.mauve, bold = true })
set(0, "Identifier",   { fg = theme.teal })
set(0, "Type",         { fg = theme.yellow })
set(0, "Statement",    { fg = theme.mauve })
set(0, "Number",       { fg = theme.peach })
set(0, "Boolean",      { fg = theme.peach })
set(0, "Operator",     { fg = theme.sky })
set(0, "PreProc",      { fg = theme.pink })
set(0, "Special",      { fg = theme.rosewater })

-- UI
set(0, "CursorLine",   { bg = theme.surface0 })
set(0, "Visual",       { bg = theme.surface1 })
set(0, "StatusLine",   { fg = theme.subtext0, bg = theme.surface0 })
set(0, "StatusLineNC", { fg = theme.surface2, bg = theme.mantle })
set(0, "LineNr",       { fg = theme.surface2 })
set(0, "CursorLineNr", { fg = theme.lavender, bold = true })
set(0, "VertSplit",    { fg = theme.crust })

-- Diagnostic (if using LSP)
set(0, "DiagnosticError", { fg = theme.red })
set(0, "DiagnosticWarn",  { fg = theme.yellow })
set(0, "DiagnosticInfo",  { fg = theme.sky })
set(0, "DiagnosticHint",  { fg = theme.teal })

-- Statusline
set(0, "StatusLine",  { fg = "#cdd6f4", bg = "#1e1e2e" })
set(0, "StatusLineMode",  { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
set(0, "StatusLineFile",  { fg = "#cba6f7", bg = "none" })
set(0, "StatusLineGit",  { fg = "#a6e3a1", bg = "none" })
set(0, "StatusLineExtra",  { fg = "#bac2de", bg = "none" })

-- Bufferline
set(0, "BufferLineBackground", { fg = theme.subtext0, bg = theme.mantle })
set(0, "BufferLineInactive", { fg = "#666666", bg = theme.base })
set(0, "BufferLineActive", { fg = "#444444", bg = "#89b4fa", bold = true })

-- Transparent bg
set(0, "NormalFloat", { bg = "none" })
set(0, "Normal", { bg = "none" })
set(0, "NormalNC", { bg = "none" })
set(0, "EndOfBuffer", { bg = "none" })
set(0, "SignColumn", { bg = "none" })
set(0, "VertSplit", { bg = "none" })
set(0, "LineNr", { bg = "none" })
