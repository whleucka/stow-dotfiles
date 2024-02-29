return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		wk.register({
			f = {
				name = "File"
			},
			b = {
				name = "Buffer"
			},
			d = {
				name = "DAP"
			},
			g = {
				name = "Neogit"
			},
			t = {
				name = "Neotest"
			}
		}, { prefix = "<leader>" })
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	}
}
