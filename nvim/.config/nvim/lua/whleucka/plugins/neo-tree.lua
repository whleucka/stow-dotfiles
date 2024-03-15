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
		{ "\\", "<cmd>Neotree toggle<cr>", desc = "Neotree toggle" },
	},
	config = function()
		-- Diagnostics styles
		local signs = {
			Error = "🤬",
			Warn = "⚠️ ",
			Hint = "💡",
			Info = "ℹ️ "
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		require('neo-tree').setup {
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			source_selector = {
				winbar = true,
				statusline = false
			},
			window = {
				width = 30,
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
