return {
  url = "https://github.com/akinsho/bufferline.nvim",
  name = "bufferline-nvim",
  priority = 100,
  dependencies = {
    {
      url = "https://github.com/nvim-tree/nvim-web-devicons",
      name = "nvim-web-devicons",
    }
  },
  config = function()
    require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
