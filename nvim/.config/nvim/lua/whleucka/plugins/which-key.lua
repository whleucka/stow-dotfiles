return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		{ "<leader>b", group = "Buffer" },
		{ "<leader>d", group = "DAP" },
		{ "<leader>f", group = "File" },
		{ "<leader>g", group = "Neogit" },
		{ "<leader>n", group = "Neotest" },
		{ "<leader>p", group = "Lazy (Package Manager)" },
		{ "<leader>x", group = "Trouble" },
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
