--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd[[
call serverstart(tempname())
let &titlestring="nvim %F -- [" . v:servername . "]"
set title
]]

require "custom.config.lazy"
require "custom.config.telescope"
require "custom.config.treesitter"
require "custom.options"
require "custom.mappings"
require "custom.config.autocmds"
require "custom.config.lsp"
