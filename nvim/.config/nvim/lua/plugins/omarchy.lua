-- Omarchy dynamic theme loader + watcher
local ok, theme = pcall(require, "config.theme")
if not ok then
  vim.notify("No Omarchy theme detected.", vim.log.levels.WARN)
  require('plugins.catppuccin')
  return
end

local uv = vim.loop
local SYMLINK = vim.fn.stdpath("config") .. "/lua/config/theme.lua"

-- --- Fallback to Catppuccin --- --
local function fallback_theme()
  vim.notify("Omarchy: fallback to Catppuccin", vim.log.levels.WARN)
  require("plugins.catppuccin")
end

-- --- Safe load of theme.lua --- --
local function load_theme()
  local ok, theme = pcall(require, "config.theme")
  if not ok or not theme then
    fallback_theme()
    return nil
  end
  return theme
end

-- --- Apply theme and re-sync UI plugins --- --
local known_schemes = {
  tokyonight = "folke/tokyonight.nvim",
  catppuccin = "catppuccin/nvim",
}

local function apply_theme()
  package.loaded["config.theme"] = nil
  local theme = load_theme()
  if not theme then return end

  local specs = vim.islist(theme) and theme or { theme }

  local colorscheme
  local applied_via_config = false

  -- load plugins and detect config/colorscheme
  for _, spec in ipairs(specs) do
    local repo = spec[1]
    if type(repo) == "string" and not repo:match("LazyVim/LazyVim") then
      local src = "https://github.com/" .. repo
      vim.pack.add({ { src = src } })

      -- If the theme handles its own setup, run it and mark applied
      if type(spec.config) == "function" then
        pcall(spec.config)
        applied_via_config = true
      elseif spec.opts and spec.opts.colorscheme then
        colorscheme = spec.opts.colorscheme
      end
    elseif repo == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
      colorscheme = spec.opts.colorscheme
    end
  end

  -- add special known repos (like catppuccin/tokyonight)
  if colorscheme then
    local base = colorscheme:match("^[^%-]+")
    local special_repo = known_schemes[base]
    if special_repo then
      vim.pack.add({ { src = "https://github.com/" .. special_repo } })
    end
  end

  -- apply theme if not handled by config
  vim.defer_fn(function()
    if not applied_via_config then
      if colorscheme then
        local ok_cs, err = pcall(vim.cmd.colorscheme, colorscheme)
        if not ok_cs then
          vim.notify("Omarchy: failed to apply " .. colorscheme .. ": " .. err, vim.log.levels.ERROR)
          fallback_theme()
          return
        end
      else
        vim.notify("Omarchy: no colorscheme found, using fallback", vim.log.levels.WARN)
        fallback_theme()
        return
      end
    end

    -- refresh UI plugins after theme change
    local function refresh_ui()
      pcall(require, "plugins.lualine-nvim")
      pcall(require, "plugins.gitsigns")
    end

    refresh_ui()
    vim.api.nvim_create_autocmd("ColorScheme", {
      once = true,
      callback = refresh_ui,
    })
  end, 50)
end

-- --- Watcher logic --- --
_G._omarchy_state = _G._omarchy_state or { target_poll = nil, file_poll = nil, current_real = nil }
local W = _G._omarchy_state

local function restart_file_poll(new_real)
  if W.file_poll then
    pcall(W.file_poll.stop, W.file_poll)
    pcall(W.file_poll.close, W.file_poll)
  end
  W.file_poll = uv.new_fs_poll()
  W.file_poll:start(new_real, 500, function(err, prev, curr)
    if err then
      vim.schedule(function()
        vim.notify("Omarchy file poll error: " .. err, vim.log.levels.ERROR)
      end)
      return
    end
    if not prev or not curr or prev.mtime.sec ~= curr.mtime.sec or prev.size ~= curr.size then
      vim.schedule(apply_theme)
    end
  end)
  W.current_real = new_real
end

local function start_target_poll()
  if W.target_poll then return end
  W.target_poll = uv.new_fs_poll()
  W.target_poll:start(SYMLINK, 700, function()
    local now_real = vim.fn.resolve(SYMLINK)
    if now_real ~= W.current_real then
      vim.schedule(function()
        restart_file_poll(now_real)
        apply_theme()
      end)
    end
  end)
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if W.file_poll then pcall(W.file_poll.stop, W.file_poll) end
    if W.target_poll then pcall(W.target_poll.stop, W.target_poll) end
  end,
})

if vim.fn.filereadable(SYMLINK) == 1 then
  apply_theme()
  start_target_poll()
  restart_file_poll(vim.fn.resolve(SYMLINK))
else
  vim.notify("Omarchy: theme.lua missing", vim.log.levels.WARN)
  fallback_theme()
end
