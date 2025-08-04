vim.cmd[[call serverstart(tempname())]]
vim.cmd[[let &titlestring="nvim %F -- [" . v:servername . "]"]]
vim.cmd[[set title]]

require('config.globals')
require('config.options')
require('config.keymap')
require('config.autocmd')
require('config.lsp')
require('plugins.catppuccin')
require('plugins.nvim-treesitter')
