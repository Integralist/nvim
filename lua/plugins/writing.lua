return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			initial_state = false
		},
		keys = {
			{
				"<leader><leader>v",
				"<Cmd>Markview toggle<CR>",
				desc = "toggle markdown preview",
				mode = "n",
				noremap = true,
				silent = true
			}
		}
	},
	{
		-- WRITING
		"marcelofern/vale.nvim",
		opts = {
			bin = "/usr/local/bin/vale",
			vale_config_path = "$HOME/.vale.ini"
		}
	}
}
