return {
  "ojroques/nvim-osc52",
  setup = function()
    require("osc52").setup({
      max_length = 0, -- Maximum length of selection (0 for no limit)
      silent = false, -- Disable message on successful copy
      trim = false, -- Trim surrounding whitespaces before copy
      tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
    })
    function copy()
      if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
        require("osc52").copy_register("+")
      end
    end

    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })

    vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
    vim.keymap.set("n", "<leader>yy", "<leader>c_", { remap = true })
    vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
  end,
}
