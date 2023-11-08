return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	event = "VeryLazy",
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Git files" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>",   desc = "Find old files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Find old files" },
	}
}
