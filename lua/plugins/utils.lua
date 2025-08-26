return {
	{
		-- PACKAGE MANAGER
		--
		-- Packages are installed in Neovim's data directory (`:h standard-path`) by
		-- default. Executables are linked to a single `bin/` directory, which
		-- `mason.nvim` will add to Neovim's PATH during setup, allowing seamless access
		-- from Neovim builtins (shell, terminal, etc.) as well as other 3rd party
		-- plugins.
		--
		-- In Neovim, the term "Neovim's PATH" refers to the PATH environment
		-- variable within the context of Neovim. This PATH variable functions
		-- similarly to the shell's $PATH variable. When you launch Neovim, it
		-- inherits the PATH from the shell or terminal that started it. The PATH in
		-- Neovim determines where Neovim looks for executable files when you run
		-- commands. The mason.nvim plugin modifies this PATH to include a directory
		-- where it links the executables of the packages it installs. This means
		-- that any executable files provided by packages installed through
		-- mason.nvim will be accessible within Neovim without requiring you to
		-- manually modify the system PATH.
		--
		-- :echo $PATH
		--
		-- $HOME/.local/share/nvim/mason/bin
		--
		-- In ./plugins/lsp.lua we install a companion plugin called:
		-- williamboman/mason-lspconfig.nvim which helps to configure
		-- neovim/nvim-lspconfig with LSP servers installed by mason.
		"mason-org/mason.nvim",
		dependencies = "nvim-lspconfig",
		config = true
	},
	{
		-- MAPPING IDENTIFIER
		-- :NvimWebDeviconsHiTest
		"folke/which-key.nvim",
		opts = {
			preset = "modern",
			spec = {
				{ "<leader>", group = "actions", icon = "" },
				{ "<leader>t", group = "todo", icon = "" },
				{ "<leader>l", group = "lsp", icon = "" },
				{ "<leader><leader>b", group = "dap/debug" },
				{ "<leader><leader>d", group = "diagnostics" },
				{ "<leader><leader>f", group = "format" },
				{ "<leader><leader>g", group = "git" },
				{ "<leader><leader>l", group = "lsp", icon = "" },
				{ "<leader><leader>o", group = "oil", icon = "" },
				{ "<leader><leader>p", group = "plugins", icon = "" },
				{ "<leader><leader>q", group = "quickfix" },
				{ "<leader><leader>r", group = "reveal file in neo-tree", icon = "" },
				{ "<leader><leader>t", group = "terminal" },
				{ "<leader><leader><leader>", group = "comment out line" },          -- defined in ../settings.lua
				{ "<leader><leader><leader>", group = "comment out lines", mode = "v" }, -- defined in ../settings.lua
			}
		}
	},
	{
		-- NEOVIM DEVELOPMENT SETUP
		"folke/neodev.nvim"
	},
	{
		-- MAKE DOT OPERATOR WORK IN A SENSIBLE WAY
		"tpope/vim-repeat"
	},
	{
		-- SWAPPABLE ARGUMENTS AND LIST ELEMENTS
		"mizlan/iswap.nvim",
		config = true
	},
	{
		-- BLOCK SORTER
		"chiedo/vim-sort-blocks-by"
	},
	{
		-- MODIFY SURROUNDING CHARACTERS
		"kylechui/nvim-surround",
		config = true
	},
	{
		"junegunn/vim-easy-align",
		keys = {
			{
				"<leader><leader>a",
				"<Plug>(EasyAlign)",
				desc = "Align for visual selection",
				mode = "x",
				noremap = true,
				silent = true
			},
			{
				"<leader><leader>a",
				"<Plug>(EasyAlign)",
				desc = "Align for motion/text object",
				mode = "n",
				noremap = true,
				silent = true
			}
		}
	},
	{
		-- DISPLAY HEX COLOURS
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
	},
	{
		-- GENERATE HEX COLOURS
		-- :CccPick
		"uga-rosa/ccc.nvim",
		config = true
	},
	{
		-- ASYNC DISPATCH
		"tpope/vim-dispatch"
	},
	-- {
	--   "yutkat/confirm-quit.nvim",
	--   event = "CmdlineEnter",
	--   config = function()
	--     require("confirm-quit").setup()
	--     vim.cmd("unabbreviate qa")
	--   end,
	-- },
}
