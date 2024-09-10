-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Exit insert mode
map("i", "jk", "<C-c>", { desc = "Exit insert mode" })
map("i", "kj", "<C-c>", { desc = "Exit insert mode" })

-- Focus
local focusmap = function(direction)
    map("n", "<C-" .. direction .. ">", function()
        require("focus").split_command(direction)
    end, { desc = string.format("Create or move to split (%s)", direction) })
end

focusmap("h")
focusmap("j")
focusmap("k")
focusmap("l")

map("n", "<leader>ws", "<ESC>")
map("n", "<leader>wv", "<ESC>")

map("n", "<leader>w", "<cmd>update<cr>", { desc = "Update (save) buffer" })

map("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Neogit" })
