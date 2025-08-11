local M = {}

local recent_session_files = {}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  callback = function(args)
    local f = vim.fn.fnamemodify(args.file, ":p")
    recent_session_files[f] = true
  end
})

function M.grep_files()
  local ok, input = pcall(function()
    return vim.fn.input("🔎 Grep: ")
  end)
  if not ok or input == "" then return end

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

  local output = vim.fn.systemlist(grep_cmd)

  -- Show diagnostic output
  if not output then
    vim.notify("Command failed: nil output", vim.log.levels.ERROR)
    return
  end

  if vim.tbl_isempty(output) then
    vim.notify("Command returned empty output", vim.log.levels.ERROR)
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
  vim.notify("")
end

local function fuzzy_score(query, text)
  query = query:lower()
  text = text:lower()

  local score = 0
  local last_index = -1
  local consecutive = 0
  local total_gap = 0

  -- Filename part
  local filename = text:match("[^/]+$")

  -- Big boost if the *filename* starts with the query
  if filename and filename:find(query, 1, true) == 1 then
    score = score + 80
  end

  -- Smaller boost if the *full path* starts with the query
  if text:find(query, 1, true) == 1 then
    score = score + 50
  end

  for i = 1, #query do
    local ch = query:sub(i, i)
    local idx = text:find(ch, last_index + 1, true)
    if not idx then
      return -math.huge
    end

    if last_index ~= -1 then
      local gap = idx - last_index - 1
      total_gap = total_gap + gap
    end

    if idx == last_index + 1 then
      consecutive = consecutive + 1
      score = score + (consecutive * 5)
    else
      consecutive = 1
      score = score + 1
    end

    -- Reduced early match bonus to avoid long-path bias
    score = score + math.max(5 - idx, 0)
    last_index = idx
  end

  -- Shorter filename/path bonus
  score = score + math.max(0, 20 - (#text - last_index))

  -- Penalize matches spread far apart
  score = score - total_gap

  return score
end

local function pad_score(score, width)
  return string.format("%" .. width .. "s", "[" .. score .. "]")
end

local function normalize(path)
  return vim.fn.fnamemodify(path, ":p") -- absolute path
end

local function get_git_files()
  local files = {}
  if vim.fn.executable("git") == 1 and vim.fn.isdirectory(".git") == 1 then
    local output = vim.fn.systemlist("git status --porcelain --untracked-files=all")
    for _, line in ipairs(output) do
      local f = line:sub(4)
      files[normalize(f)] = true
    end
  end
  return files
end

local function get_recent_files()
  local files = {}
  for _, f in ipairs(vim.v.oldfiles) do
    files[normalize(f)] = true
  end
  return files
end

local function get_git_root()
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if root == nil or root == '' or vim.v.shell_error ~= 0 then
    return nil
  end
  return root
end

function M.find_files()
  local ok, input = pcall(function()
    return vim.fn.input({ prompt = "🔎 Find: " })
  end)
  if not ok or input == "" then return end

  local git_root = get_git_root()
  if git_root then
    vim.cmd("lcd " .. git_root)
  else
    vim.notify("Git root not found; skipping git bonuses", vim.log.levels.WARN)
  end

  -- Get candidate files (with ignores)
  local candidates
  if vim.fn.executable("rg") == 1 then
    candidates = vim.fn.systemlist("rg --files --hidden -g '!.git' -g '!node_modules' -g '!vendor'")
  else
    if vim.fn.executable("find") == 0 or vim.fn.executable("grep") == 0 then
      vim.notify("Missing required commands: ripgrep or find+grep", vim.log.levels.ERROR)
      return
    end
    candidates = vim.fn.systemlist([[
      find . -type f \
        -not -path "*/.git/*" \
        -not -path "*/node_modules/*" \
        -not -path "*/vendor/*"
    ]])
  end

  if vim.tbl_isempty(candidates) then
    vim.notify("No files found", vim.log.levels.INFO)
    return
  end

  local git_files = get_git_files()
  local recent_files = get_recent_files()

  -- Score and rank
  local scored = {}
  for _, file in ipairs(candidates) do
    local score = fuzzy_score(input, file)
    if score > -math.huge then
      if git_files[normalize(file)] then score = score + 5 end
      if recent_files[normalize(file)] then score = score + 1 end
      table.insert(scored, { score = score, file = file })
    end
  end
  table.sort(scored, function(a, b) return a.score > b.score end)

  -- Populate quickfix
  local max_score = 0
  for _, item in ipairs(scored) do
    if item.score > max_score then max_score = item.score end
  end
  local score_width = #tostring(max_score) + 2 -- for brackets

  local qf_list = {}
  for _, item in ipairs(scored) do
    table.insert(qf_list, {
      filename = item.file,
      text = string.format("%s %s", pad_score(item.score, score_width), item.file)
    })
  end
  vim.fn.setqflist({}, "r", { title = "Find files: " .. input, items = qf_list })
  vim.cmd("copen")

  -- Auto-close quickfix on selection
  vim.defer_fn(function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("find_files_autoclose", { clear = true }),
      callback = function()
        local open_qf = false
        for _, win in ipairs(vim.fn.getwininfo()) do
          if win.quickfix == 1 then
            open_qf = true
            break
          end
        end
        if open_qf then vim.cmd("cclose") end
      end,
      once = true,
    })
  end, 10)
end

return M
