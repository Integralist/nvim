return {
	{
		-- GIT BLAME
		"FabijanZulj/blame.nvim",
		opts = {
			date_format = "%Y.%m.%d",
		},
		keys = {
			{
				"<leader><leader>gb",
				function() vim.cmd("BlameToggle") end,
				desc = "Toggle git blame",
				mode = "n",
				noremap = true,
				silent = true
			},
		}
	},
	{
		-- GIT CHANGE INDICATOR
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map('n', ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return '<Ignore>'
				end, { desc = "next change hunk", expr = true })

				map('n', '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return '<Ignore>'
				end, { desc = "prev change hunk", expr = true })

				-- map('n', '<leader><leader>gb',
				--   function()
				--     gs.blame_line { full = true }
				--   end, { desc = "git blame" })

				-- map('n', '<leader><leader>gb',
				--   function() gs.blame_line {} end,
				--   { desc = "git blame short" })

				map('n', '<leader><leader>gd', gs.diffthis,
					{ desc = "git diff (:q to close)" })
			end
		}
	},
	{
		-- GIT HISTORY
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader><leader>gh",
				"<Cmd>DiffviewFileHistory<CR>",
				desc = "show project commit history",
				mode = "n",
				noremap = true,
				silent = true
			},
			{
				"<leader><leader>go",
				"<Cmd>DiffviewOpen<CR>",
				desc = "show uncommitted file changes",
				mode = "n",
				noremap = true,
				silent = true
			},
			{
				"<leader><leader>gx",
				"<Cmd>DiffviewClose<CR>",
				desc = "close diffview window",
				mode = "n",
				noremap = true,
				silent = true
			},
		},
		config = true
	},
	{
		-- OPEN LINES IN GITHUB
		"ciehanski/nvim-git-line",
		opts = {
			action_key = "<leader><leader>gp",
			action_key_line = "<leader><leader>gl",
		},
		config = true
	},
	-- GITHUB PR REVIEW MANAGEMENT TOOL
	{
		'pwntester/octo.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		opts = {
			default_to_projects_v2 = true,
			-- suppress_missing_scope = {
			--   projects_v2 = true,   -- Suppresses the error: Cannot request projects v2, missing scope 'read:project'
			-- }
		}
	},
	-- FLOATING COMMIT WINDOW
	{
		"lsig/messenger.nvim",
		opts = {
			border = "rounded"
		},
		keys = {
			{
				"<leader><leader>gc",
				"<Cmd>MessengerShow<CR>",
				desc = "show commit in floating window",
				mode = "n",
				noremap = true,
				silent = true
			}
		},
	},
	{
		dir = '~/Code/nvim/pr-comments',
		config = function()
			require("pr-comments").setup()

			-- CALL API AND ADD 'C' INTO THE LEFT COLUMN
			-- :lua require("pr-comments").load("integralist/actions-testing", 21)

			-- SHOW THE COMMENT ON THE CURRENT LINE
			-- :PRCommentPreview on the comment line
		end
	}
}
