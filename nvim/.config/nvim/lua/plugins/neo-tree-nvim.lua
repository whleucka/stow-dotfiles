return {
  url = "https://github.com/nvim-neo-tree/neo-tree.nvim",
  event = "BufWinEnter",
  dependencies = {
    {
      url = "https://github.com/nvim-lua/plenary.nvim",
    },
    {
      url = "https://github.com/nvim-tree/nvim-web-devicons",
    },
    {
      url = "https://github.com/MunifTanjim/nui.nvim",
    }
  },
  keys = function(map, opts)
    map("n", "<leader>e", ":Neotree toggle<CR>", opts)
  end
}
