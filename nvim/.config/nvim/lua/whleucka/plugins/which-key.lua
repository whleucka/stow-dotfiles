return {
	"folke/which-key.nvim",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	event = "VeryLazy",
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
			},
			w = {
				name = "Window"
			},
			x = {
				name = "Trouble"
			},
			p = {
				name = "Lazy (Package Manager)"
			}
		}, { prefix = "<leader>" })
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	}
}
