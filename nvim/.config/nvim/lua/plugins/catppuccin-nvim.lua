return {
  url = "https://github.com/catppuccin/nvim",
  name = "catppuccin-nvim",
  priority = 99,
  config = function()
    require("catppuccin").setup({
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = false,
        blink_cmp = {
          style = 'bordered',
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })
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
