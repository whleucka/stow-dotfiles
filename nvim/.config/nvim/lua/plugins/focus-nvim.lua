return {
  url = "https://github.com/nvim-focus/focus.nvim",
  config = function()
    require("focus").setup()
  end,
  keys = function(map, opts)
    map("n", "<C-l>", ":FocusSplitRight<CR>", opts)
    map("n", "<C-h>", ":FocusSplitLeft<CR>", opts)
    map("n", "<C-j>", ":FocusSplitDown<CR>", opts)
    map("n", "<C-k>", ":FocusSplitUp<CR>", opts)
  end
}
