return {
  url = "https://github.com/catppuccin/nvim",
  name = "catppuccin-nvim",
  setup = function()
    -- Theme
    vim.cmd.colorscheme("catppuccin")
    local set_hl = vim.api.nvim_set_hl
    local colour = require("catppuccin.palettes").get_palette "macchiato"
    function hl(type, opts)
      set_hl(0, type, opts)
    end
    hl("BufferLineBackground", { fg = colour.subtext0, bg = colour.base })
    hl("BufferLineInactive", { fg = "#666666", bg = colour.base })
    hl("BufferLineActive", { fg = "#444444", bg = colour.yellow, bold = true })
    hl("StatusLine",  { fg = colour.subtext0, bg = "none" })
    hl("StatusLineMode",  { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
    hl("StatusLineFile",  { fg = "#cba6f7", bg = "none" })
    hl("StatusLineGit",  { fg = "#a6e3a1", bg = "none" })
    hl("StatusLineExtra",  { fg = "#bac2de", bg = "none" })
  end
}
