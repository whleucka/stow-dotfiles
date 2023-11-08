-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For clipboard
vim.cmd[[
call serverstart(tempname())
let &titlestring="nvim %F -- [" . v:servername . "]"
set title
]]

-- Start
require("whleucka.core")
require("whleucka.lazy")
