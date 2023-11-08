return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup()
	end,
	keys = {
		{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
	}
}
