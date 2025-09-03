-- Set indentation width
vim.opt_local.shiftwidth = 2   -- # of spaces for each indent level
vim.opt_local.tabstop = 2      -- # of spaces a tab counts for
vim.opt_local.softtabstop = 2  -- # of spaces when hitting Tab in insert mode
vim.opt_local.expandtab = true -- Use spaces instead of tabs

-- Optional: enable C-style auto-indenting
vim.opt_local.cindent = true
vim.opt_local.smartindent = true

-- Optional: tweak `cindent` rules
vim.opt_local.cinoptions = {
  "g0", -- class scope: no extra indent
  "N-s", -- namespace with no extra indent
  "E-s", -- else at same level as if
}
