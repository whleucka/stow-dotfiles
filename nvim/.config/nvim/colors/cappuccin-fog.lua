-- Colour palette
local theme = {
  base      = "#1a1c25",
  mantle    = "#14151d",
  crust     = "#0e0f14",
  surface0  = "#2a2c3a",
  surface1  = "#3a3d4e",
  surface2  = "#4b4f63",
  overlay0  = "#6b6e87",
  overlay1  = "#8184a0",
  overlay2  = "#989bb5",
  text      = "#d9e0ee",
  subtext1  = "#c3c8da",
  subtext0  = "#a6acc9",
  rosewater = "#f4c7c3",
  flamingo  = "#f5a5a8",
  pink      = "#f0a6ca",
  mauve     = "#d4b2ff",
  red       = "#ff6e85",
  maroon    = "#ea7186",
  peach     = "#ffb770",
  yellow    = "#ffe08c",
  green     = "#b6f48c",
  teal      = "#94f0dc",
  sky       = "#89e3f7",
  sapphire  = "#74d3ff",
  blue      = "#8cbaff",
  lavender  = "#cfc3ff",
  comment   = "#767c9f",
}

-- Set the background
vim.o.background = "dark"
vim.cmd("hi clear")
vim.cmd("syntax reset")

-- Apply highlights
local set = vim.api.nvim_set_hl

set(0, "Normal",       { fg = theme.text, bg = theme.base })
set(0, "Comment",      { fg = theme.comment, italic = true })
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
set(0, "CursorLine",   { bg = "none" })
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
set(0, "StatusLine",  { fg = theme.subtext0, bg = theme.base })
set(0, "StatusLineMode",  { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
set(0, "StatusLineFile",  { fg = "#cba6f7", bg = "none" })
set(0, "StatusLineGit",  { fg = "#a6e3a1", bg = "none" })
set(0, "StatusLineExtra",  { fg = "#bac2de", bg = "none" })

-- Bufferline
set(0, "BufferLineBackground", { fg = theme.subtext0, bg = theme.base })
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
