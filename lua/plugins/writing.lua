return {
	{
		-- MARKDOWN VIEWER/RENDERER
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			preview = {
				enable = false
			}
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
	},
	{
		-- NESTED CODEBLOCK INDENTATION FORMATTER
		"wurli/contextindent.nvim",
		opts = { pattern = "*.md" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	}
}
