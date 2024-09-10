-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local global = vim.g
local opt = vim.opt

global.autoformat = false

opt.tabstop = 4
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth = 4

function no_paste(reg)
    return function(lines)
        -- Do nothing! We can't paste with OSC52
    end
end

global.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = no_paste("+"), -- Pasting disabled
        ["*"] = no_paste("*"), -- Pasting disabled
    },
}
