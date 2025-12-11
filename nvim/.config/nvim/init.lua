-- This will record startup time
vim.g.__nvim_start_time = vim.loop.hrtime()

require("config.plugins")
require('config.globals')
require('config.options')

require('config.autocmd')
require('config.lsp')
require("config.keymap")
