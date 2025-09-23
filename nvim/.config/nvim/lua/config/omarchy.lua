-- Omarchy theme switcher

local ok, theme = pcall(require, "config.theme")
if not ok then
  vim.notify("No Omarchy theme selected.", vim.log.levels.WARN)
  require('plugins.catppuccin')
  return
end

local specs = vim.islist(theme) and theme or { theme }
local colorscheme
local scheme_set_by_config = false

local known_schemes = {
  tokyonight = "folke/tokyonight.nvim",
  catppuccin = "catppuccin/nvim",
  gruvbox    = "ellisonleao/gruvbox.nvim",
  bamboo     = "ribru17/bamboo.nvim",
}

for _, spec in ipairs(specs) do
  local repo = spec[1]

  if repo == "LazyVim/LazyVim" then
    if spec.opts and spec.opts.colorscheme then
      colorscheme = spec.opts.colorscheme
    end
  else
    local src = "https://github.com/" .. repo
    vim.pack.add({ { src = src } })

    if type(spec.config) == "function" then
      spec.config()
      scheme_set_by_config = true -- don’t override later
    end
  end
end

if not scheme_set_by_config and colorscheme then
  -- normalize colorscheme name for lookup
  local base = colorscheme:match("^[^%-]+")
  local repo = known_schemes[base]
  if repo then
    local src = "https://github.com/" .. repo
    vim.pack.add({ { src = src } })
  end
  vim.cmd.colorscheme(colorscheme)
end
