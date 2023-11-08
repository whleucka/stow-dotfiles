return {
  'akinsho/toggleterm.nvim',
  lazy = true,
  cmd = { "ToggleTerm", "TermExec" },
  version = "*",
  opts = {
    float_opts = {
      border = "rounded",
    },
    highlights = {
      FloatBorder = {
        guifg = "#89b4fa",
      },
    }
  },
  config = true
}

