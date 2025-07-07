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
map("n", "q", "<nop>", opts)

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

    local files_cmd
    local use_rg = vim.fn.executable("rg") == 1

    if use_rg then
        files_cmd = string.format("rg --files | rg -F %q", input)
    else
        if vim.fn.executable("find") == 0 or vim.fn.executable("grep") == 0 then
            vim.notify("Missing required commands: ripgrep or find+grep", vim.log.levels.ERROR)
            return
        end
        files_cmd = string.format([[find . -type f -not -path "*/.git/*" | grep -F %q]], input)
    end

    local output = vim.fn.systemlist(files_cmd)

    if vim.v.shell_error ~= 0 or vim.tbl_isempty(output) then
        vim.notify("No files matched: " .. input, vim.log.levels.INFO)
        return
    end

    local qf_list = {}
    for _, file in ipairs(output) do
        table.insert(qf_list, { filename = file, lnum = 1, col = 1, text = file })
    end

    vim.fn.setqflist({}, "r", {
        title = "Find files: " .. input,
        items = qf_list,
    })

    vim.cmd("copen")
end)

-- Search files
vim.keymap.set("n", "<leader>s", function()
    local input = vim.fn.input("Search for: ")
    if input == "" then return end

    local grep_cmd
    local use_rg = vim.fn.executable("rg") == 1

    if use_rg then
        grep_cmd = { "rg", "--vimgrep", input }
    else
        if vim.fn.executable("grep") == 0 then
            vim.notify("Neither ripgrep (rg) nor grep is installed", vim.log.levels.ERROR)
            return
        end
        grep_cmd = { "grep", "-rInH", input, "." }
    end

    -- Run command
    local output = vim.fn.systemlist(grep_cmd)

    -- Show diagnostic output
    if not output then
        vim.notify("Command failed: nil output", vim.log.levels.ERROR)
        return
    end

    if vim.tbl_isempty(output) then
        vim.notify("Command returned empty output", vim.log.levels.INFO)
        return
    end

    -- Populate quickfix list
    vim.fn.setqflist({}, " ", {
        title = (use_rg and "rg: " or "grep: ") .. input,
        lines = output,
    })

    vim.fn.setreg("/", "\\V" .. input)
    vim.opt.hlsearch = true
    vim.cmd("copen")
end)

