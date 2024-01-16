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
						icon = '⚙️  ',
						icon_hl = '@variable',
						desc = 'Config',
						group = 'Label',
						action = 'Telescope find_files search_dirs={"~/.config/nvim/"}',
						key = 'c',
					},
					{
						icon = '🔎 ',
						icon_hl = '@variable',
						desc = 'Find',
						group = 'Label',
						action = 'Telescope find_files',
						key = 'f',
					},
					{
						icon = '💎 ',
						icon_hl = '@variable',
						desc = 'Recent',
						group = 'Label',
						action = 'Telescope oldfiles',
						key = 'o',
					},
				},
			},
		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
