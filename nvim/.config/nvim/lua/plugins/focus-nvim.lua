return {
  url = "https://github.com/nvim-focus/focus.nvim",
  config = function()
    require("focus").setup()
  end,
  keys = function(map, opts)
    map("n", "<C-Right>", ":FocusSplitRight<CR>", opts)
    map("n", "<C-Left>", ":FocusSplitLeft<CR>", opts)
    map("n", "<C-Down>", ":FocusSplitDown<CR>", opts)
    map("n", "<C-Up>", ":FocusSplitUp<CR>", opts)
    map("n", "<F2>", ":FocusToggle<CR>", opts)
    map("n", "<F3>", ":FocusAutoresize<CR>", opts)
  end
}
