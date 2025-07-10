local split = require("config.lib.split")

local M = {}

-- Track terminals by key
local terminals = {}

-- Setting float width/height
local function resolve_dim(val, total)
  if type(val) == "string" and val:sub(-1) == "%" then
    local pct = tonumber(val:sub(1, -2))
    return math.floor(total * (pct / 100))
  end
  return tonumber(val) or total -- fallback to full if nil
end

-- Toggle a persistent terminal
function M.toggle(opts)
  local key = opts.key or opts.cmd
  if not key then
    vim.notify("[terminal.lua] toggle: key or cmd required", vim.log.levels.ERROR)
    return
  end

  local entry = terminals[key] or {}
  local term_buf = entry.buf
  local term_win = entry.win

  -- If terminal is already visible, hide it
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    terminals[key].win = nil
    return
  end

  -- Create buffer if it doesn't exist
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
    terminals[key] = { buf = term_buf }
  end

  local win
  if opts.float then
    -- Floaterm style
    local width = resolve_dim(opts.width, vim.o.columns)
    local height = resolve_dim(opts.height, vim.o.lines)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local float_opts = {
      relative = opts.relative or "editor",
      row = row,
      col = col,
      width = width,
      height = height,
      style = "minimal",
      border = opts.border or "rounded",
    }

    win = vim.api.nvim_open_win(term_buf, true, float_opts)
  else
    -- Use smart or directional split
    win = split.smart_split(opts.direction)
    if opts.size then
      if opts.direction == "horizontal" then
        vim.cmd("resize " .. opts.size)
      elseif opts.direction == "vertical" then
        vim.cmd("vertical resize " .. opts.size)
      end
    end
    vim.api.nvim_win_set_buf(win, term_buf)
  end

  -- Save win ref
  terminals[key].win = win

  -- Start terminal if fresh
  if vim.fn.bufname(term_buf) == "" then
    local term_opts = vim.empty_dict()
    if opts.cwd then term_opts.cwd = opts.cwd end
    if opts.on_exit then term_opts.on_exit = opts.on_exit end
    vim.fn.termopen(opts.cmd or vim.o.shell, term_opts)
  end

  if opts.startinsert ~= false then
    vim.cmd("startinsert")
  end

  -- Optional line number disabling
  vim.wo.number = false
  vim.wo.relativenumber = false
end

return M
