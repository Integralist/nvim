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

			vim.api.nvim_create_user_command('Ts', function(opts)
				-- Split arguments
				local args = vim.split(opts.args, ' ', { trimempty = true })
				local buffer_name = table.remove(args, 1) -- First argument as buffer name
				local command = table.concat(args, ' ') -- Remaining arguments as command

				-- Open horizontal split with terminal
				vim.cmd('sp term://zsh')
				vim.cmd('set nonumber')
				vim.cmd('set nospell')

				-- Rename the buffer
				vim.cmd('file ' .. buffer_name)

				-- Send command if provided
				if command ~= '' then
					vim.api.nvim_chan_send(vim.b.terminal_job_id, command .. '\n')
				end
			end, { nargs = '*' })

			vim.api.nvim_create_user_command('Tv', function(opts)
				-- Split arguments
				local args = vim.split(opts.args, ' ', { trimempty = true })
				local buffer_name = table.remove(args, 1) -- First argument as buffer name
				local command = table.concat(args, ' ') -- Remaining arguments as command

				-- Open vertical split with terminal
				vim.cmd('vs term://zsh')
				vim.cmd('set nonumber')
				vim.cmd('set nospell')

				-- Rename the buffer
				vim.cmd('file ' .. buffer_name)

				-- Send command if provided
				if command ~= '' then
					vim.api.nvim_chan_send(vim.b.terminal_job_id, command .. '\n')
				end
			end, { nargs = '*' })
		end
	}
}
