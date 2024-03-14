return {
	-- Only works with nvim 0.10
	'Bekaboo/dropbar.nvim',
	event = { "BufReadPre", "BufNewFile" },
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    }
}
