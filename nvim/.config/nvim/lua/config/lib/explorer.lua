local M = {}

function M.toggle_netrw()
  -- Close netrw if open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "netrw" then
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  -- Opens a netrw vertical split
  vim.cmd("vertical leftabove 30vsplit")
  vim.cmd("Explore")
end

function M.grep_files()
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
end

function M.find_files()
  local input = vim.fn.input({
    prompt = "Find files: ",
    completion = "file"
  })
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
    files_cmd = string.format([[
      find . -type f \
        -not -path "*/.git/*" \
        -not -path "*/node_modules/*" \
        -not -path "*/vendor/*" \
      | grep -F %q
    ]], input)
  end

  local output = vim.fn.systemlist(files_cmd)

  if vim.v.shell_error ~= 0 or vim.tbl_isempty(output) then
    vim.notify("No files matched: " .. input, vim.log.levels.INFO)
    return
  end

  local qf_list = {}
  for _, file in ipairs(output) do
    table.insert(qf_list, { filename = file, text = file })
  end

  vim.fn.setqflist({}, "r", {
    title = "Find files: " .. input,
    items = qf_list,
  })

  vim.cmd("copen")

  -- Auto-close when user selects an item (moves out of quickfix window)
  vim.defer_fn(function()
    local qf_win = vim.fn.win_getid()

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("FindFilesAutoCloseQf", { clear = true }),
      callback = function()
        -- Check if quickfix is still open
        local open_qf = false
        for _, win in ipairs(vim.fn.getwininfo()) do
          if win.quickfix == 1 then
            open_qf = true
            break
          end
        end

        if open_qf then
          vim.cmd("cclose")
        end
      end,
      once = true,
    })
  end, 10)
end

return M
