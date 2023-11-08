return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Neotree toggle" },
		{ "<leader>o", "<cmd>Neotree focus<cr>",  desc = "Neotree focus" }
	},
	config = function()
		require('neo-tree').setup {
			source_selector = {
				winbar = false,
				statusline = false
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
			},
			event_handlers = {
				-- Auto Close on Open File
				{
					event = "file_opened",
					handler = function(file_path)
						-- auto close
						-- vimc.cmd("Neotree close")
						-- OR
						require("neo-tree.command").execute({ action = "close" })
					end
				},
				{
					event = "file_renamed",
					handler = function(args)
						-- fix references to file
						vim.notify(args.source .. " renamed to " .. args.destination, vim.log.levels.INFO)
					end
				},
				{
					event = "file_moved",
					handler = function(args)
						-- fix references to file
						vim.notify(args.source .. " moved to " .. args.destination, vim.log.levels.INFO)
					end
				},
			}
		}
	end,
}
