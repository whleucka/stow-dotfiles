-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.rnu = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- No swap files
vim.opt.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Default indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- NOTE: cmdheight 0 has "Press enter to continue" issue
vim.o.cmdheight = 1
vim.o.laststatus = 3


local function winbar()
  local file_name = "%-.16t"
  -- local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
  -- local buf_nr = "[%n]"
  -- local modified = " %-m"
  -- local file_type = " %y"
  -- local right_align = "%="
  -- local line_no = "%10([%l/%L%)]"
  -- local pct_thru_file = "%5p%%"

  return string.format("%s", file_name)
end

vim.opt.winbar = winbar()
