return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	cmd = "Telescope",
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = {},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>",   desc = "Find old files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",  desc = "Show buffers" },
	}
}
