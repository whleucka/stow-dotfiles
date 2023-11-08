return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",   -- required
		"nvim-telescope/telescope.nvim", -- optional
		"sindrets/diffview.nvim",  -- optional
		"ibhagwan/fzf-lua",        -- optional
	},
	config = true,
	cmd = "Neogit",
	keys = {
		{ "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Neogit" }
	}
}
