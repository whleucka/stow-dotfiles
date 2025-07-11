vim.keymap.set("n", "<F2>", function()
  local file = vim.fn.stdpath("config") .. "/bin/update-plugins"
  vim.fn.jobstart(file, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "Submodules Updated" })
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR, { title = "Submodule Error" })
      end
    end,
  })
end)

require("whleucka") -- Load my config
