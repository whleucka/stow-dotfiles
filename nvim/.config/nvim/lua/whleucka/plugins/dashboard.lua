return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('dashboard').setup {
			theme = 'hyper',
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = '⭐ New', group = '@property', action = 'enew', key = 'n' },
					{ desc = '⚡ Sync', group = '@property', action = 'Lazy sync', key = 's' },
					{
						icon = '🔎 ',
						icon_hl = '@variable',
						desc = 'Find files',
						group = 'Label',
						action = 'Telescope find_files',
						key = 'ff',
					},
					{
						icon = '💎 ',
						icon_hl = '@variable',
						desc = 'Recent files',
						group = 'Label',
						action = 'Telescope oldfiles',
						key = 'fo',
					},
				},
			},
		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
	keys = {
		{"<leader>d", "<cmd>Dashboard<cr>", desc = "Show dashboard"}
	}
}
