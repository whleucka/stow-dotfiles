return {
  url = "https://github.com/akinsho/bufferline.nvim",
  dependencies = {
    {
      url = "https://github.com/nvim-tree/nvim-web-devicons",
    }
  },
  config = function()
    require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
