return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	cmd = "Telescope",
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = {
		defaults = {
			prompt_prefix = "🔎 ",
			path_display = { "truncate" },
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = { prompt_position = "top", preview_width = 0.55 },
				vertical = { mirror = false },
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
		}
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>",   desc = "Find old files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",  desc = "Show buffers" },
	}
}
