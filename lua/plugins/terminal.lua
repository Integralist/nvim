return {
	{
		-- TERMINAL
		"akinsho/toggleterm.nvim",
		version = "v2.*",
		config = function()
			require("toggleterm").setup({
				float_opts = {
					border = "curved",
					width = 150
				},
			})

			local Terminal = require('toggleterm.terminal').Terminal
			local htop = Terminal:new({
				cmd = "htop",
				hidden = true,
				direction = "float"
			})

			-- NOTE: This is a global function so it can be called from the below mapping.
			function Htop_toggle() htop:toggle() end

			vim.keymap.set("n", "<leader><leader>th",
				"<cmd>lua Htop_toggle()<CR>", {
					noremap = true,
					silent = true,
					desc = "toggle htop"
				})

			vim.keymap.set("n", "<leader><leader>tf",
				"<Cmd>ToggleTerm direction=float<CR>",
				{ desc = "toggle floating terminal" })

			-- vim.keymap.set("n", "<leader><leader>ts",
			-- 	"<Cmd>ToggleTerm direction=horizontal size=30<CR>",
			-- 	{ desc = "open split terminal" })
			--
			-- vim.keymap.set("n", "<leader><leader>tv",
			-- 	"<Cmd>ToggleTerm direction=vertical size=120<CR>",
			-- 	{ desc = "open vertical terminal" })

			-- :Ts some_name
			vim.api.nvim_create_user_command('Ts', function(opts)
				vim.cmd('sp term://zsh')
				vim.cmd('set nonumber')
				vim.cmd('set nospell')
				vim.cmd('file ' .. opts.args)
			end, { nargs = 1 })

			-- :Tv some_name
			vim.api.nvim_create_user_command('Tv', function(opts)
				vim.cmd('vs term://zsh')
				vim.cmd('set nonumber')
				vim.cmd('set nospell')
				vim.cmd('file ' .. opts.args)
			end, { nargs = 1 })
		end
	}
}
