return {
  url = "https://github.com/akinsho/bufferline.nvim",
  event = {"UIEnter", "BufWinEnter"},
  dependencies = {
    {
      url = "https://github.com/nvim-tree/nvim-web-devicons",
    }
  },
  config = function()
    require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end,
  keys = function(map, opts)
    -- Buffers
    map("n", "H", ":BufferLineCyclePrev<CR>", opts)
    map("n", "L", ":BufferLineCycleNext<CR>", opts)
    map("n", "<C-,>", ":BufferLineMovePrev<CR>", opts)
    map("n", "<C-.>", ":BufferLineMoveNext<CR>", opts)
    map("n", "<leader>bd", ":bp | bd #<CR>", opts)
    map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opts)
    map("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opts)
    map("n", "<leader>br", ":BufferLineCloseRight<CR>", opts)
  end
}
