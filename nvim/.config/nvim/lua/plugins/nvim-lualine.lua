return {
  url = "https://github.com/nvim-lualine/lualine.nvim",
  event = "VimEnter",
  config = function()
    require('lualine').setup()
  end
}
