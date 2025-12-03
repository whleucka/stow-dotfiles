-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 150, on_visual = true })
  end,
})

-- Treesitter update
vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('nvim-treesitter-pack-changed-update-handler', { clear = true }),
    callback = function(event)
        if event.data.kind == 'update' then
            vim.notify('nvim-treesitter updated, running TSUpdate...', vim.log.levels.INFO)
            ---@diagnostic disable-next-line: param-type-mismatch
            local ok = pcall(vim.cmd, 'TSUpdate')
            if ok then
                vim.notify('TSUpdate completed successfully!', vim.log.levels.INFO)
            else
                vim.notify('TSUpdate command not available yet, skipping', vim.log.levels.WARN)
            end
        end
    end,
})

-- Smart Winbar: file icon + name + git branch/status
local devicons = require("nvim-web-devicons")

local function get_git_info()
  local branch = vim.b.gitsigns_head or ""
  local status = vim.b.gitsigns_status or ""

  if branch ~= "" then
    branch = " " .. branch
  end

  if status and status ~= "" then
    status = " " .. status
  end

  return branch .. status
end

local function get_file_info()
  local file = vim.fn.expand("%:t")
  if file == "" then
    return ""
  end

  local ext = vim.fn.expand("%:e")
  local icon, icon_hl = devicons.get_icon(file, ext, { default = true })

  return "%#" .. icon_hl .. "#" .. icon .. "%* " .. file
end

local function set_winbar()
  vim.cmd([[
    hi WinBar guibg=NONE guifg=#a6adc8
    hi WinBarNC guibg=NONE guifg=#6c7086
  ]])
  local file_info = get_file_info()
  local git_info = get_git_info()

  vim.wo.winbar = table.concat({
    file_info,
    "%=",
    "%#LineNr#", -- subtle color for right side
    git_info,
  })
end

vim.api.nvim_create_autocmd({ "BufReadPost", "CursorHold" }, {
  callback = set_winbar,
})

-- Restore last cursor pos
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup('restore-cursor-pos', { clear = true }),
  callback = function(args)
    local buf = args.buf
    local pos = vim.api.nvim_buf_get_mark(buf, '"')
    local lines = vim.api.nvim_buf_line_count(buf)
    if pos[1] > 0 and pos[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, pos)
    end
  end,
})

-- Auto reload file if changed
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = vim.api.nvim_create_augroup('auto-reload-file', { clear = true }),
  command = "checktime"
})

-- Enable spellcheck
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup('enable-spellcheck', { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Clear search
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup('clear-search-cursor-move', { clear = true }),
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.mode() == "n" then
      vim.cmd("nohlsearch")
    end
  end,
})

-- Close with q
-- one group, created once
local close_grp = vim.api.nvim_create_augroup("close-with-q", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = close_grp,
  pattern = { "help", "man", "qf", "oil" },
  callback = function(ev)
    -- buffer-local mapping so it doesn't steal "q" globally
    vim.keymap.set("n", "q", function()
      -- close floats or regular windows
      local cfg = vim.api.nvim_win_get_config(0)
      if cfg and cfg.relative ~= "" then
        vim.api.nvim_win_close(0, true)
      else
        vim.cmd.close()
      end
    end, { buffer = ev.buf, silent = true, desc = "Close window with q" })

    -- don't list these buffers
    vim.bo[ev.buf].buflisted = false
  end,
})

