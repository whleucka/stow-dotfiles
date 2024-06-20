return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",   -- required
		"sindrets/diffview.nvim",  -- optional
		"https://gitlab.com/ibhagwan/fzf-lua",        -- optional
	},
	opts = {},
	cmd = "Neogit",
	keys = {
		{ "<leader>g", "<cmd>Neogit kind=split<cr>", desc = "Neogit" }
	}
}
