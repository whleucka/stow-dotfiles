return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	cmd = "Telescope",
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
	},
	config = function()
		require("telescope").setup({
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
		})
		require('telescope').load_extension('fzf')
	end,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>",   desc = "Find old files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",  desc = "Show buffers" },
	}
}
