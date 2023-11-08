--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd[[
call serverstart(tempname())
let &titlestring="nvim %F -- [" . v:servername . "]"
set title
]]

require "config.lazy"
require "config.telescope"
require "config.treesitter"
require "config.options"
require "config.mappings"
require "config.autocmds"
require "config.lsp"
