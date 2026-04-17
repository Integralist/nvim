local icons = require("icons");

return {
	{
		-- DOCUMENT/CODE SYNTAX TREE
		-- h: close, l: open, W: close all, E: open all
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "gs", "<cmd>Outline<CR>", desc = "List document symbols in a tree" },
		},
		opts = {
			outline_window = { position = "left", width = 25 },
			symbols = {
				icons = {
					Array = { icon = icons.Array, hl = 'Constant' },
					Boolean = { icon = icons.Boolean, hl = 'Boolean' }, -- ⊨ 
					Class = { icon = icons.Class, hl = 'Type' },
					Component = { icon = icons.Component, hl = 'Function' },
					Constant = { icon = icons.Constant, hl = 'Constant' }, -- 
					Constructor = { icon = icons.Constructor, hl = 'Special' }, -- 
					Enum = { icon = icons.Enum, hl = 'Type' },
					EnumMember = { icon = icons.EnumMember, hl = 'Identifier' },
					Event = { icon = icons.Event, hl = 'Type' },        -- 🗲
					Field = { icon = icons.Field, hl = 'Identifier' },  -- 󰆨 
					File = { icon = icons.File, hl = 'Identifier' },    -- 󰈔
					Fragment = { icon = icons.Fragment, hl = 'Constant' },
					Function = { icon = icons.Function, hl = 'Function' }, -- 
					Interface = { icon = icons.Interface, hl = 'Type' }, -- 󰜰
					Key = { icon = icons.Key, hl = 'Type' },            -- 🔐
					Macro = { icon = icons.Macro, hl = 'Function' },
					Method = { icon = icons.Method, hl = 'Function' },  -- ƒ ➡️
					Module = { icon = icons.Module, hl = 'Include' },   -- 󰆧 (changed because yaml considers an object a module)
					Namespace = { icon = icons.Namespace, hl = 'Include' }, -- 󰅪
					Null = { icon = icons.Null, hl = 'Type' },          -- NULL
					Number = { icon = icons.Number, hl = 'Number' },
					Object = { icon = icons.Object, hl = 'Type' },      -- ⦿
					Operator = { icon = icons.Operator, hl = 'Identifier' }, -- + 
					Package = { icon = icons.Package, hl = 'Include' }, -- 󰏗
					Parameter = { icon = icons.Parameter, hl = 'Identifier' },
					Property = { icon = icons.Property, hl = 'Identifier' },
					StaticMethod = { icon = icons.StaticMethod, hl = 'Function' }, -- 
					String = { icon = icons.String, hl = 'String' },              -- 𝓐
					Struct = { icon = icons.Struct, hl = 'Structure' },           -- 𝓢
					TypeAlias = { icon = icons.TypeAlias, hl = 'Type' },          -- 
					TypeParameter = { icon = icons.TypeParameter, hl = 'Identifier' }, -- 𝙏
					Variable = { icon = icons.Variable, hl = 'Constant' },        -- 
				},
			}
		},
		config = function(_, opts)
			require("outline").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "Outline",
				command = "setlocal nofoldenable"
			})
		end
	},
	{
		-- WINDOW BAR BREADCRUMBS
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		opts = {
			kinds = icons
		}
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"neovim/nvim-lspconfig", "SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			-- prevent barbecue from automatically attaching nvim-navic
			-- this is so shared LSP attach handler can handle attaching only when LSP running
			attach_navic = false,
			kinds = icons,
		}
	},
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"neovim/nvim-lspconfig", "SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim"
		},
		keys = {
			{
				"<leader>lt",
				function() require("nvim-navbuddy").open() end,
				desc = "Navigate symbols via Navbuddy tree",
				mode = "n",
				noremap = true,
				silent = true
			}
		},
		config = function()
			local navbuddy = require("nvim-navbuddy")
			local actions = require("nvim-navbuddy.actions")
			navbuddy.setup({
				icons = icons,
				mappings = {
					["<Down>"] = actions.next_sibling(), -- down
					["<Up>"] = actions.previous_sibling(), -- up
					["<Left>"] = actions.parent(),    -- Move to left panel
					["<Right>"] = actions.children()  -- Move to right panel
				},
				window = {
					border = "rounded",
					size = "90%",
					sections = { left = { size = "30%" }, mid = { size = "40%" } }
				}
			})
		end
	},
	{
		-- MINIMAP
		"gorbit99/codewindow.nvim",
		keys = {
			{
				"<leader><leader>m",
				function() require("codewindow").toggle_minimap() end,
				desc = "Toggle minimap",
				mode = "n",
				noremap = true,
				silent = true
			}
		},
		config = function()
			require("codewindow.config").setup({
				auto_enable = false,
				use_treesitter = false, -- doesn't work anymore with latest treesitter (and codewindow is no longer maintained/updated)
				exclude_filetypes = {
					"Outline", "neo-tree", "qf", "packer", "help", "noice",
					"Trouble"
				}
			})
			require("codewindow").setup()
		end
	}
}
