-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

-- Restore cursor pos
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Bufferline
vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        local ft = vim.bo.filetype
        local exclude = {
            ["qf"] = true,
            ["help"] = true,
            ["lspinfo"] = true,
            ["netrw"] = true,
        }

        if exclude[ft] or vim.api.nvim_win_get_config(0).relative ~= "" then
            vim.wo.winbar = ""
        else
            vim.wo.winbar = "%{%v:lua.bufferline()%}"
        end
    end,
})

-- Use 'q' to close panels
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf", "help", "man", "lspinfo", "startuptime", "checkhealth", "netrw",
    },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true, desc = "Close window" })
    end,
})
