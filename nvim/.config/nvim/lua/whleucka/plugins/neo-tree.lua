return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		{
			's1n7ax/nvim-window-picker',
			version = '2.*',
			config = function()
				require 'window-picker'.setup({
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { 'neo-tree', "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { 'terminal', "quickfix" },
						},
					},
				})
			end,
		},
	},
	keys = {
		{ "\\", "<cmd>Neotree toggle<cr>", desc = "Neotree open" },
		{ "<leader>o", "<cmd>Neotree focus<cr>", desc = "Neotree focus" },
	},
	config = function()
		require('neo-tree').setup {
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			source_selector = {
				winbar = true,
				statusline = false
			},
			window = {
				width = 30,
				mappings = {
					-- upload (sync files)
					-- uu = {
					-- 	function(state)
					-- 		vim.cmd("TransferUpload " .. state.tree:get_node().path)
					-- 	end,
					-- 	desc = "upload file or directory",
					-- 	nowait = true,
					-- },
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
			},
			event_handlers = {
				-- Auto Close on Open File
				-- {
				-- 	event = "file_opened",
				-- 	handler = function(file_path)
				-- 		-- auto close
				-- 		-- vimc.cmd("Neotree close")
				-- 		-- OR
				-- 		require("neo-tree.command").execute({ action = "close" })
				-- 	end
				-- },
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
