vim.pack.add({
  {
    src = "https://github.com/mfussenegger/nvim-dap"
  },
  {
    src = "https://github.com/nvim-neotest/nvim-nio"
  },
  {
    src = "https://github.com/rcarriga/nvim-dap-ui"
  },
})

require("dapui").setup()

local dap = require("dap")
local dapui = require("dapui")
local widgets = require("dap.ui.widgets")
local wk = require("which-key")

wk.add({
  "<leader>d",
  group = "Debug",
  { "<leader>dd", function() dapui.toggle() end,          desc = "DAP Toggle UI" },
  { "<leader>dh", function()
    widgets.hover()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = 0, nowait = true })
  end,          desc = "DAP Hover" },
  { "<leader>de", function() dapui.eval() end,          desc = "DAP Eval Expression" },
  -- execution flow
  { "<leader>dc", function() dap.continue() end,          desc = "DAP Continue" },
  { "<leader>dn", function() dap.step_over() end,         desc = "DAP Step Over" },
  { "<leader>di", function() dap.step_into() end,         desc = "DAP Step Into" },
  { "<leader>do", function() dap.step_out() end,          desc = "DAP Step Out" },
  -- breakpoints
  { "<leader>db", function() dap.toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
  {
    "<leader>dB",
    function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end,
    desc = "DAP Set Conditional Breakpoint"
  },
  -- repl + UI
  { "<leader>dr", function() dap.repl.open() end, desc = "DAP Open REPL" },
  { "<leader>du", function() dapui.toggle() end,  desc = "DAP Toggle DAP UI" },
  {
    "<leader>dq",
    function()
      dap.terminate()
      dapui.close()
    end,
    desc = "DAP Terminate Debug Session"
  },
})


local codelldb_path = vim.fn.stdpath("data") .. "/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- autocmds
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
