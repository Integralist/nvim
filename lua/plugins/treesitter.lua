return {
	{
		-- TREESITTER
		-- Syntax tree parsing for more intelligent syntax highlighting and code navigation
		-- IMPORTANT: Requires `tree-sitter` CLI: brew install tree-sitter-cli
		-- After switching branches run: :TSUninstall all, restart, :TSUpdate
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
		config = function()
			local ensure_installed = {
				"bash",
				"c",
				"cmake",
				"css",
				"dockerfile",
				"go",
				"gomod",
				"gowork",
				"hcl",
				"html",
				"http",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"python",
				"regex",
				"ruby",
				"rust",
				"terraform",
				"toml",
				"vim",
				"yaml",
				"zig",
			}

			local already_installed = require("nvim-treesitter").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(parser)
					return not vim.tbl_contains(already_installed, parser)
				end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = false,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
				},
				move = {
					set_jumps = true,
				},
			})

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
			end

			map({ "x", "o" }, "af", function() select.select_textobject("@function.outer") end, "select around a function")
			map({ "x", "o" }, "if", function() select.select_textobject("@function.inner") end, "select inner part of a function")
			map({ "x", "o" }, "ac", function() select.select_textobject("@class.outer") end, "select around a class")
			map({ "x", "o" }, "ic", function() select.select_textobject("@class.inner") end, "select inner part of a class")

			map({ "n", "x", "o" }, "]]", function() move.goto_next_start("@function.outer") end, "next function start")
			map({ "n", "x", "o" }, "]\\", function() move.goto_next_start("@class.outer") end, "next class start")
			map({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@function.outer") end, "prev function start")
			map({ "n", "x", "o" }, "[\\", function() move.goto_previous_start("@class.outer") end, "prev class start")
		end,
	},
	{
		-- HIGHLIGHT ARGUMENTS' DEFINITIONS AND USAGES, USING TREESITTER
		"m-demare/hlargs.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true
	},
	{
		-- SHOWS THE CONTEXT OF THE CURRENTLY VISIBLE BUFFER CONTENTS
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = { separator = "-" }
	}
}
