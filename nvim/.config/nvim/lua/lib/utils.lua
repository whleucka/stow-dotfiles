local M = {
  log = {
    info = function(msg)
      vim.notify("ℹ️  " .. msg, vim.log.levels.INFO)
    end,
    success = function(msg)
      vim.notify("✅  " .. msg, vim.log.levels.INFO)
    end,
    debug = function(msg)
      vim.notify("👾  " .. msg, vim.log.levels.DEBUG)
    end,
    error = function(msg)
      vim.notify("🔥  " .. msg, vim.log.levels.ERROR)
    end,
    warn = function(msg)
      vim.notify("⚠️  " ..  msg, vim.log.levels.WARN)
    end,
    system = function(msg)
      vim.notify("📦  " ..  msg, vim.log.levels.INFO)
    end,
  },
}

return M
