vim.api.nvim_create_augroup("default", { clear = true })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "default",
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

-- Restore cursor pos
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "default",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Handle close with quickfix
vim.api.nvim_create_autocmd("WinEnter", {
  group = "default",
  pattern = "*",
  callback = function()
    local wins = vim.api.nvim_list_wins()
    if #wins == 1 then
      local buftype = vim.bo[vim.api.nvim_win_get_buf(wins[1])].buftype
      if buftype == "quickfix" then
        vim.cmd("quit")
      end
    end
  end
})

-- Turn off line numbers in quickfix
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Start insert mode terminal
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "WinEnter" }, {
  group = "default",
  pattern = "term://*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end
})

-- Use 'q' to close panels
vim.api.nvim_create_autocmd("FileType", {
  group = "default",
  pattern = {
    "qf", "help", "man", "lspinfo", "startuptime", "checkhealth", "netrw", "terminal", "git", "gitblame", "gitdiff", "gitcommit",
    "fugitive", "fugitiveblame", "fugitivediff", "notifylog"
  },
  callback = function()
    vim.keymap.set("n", "q", function()
      vim.cmd("nohlsearch")
      vim.cmd("close")
    end, { buffer = true, silent = true })
  end,
})

-- Autocomplete
vim.api.nvim_create_autocmd('LspAttach', {
  group = "default",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
