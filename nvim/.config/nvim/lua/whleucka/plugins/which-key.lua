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
			u = {
				name = "Upload / Download",
				d = { "<cmd>TransferDownload<cr>", "Download from remote server (scp)" },
				u = { "<cmd>TransferUpload<cr>", "Upload to remote server (scp)" },
				f = { "<cmd>DiffRemote<cr>", "Diff file with remote server (scp)" },
				i = { "<cmd>TransferInit<cr>", "Init/Edit Deployment config" },
				r = { "<cmd>TransferRepeat<cr>", "Repeat transfer command" },
			}
		}, { prefix = "<leader>" })
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	}
}
