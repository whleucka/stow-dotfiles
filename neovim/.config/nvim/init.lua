--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require "custom.config.lazy"
require "custom.config.telescope"
require "custom.config.treesitter"
require "custom.options"
require "custom.mappings"
require "custom.config.autocmds"
require "custom.config.lsp"
