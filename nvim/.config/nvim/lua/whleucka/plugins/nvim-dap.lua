return {
	'mfussenegger/nvim-dap',
	cmd = 'LspStart',
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'theHamsta/nvim-dap-virtual-text',
	},
	config = function()
		local dap = require('dap')
		require('telescope').load_extension('dap')
		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()

		dap.adapters.php = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/php-debug-adapter",
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003
			}
		}
	end
}
