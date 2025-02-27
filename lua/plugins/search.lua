return {
	{
		-- SEARCH
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			--[[
          NOTE: Scroll the preview window using <C-d> and <C-u>.

          Opening multiple files isn't a built-in feature of Telescope.
          We can't get that behaviour without a lot of extra config.
          The best we can do is send results to the quickfix window.

          There are two different ways of approaching this:

          1. Filtering files using a search pattern.
          2. Manually selecting files.

          For first scenario just type a search pattern (which will filter the
          list), then press `<C-q>` to send filtered list to quickfix window.

          For the second scenario you would need to:

          - Select multiple files using <Tab>
          - Send the selected files to the quickfix window using <C-o>
          - Search the quickfix window (using either :copen or <leader>q)

          The first approach is fine for simple cases. For example, you want to
          open all Markdown files. You just type `.md` and then `<C-q>`. But if
          you wanted to open specific Markdown files like README.md and HELP.md
          then you'd need the second approach which gives finer-grain control.
        ]]
			local actions = require("telescope.actions")
			local ts = require("telescope")

			ts.setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = { height = 0.75 },
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-o>"] = actions.send_selected_to_qflist
						}
					},
					scroll_strategy = "limit",
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--hidden' -- ADDED OVER ABOVE DEFAULTS (https://github.com/nvim-telescope/telescope.nvim/blob/301505da4bb72d11ffeee47ad45e0b677f70abe5/doc/telescope.txt#L540-L557)
					},
				},
				extensions = { heading = { treesitter = true } }
			})

			ts.load_extension("changed_files")
			ts.load_extension("emoji")
			ts.load_extension("fzf")
			ts.load_extension("heading")
			ts.load_extension("jsonfly")
			ts.load_extension("ui-select")
			ts.load_extension("windows")

			vim.g.telescope_changed_files_base_branch = "main"

			-- IMPORTANT: Check ./utils.lua for folke/which-key.nvim mappings

			vim.keymap.set("n", "<leader>b", "<Cmd>Telescope buffers<CR>", { desc = "search buffers" })
			vim.keymap.set("n", "<leader>B", "<Cmd>Telescope builtin<CR>", { desc = "search builtins" })
			vim.keymap.set("n", "<leader>c", "<Cmd>Telescope changed_files<CR>", { desc = "search changed files" })
			vim.keymap.set("n", "<leader>C", "<Cmd>Telescope colorscheme<CR>", { desc = "search colorschemes" })
			vim.keymap.set("n", "<leader>e", "<Cmd>Telescope commands<CR>", { desc = "search Ex commands" })
			vim.keymap.set("n", "<leader>f", "<Cmd>Telescope find_files hidden=true<CR>", { desc = "search files" })
			vim.keymap.set("n", "<leader>F", "<Cmd>Telescope find_files hidden=true cwd=%:h<CR>",
				{ desc = "search files in current directory" })
			vim.keymap.set("n", "<leader>h", "<Cmd>Telescope command_history<CR>", { desc = "search command history" })
			vim.keymap.set("n", "<leader>H", "<Cmd>Telescope help_tags<CR>", { desc = "search help" })
			vim.keymap.set("n", "<leader>j", "<Cmd>Telescope jsonfly<CR>", { desc = "search current JSON structure" })
			vim.keymap.set("n", "<leader>k", "<Cmd>Telescope keymaps<CR>", { desc = "search key mappings" })
			vim.keymap.set("n", "<leader>K", "<Cmd>Telescope grep_string<CR>", { desc = "search for keyword under cursor" })
			vim.keymap.set("n", "<leader>ld", "<Cmd>Telescope diagnostics<CR>", { desc = "search lsp diagnostics" })
			vim.keymap.set("n", "<leader>li", "<Cmd>Telescope lsp_incoming_calls<CR>", { desc = "search lsp incoming calls" })
			vim.keymap.set("n", "<leader>lo", "<Cmd>Telescope lsp_outgoing_calls<CR>", { desc = "search lsp outgoing calls" })
			vim.keymap.set("n", "<leader>lr", "<Cmd>Telescope lsp_references<CR>", { desc = "search lsp code reference" })
			vim.keymap.set("n", "<leader>ls",
				"<Cmd>lua require('telescope.builtin').lsp_document_symbols({show_line = true})<CR>",
				{ desc = "search lsp document tree" })
			vim.keymap.set("n", "<leader>m", "<Cmd>Telescope heading<CR>", { desc = "search markdown headings" })
			vim.keymap.set("n", "<leader>o", "<Cmd>Telescope emoji<CR>", { desc = "search emojis" })
			vim.keymap.set("n", "<leader>q", "<Cmd>Telescope quickfix<CR>", { desc = "search quickfix list" })
			vim.keymap.set("n", "<leader>s", "<Cmd>Telescope treesitter<CR>", { desc = "search treesitter symbols" })
			vim.keymap.set("n", "<leader>ta", "<Cmd>TodoTelescope<CR>", { desc = "search all TODO types across all files" })
			vim.keymap.set("n", "<leader>tf", "<Cmd>TodoTelescope keywords=FIXME,FIX<CR>",
				{ desc = "search FIXMEs across all files" })
			vim.keymap.set("n", "<leader>tn", "<Cmd>TodoTelescope keywords=NOTE,INFO<CR>",
				{ desc = "search NOTEs across all files" })
			vim.keymap.set("n", "<leader>tt", "<Cmd>TodoTelescope keywords=TODO<CR>",
				{ desc = "search TODOs across all files" })
			vim.keymap.set("n", "<leader>tw", "<Cmd>TodoTelescope keywords=WARNING,IMPORTANT<CR>",
				{ desc = "search WARNING/IMPORTANTs across all files" })
			vim.keymap.set("n", "<leader>w", "<Cmd>Telescope windows<CR>", { desc = "search windows" })
			-- vim.keymap.set("n", "<leader>u", "<Cmd>Noice telescope<CR>", { desc = "search messages handled by Noice plugin" })

			-- DISABLED: in favour of MultiGrep
			-- vim.keymap.set("n", "<leader>x", "<Cmd>Telescope live_grep<CR>",
			-- 	{ desc = "search text" })
			--
			-- https://www.youtube.com/watch?v=xdXE1tOT-qg&ab_channel=TJDeVries
			-- EXAMPLE: type search pattern followed by two spaces and then a filetype glob
			-- config  *.json
			vim.keymap.set("n", "<leader>x", require("custom.telescope.live_multigrep").setup,
				{ desc = "search text" })
			vim.keymap.set("n", "<leader>X", "<Cmd>Telescope current_buffer_fuzzy_find<CR>",
				{ desc = "search current buffer text" })

			-- Remove the Vim builtin colorschemes so they don't show in Telescope.
			vim.cmd("silent !rm $VIMRUNTIME/colors/*.vim &> /dev/null")

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "TelescopeResults",
				callback = function()
					vim.cmd([[setlocal nofoldenable]])
					vim.api.nvim_set_hl(0, "TelescopePromptCounter", { link = "TelescopePromptPrefix" })
				end
			})
		end
	},
	{
		-- FZF SORTER FOR TELESCOPE WRITTEN IN C
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make"
	},
	{
		-- USE TELESCOPE FOR UI ELEMENTS
		"nvim-telescope/telescope-ui-select.nvim",
		config = function() require("telescope").setup({}) end -- TODO: Consider switching to `opts = {}`
	},
	{
		-- SEARCH WINDOWS IN TELESCOPE
		"kyoh86/telescope-windows.nvim"
	},
	{
		-- SEARCH MARKDOWN HEADINGS IN TELESCOPE
		"crispgm/telescope-heading.nvim"
	},
	{
		-- SEARCH EMOJIS IN TELESCOPE
		"xiyaowong/telescope-emoji.nvim"
	},
	{
		-- SEARCH CHANGED GIT FILES IN TELESCOPE
		"axkirillov/telescope-changed-files"
	},
	{
		-- SEARCH JSON STRUCTURES
		"Myzel394/jsonfly.nvim"
	},
	{
		-- SEARCH TABS IN TELESCOPE
		"LukasPietzschmann/telescope-tabs",
		config = function() -- TODO: Consider switching to `keys = {...}` https://lazy.folke.io/spec/lazy_loading#%EF%B8%8F-lazy-key-mappings
			vim.keymap.set("n", "<leader>T",
				"<Cmd>lua require('telescope-tabs').list_tabs()<CR>",
				{ desc = "search tabs" })
		end
	},
	{
		-- SEARCH NOTES/TODOS IN TELESCOPE
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			keywords = {
				NOTE = {
					icon = " ",
					color = "hint",
					alt = { "INFO", "TIP" }
				},
				WARN = {
					icon = " ",
					color = "warning",
					alt = { "WARNING", "IMPORTANT", "DISABLED" }
				}
			},
			highlight = {
				pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]], -- supports both `TODO:` and `TODO(name):`
			},
			search = {
				pattern = [[\b(KEYWORDS)(\(\w*\))*:]], -- ripgrep regex, supporting the pattern TODO(name):
			}
		}
	},
	{
		-- SEARCH INDEXER
		"kevinhwang91/nvim-hlslens",
		config = true
	},
	{
		-- IMPROVES ASTERISK BEHAVIOR
		"haya14busa/vim-asterisk",
		config = function() -- TODO: Consider switching to `keys = {...}` https://lazy.folke.io/spec/lazy_loading#%EF%B8%8F-lazy-key-mappings
			vim.keymap.set('n', '*',
				[[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
				{})
			vim.keymap.set('n', '#',
				[[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
				{})
			vim.keymap.set('n', 'g*',
				[[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
				{})
			vim.keymap.set('n', 'g#',
				[[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
				{})

			vim.keymap.set('x', '*',
				[[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
				{})
			vim.keymap.set('x', '#',
				[[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
				{})
			vim.keymap.set('x', 'g*',
				[[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
				{})
			vim.keymap.set('x', 'g#',
				[[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
				{})
		end
	},
	--   {
	--   -- SEARCH AND REPLACE
	--   "nvim-pack/nvim-spectre",
	--   dependencies = { "nvim-lua/plenary.nvim" },
	--   config = function()
	--     require("spectre").setup({
	--       replace_engine = { ["sed"] = { cmd = "gsed" } }
	--     })
	--     vim.keymap.set("n", "<leader>S",
	--       "<Cmd>lua require('spectre').open()<CR>",
	--       { desc = "search and replace" })
	--   end
	-- },
	{
		-- SEARCH AND REPLACE
		'MagicDuck/grug-far.nvim',
		config = function() -- TODO: Consider switching to `opts = {}` and `keys = {...}` https://lazy.folke.io/spec/lazy_loading#%EF%B8%8F-lazy-key-mappings
			require('grug-far').setup({});
			vim.keymap.set("n", "<leader><leader>s", "<Cmd>GrugFar<CR>", { desc = "search and replace" })
		end
	},
	{
		-- SEARCH GO DOCUMENTATION
		"fredrikaverpil/godoc.nvim",
		version = "*",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{
				"nvim-treesitter/nvim-treesitter",
				opts = {
					ensure_installed = { "go" },
				},
			},
		},
		build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
		cmd = { "GoDoc" },
		opts = {
			picker = {
				type = "telescope" -- default is "native"
			},
		},
	}
}
