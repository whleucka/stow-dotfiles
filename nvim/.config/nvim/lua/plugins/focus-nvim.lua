return {
  url = "https://github.com/nvim-focus/focus.nvim",
  config = function()
    require("focus").setup()
  end,
  keys = function(map, opts)
    map("n", "<leader>l", ":FocusSplitRight<CR>", opts)
    map("n", "<leader>h", ":FocusSplitLeft<CR>", opts)
    map("n", "<leader>j", ":FocusSplitDown<CR>", opts)
    map("n", "<leader>k", ":FocusSplitUp<CR>", opts)
    map("n", "<F2>", ":FocusToggle<CR>", opts)
  end
}
