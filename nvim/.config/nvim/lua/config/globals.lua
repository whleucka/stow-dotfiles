-- i3-easy-nav
vim.cmd[[call serverstart(tempname())]]
vim.cmd[[let &titlestring="nvim %F -- [" . v:servername . "]"]]
vim.cmd[[set title]]

-- Leader, etc
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
