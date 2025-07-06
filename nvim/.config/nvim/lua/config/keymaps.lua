local map = vim.keymap.set
local opts = { silent = true }

vim.g.mapleader = " "

-- Basic shit
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>qq", ":qa<CR>", opts)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- Yank file
map("n", "<leader>Y", "ggVGy", opts)

-- Buffers
map("n", "H", ":bprevious<CR>", opts)
map("n", "L", ":bnext<CR>", opts)
map("n", "<leader>bd", ":bp | bd #<CR>", opts)

-- Splits
map("n", "<leader>\\", ":vsplit<CR>", opts)
map("n", "<leader>-", ":split<CR>",  opts)

-- Window nav
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

-- Quickfix
map("n", "q[", ":cprev<CR>zz", opts)
map("n", "q]", ":cnext<CR>zz", opts)

-- File explorer
map("n", "<leader>e", function()
    -- Close netrw if open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "netrw" then
            vim.api.nvim_win_close(win, true)
            return
        end
    end

    -- Open netrw sidebar
    -- This command opens a vertical split and opens netrw there
    vim.cmd("vertical leftabove 30vsplit")
    vim.cmd("Explore")
end, opts)

-- Find files
vim.keymap.set("n", "<leader>f", function()
    local input = vim.fn.input("Find files: ")
    if input == "" then return end
    local cmd = string.format("rg --files | rg -F %q", input)
    local output = vim.fn.systemlist(cmd)

    -- If no results
    if vim.v.shell_error ~= 0 or vim.tbl_isempty(output) then
        vim.notify("No matches found for: " .. input, vim.log.levels.INFO)
        return
    end

    -- Convert to quickfix format
    local qf_list = {}
    for _, line in ipairs(output) do
        table.insert(qf_list, { filename = line, lnum = 1, col = 1, text = line })
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.cmd("copen")
end)

-- Search with rg
vim.keymap.set("n", "<leader>s", function()
    local input = vim.fn.input("Search for: ")
    if input == "" then return end
    local cmd = { "rg", "--vimgrep", input }
    local output = vim.fn.systemlist(cmd)

    -- If no results
    if vim.v.shell_error ~= 0 or vim.tbl_isempty(output) then
        vim.notify("No matches found for: " .. input, vim.log.levels.INFO)
        return
    end

    -- Populate quickfix list
    vim.fn.setqflist({}, " ", {
        title = "rg: " .. input,
        lines = output,
    })
    vim.cmd("copen")
end)
