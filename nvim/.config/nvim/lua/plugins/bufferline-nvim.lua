return {
  url = "https://github.com/akinsho/bufferline.nvim",
  event = "VimEnter",
  dependencies = {
    {
      url = "https://github.com/nvim-tree/nvim-web-devicons",
      event = "VimEnter",
    }
  },
  config = function()
    require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
