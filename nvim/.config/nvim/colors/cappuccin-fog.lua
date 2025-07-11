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
  comment   = "#8ea5bd",
}

-- Set the background
vim.o.background = "dark"
vim.cmd("hi clear")
vim.cmd("syntax reset")

-- Apply highlights
local set = vim.api.nvim_set_hl

function hl(type, opts)
  set(0, type, opts)
end

hl("Normal",       { fg = theme.text, bg = theme.base })
hl("Comment",      { fg = theme.comment, italic = true })
hl("Constant",     { fg = theme.peach })
hl("String",       { fg = theme.green })
hl("Function",     { fg = theme.blue })
hl("Keyword",      { fg = theme.mauve, bold = true })
hl("Identifier",   { fg = theme.teal })
hl("Type",         { fg = theme.yellow })
hl("Statement",    { fg = theme.mauve })
hl("Number",       { fg = theme.peach })
hl("Boolean",      { fg = theme.peach })
hl("Operator",     { fg = theme.sky })
hl("PreProc",      { fg = theme.pink })
hl("Special",      { fg = theme.rosewater })

-- UI
hl("CursorLine",   { bg = "none" })
hl("Visual",       { bg = theme.surface1 })
hl("StatusLine",   { fg = theme.subtext0, bg = theme.surface0 })
hl("StatusLineNC", { fg = theme.surface2, bg = theme.mantle })
hl("LineNr",       { fg = theme.surface2 })
hl("CursorLineNr", { fg = theme.lavender, bold = true })
hl("VertSplit",    { fg = theme.crust })

-- Diagnostic (if using LSP)
hl("DiagnosticError", { fg = theme.red })
hl("DiagnosticWarn",  { fg = theme.yellow })
hl("DiagnosticInfo",  { fg = theme.sky })
hl("DiagnosticHint",  { fg = theme.teal })

-- Statusline
hl("StatusLine",  { fg = theme.subtext0, bg = "none" })
hl("StatusLineMode",  { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
hl("StatusLineFile",  { fg = "#cba6f7", bg = "none" })
hl("StatusLineGit",  { fg = "#a6e3a1", bg = "none" })
hl("StatusLineExtra",  { fg = "#bac2de", bg = "none" })

-- Bufferline
hl("BufferLineBackground", { fg = theme.subtext0, bg = theme.base })
hl("BufferLineInactive", { fg = "#666666", bg = theme.base })
hl("BufferLineActive", { fg = "#444444", bg = theme.blue, bold = true })

-- Transparent bg
-- hl("NormalFloat", { bg = "none" })
-- hl("Normal", { bg = "none" })
-- hl("NormalNC", { bg = "none" })
-- hl("EndOfBuffer", { bg = "none" })
-- hl("SignColumn", { bg = "none" })
-- hl("VertSplit", { bg = "none" })
-- hl("LineNr", { bg = "none" })
