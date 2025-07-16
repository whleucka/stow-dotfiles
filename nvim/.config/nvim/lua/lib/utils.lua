local notify_bufnr = nil

local function split_lines(s)
  local t = {}
  for line in s:gmatch("[^\r\n]+") do
    table.insert(t, line)
  end
  return t
end

local function notify(msg, level, opts)
  vim.schedule(function()
    -- Ensure the buffer exists
    if not notify_bufnr or not vim.api.nvim_buf_is_valid(notify_bufnr) then
      notify_bufnr = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]
      vim.api.nvim_buf_set_name(notify_bufnr, "Notifications")

      -- Set some buffer options
      vim.bo[notify_bufnr].bufhidden = "wipe"
      vim.bo[notify_bufnr].filetype = "notifylog"
      vim.bo[notify_bufnr].buftype = "nofile"
    end

    -- Append the message
    vim.bo[notify_bufnr].modifiable = true
    vim.api.nvim_buf_set_lines(notify_bufnr, -1, -1, false, split_lines(msg))
    vim.bo[notify_bufnr].modifiable = false

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == notify_bufnr then
        local line_count = vim.api.nvim_buf_line_count(notify_bufnr)
        vim.api.nvim_win_set_cursor(win, { line_count, 0 })
      end
    end

    -- Open in a split if not visible
    local is_open = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == notify_bufnr then
        is_open = true
        break
      end
    end

    if not is_open then
      vim.cmd("botright split")
      vim.api.nvim_win_set_buf(0, notify_bufnr)
      vim.api.nvim_win_set_height(0, 15)
      local win = vim.api.nvim_get_current_win()
      vim.wo[win].number = false
      vim.wo[win].relativenumber = false
      vim.wo[win].signcolumn = "no"
      vim.wo[win].wrap = false
      vim.wo[win].cursorline = false
      vim.wo[win].foldenable = false
    end
  end)
end

-- Run async shell command
local function async_shell(opts)
  local uv = vim.loop
  local cmd = opts.cmd             -- e.g. "git"
  local args = opts.args or {}     -- e.g. { "clone", "url", "dir" }
  local cwd = opts.cwd or nil      -- optional working directory
  local on_exit = opts.on_exit     -- optional callback(code, signal)
  local on_stdout = opts.on_stdout -- optional stdout callback(data, err)
  local on_stderr = opts.on_stderr -- optional stderr callback(data, err)

  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  local handle
  handle = uv.spawn(cmd, {
    args = args,
    cwd = cwd,
    stdio = { nil, stdout, stderr },
  }, function(code, signal)
    stdout:close()
    stderr:close()
    handle:close()

    vim.schedule(function()
      if on_exit then
        on_exit(code, signal)
      else
        if code == 0 then
          notify(cmd .. " finished successfully")
        else
          notify(cmd .. " exited with code " .. code)
        end
      end
    end)
  end)

  stdout:read_start(function(err, data)
    if on_stdout then
      on_stdout(data, err)
    else
      if err then
        vim.schedule(function()
          notify("STDOUT error: " .. err)
        end)
      elseif data then
        vim.schedule(function()
          notify(data)
        end)
      end
    end
  end)

  stderr:read_start(function(err, data)
    if on_stderr then
      on_stderr(data, err)
    else
      if err then
        vim.schedule(function()
          notify("STDERR error: " .. err)
        end)
      elseif data then
        vim.schedule(function()
          notify(data)
        end)
      end
    end
  end)
end

local M = {
  command = {
    async = function(opts)
      async_shell(opts)
    end
  },
  log = {
    notify = function(msg, level)
      notify(msg, level or vim.log.levels.INFO)
    end,
    info = function(msg)
      notify("ℹ️  " .. msg, vim.log.levels.INFO)
    end,
    success = function(msg)
      notify("✅  " .. msg, vim.log.levels.INFO)
    end,
    debug = function(msg)
      notify("👾  " .. msg, vim.log.levels.DEBUG)
    end,
    error = function(msg)
      notify("☠️  " .. msg, vim.log.levels.ERROR)
    end,
    warn = function(msg)
      notify("⚠️  " .. msg, vim.log.levels.WARN)
    end,
    system = function(msg)
      notify("🖥️  " .. msg, vim.log.levels.INFO)
    end,
    package = function(msg)
      notify("📦  " .. msg, vim.log.levels.INFO)
    end,
  },
}

return M
