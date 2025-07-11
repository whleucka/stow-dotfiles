-- Colour palette
local colour = {
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

hl("Normal",       { fg = colour.text, bg = colour.base })
hl("Comment",      { fg = colour.comment, italic = true })
hl("CursorLine",   { bg = "none" })
hl("NormalFloat", { bg = colour.base })
hl("DiffAdd",      { bg = colour.green, fg = colour.base })
hl("DiffChange",   { bg = colour.yellow, fg = colour.base })
hl("DiffDelete",   { bg = colour.red, fg = colour.base })
hl("DiffText",     { bg = colour.yellow, fg = colour.base })
hl("DiagnosticError", { fg = colour.red })
hl("DiagnosticWarn",  { fg = colour.yellow })
hl("DiagnosticInfo",  { fg = colour.sky })
hl("DiagnosticHint",  { fg = colour.teal })
hl("QuickFixLine", { bg = colour.mauve, fg = colour.base, bold = true })
hl("QuickFixSign", { fg = colour.text })
hl("StatusLine",  { fg = colour.subtext0, bg = "none" })
hl("StatusLineMode",  { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
hl("StatusLineFile",  { fg = "#cba6f7", bg = "none" })
hl("StatusLineGit",  { fg = "#a6e3a1", bg = "none" })
hl("StatusLineExtra",  { fg = "#bac2de", bg = "none" })
hl("BufferLineBackground", { fg = colour.subtext0, bg = colour.base })
hl("BufferLineInactive", { fg = "#666666", bg = colour.base })
hl("BufferLineActive", { fg = "#444444", bg = colour.yellow, bold = true })
