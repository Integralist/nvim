-- The following local variables are for the 'bubble' theme for lualine.

local colors = {
	blue   = '#80a0ff',
	cyan   = '#79dac8',
	black  = '#080808',
	white  = '#c6c6c6',
	red    = '#ff5189',
	violet = '#d183e8',
	grey   = '#303030',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

return {
	{
		-- COLORSCHEME
		"EdenEast/nightfox.nvim",
		lazy = false,  -- make sure we load this during startup as it is our main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd("colorscheme nightfox")

			-- The following was in an autocommand in ./autocommands.lua
			-- But for some reason wouldn't load until I attempted to switch schemes.
			-- It looks like some other colourscheme is loaded first.
			-- That scheme takes precedence over me setting nightfox here.
			-- Possibly the new default theme that comes with neovim 0.10.0
			-- So the solution is to set the highlights here and keep them in autocommand.
			vim.api.nvim_set_hl(0, "illuminatedWord",
				{ fg = "#063970", bg = "#76b5c5" })
			vim.api.nvim_set_hl(0, "LspReferenceText",
				{ fg = "#063970", bg = "#76b5c5" })
			vim.api.nvim_set_hl(0, "LspReferenceWrite",
				{ fg = "#063970", bg = "#76b5c5" })
			vim.api.nvim_set_hl(0, "LspReferenceRead",
				{ fg = "#063970", bg = "#76b5c5" })
			vim.api.nvim_set_hl(0, 'EyelinerPrimary',
				{ fg = "#FF0000", bold = true, underline = true })
			vim.api.nvim_set_hl(0, 'EyelinerSecondary',
				{ fg = "#FFFF00", underline = true })
		end
	},
	{
		-- STATUS LINE
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
				opts = {},
			},
			{
				"linrongbin16/lsp-progress.nvim",
				config = true,
			}
		},
		event = "UIEnter",
		config = function()
			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					component_separators = '',
					section_separators = { left = '', right = '' },
				},
				sections = {
					lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
					lualine_b = { { 'filename', file_status = true, path = 1, shorting_target = 40 }, 'diagnostics', 'branch', 'diff' },
					lualine_c = {
						'%=', --[[ add your center compoentnts here in place of this comment ]]
					},
					lualine_x = {
						{
							function()
								return require("lsp-progress").progress({
									max_size = 80,
									format = function(messages)
										local bufnr = vim.api.nvim_get_current_buf()
										local active_clients = vim.lsp.get_active_clients({ bufnr = bufnr })
										if #messages > 0 then
											return table.concat(messages, " ")
										end
										local client_names = {}
										for _, client in ipairs(active_clients) do
											if client and client.name ~= "" then
												table.insert(
													client_names,
													1,
													client.name
												)
											end
										end
										return table.concat(client_names, "  ")
									end,
								})
							end,
							icon = { "֎", align = "right" },
						},
					},
					lualine_y = { 'filetype', 'encoding', 'fileformat', 'progress' }, -- progress is percentage of file scrolled
					lualine_z = {
						{ 'location', separator = { right = '' }, left_padding = 2 },
					},
					-- DISABLED:
					-- Traditional/classic lualine theme
					--
					-- 	lualine_c = {
					-- 		{
					-- 			"filename",
					-- 			file_status = true, -- displays file status (readonly status, modified status)
					-- 			path = 1,     -- relative path
					-- 			shorting_target = 40 -- Shortens path to leave 40 space in the window
					-- 		}
					-- 	},
					-- 	lualine_x = {
					-- 		{
					-- 			function()
					-- 				return require("lsp-progress").progress({
					-- 					max_size = 80,
					-- 					format = function(messages)
					-- 						local bufnr = vim.api.nvim_get_current_buf()
					-- 						local active_clients = vim.lsp.get_active_clients({ bufnr = bufnr })
					-- 						if #messages > 0 then
					-- 							return table.concat(messages, " ")
					-- 						end
					-- 						local client_names = {}
					-- 						for _, client in ipairs(active_clients) do
					-- 							if client and client.name ~= "" then
					-- 								table.insert(
					-- 									client_names,
					-- 									1,
					-- 									client.name
					-- 								)
					-- 							end
					-- 						end
					-- 						return table.concat(client_names, "  ")
					-- 					end,
					-- 				})
					-- 			end,
					-- 			icon = { "", align = "right" },
					-- 		},
					-- 		"diagnostics",
					-- 	},
					-- 	lualine_y = { "filetype", "encoding", "fileformat" },
					-- 	lualine_z = { "location" },
					-- }
				},
				inactive_sections = {
					lualine_a = { 'filename' },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { 'location' },
				}
			})
			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})
			-- TODO: Consider https://github.com/folke/lazy.nvim/discussions/1652
		end
	},
	{
		-- UI IMPROVEMENTS
		"stevearc/dressing.nvim",
		config = true
	},
	{
		-- DISABLING
		-- -- NOTE: `:Noice` to open message history + `:Noice telescope` to open message history in Telescope.
		-- "folke/noice.nvim",
		-- event = "VimEnter",
		-- keys = {
		--     {
		--         "<leader><leader>nd",
		--         function() vim.cmd("Noice dismiss") end,
		--         desc = "Dismiss visible messages",
		--         mode = "n",
		--         noremap = true,
		--         silent = true
		--     }
		-- },
		-- config = function()
		--     require("noice").setup({
		--         views = {
		--             cmdline_popup = {
		--                 size = {width = "40%", height = "auto"},
		--                 win_options = {
		--                     winhighlight = {
		--                         Normal = "Normal",
		--                         FloatBorder = "DiagnosticSignInfo",
		--                         IncSearch = "",
		--                         Search = ""
		--                     }
		--                 }
		--             },
		--             popupmenu = {
		--                 relative = "editor",
		--                 position = {row = 8, col = "50%"},
		--                 size = {width = 100, height = 10},
		--                 border = {style = "rounded", padding = {0, 0.5}},
		--                 win_options = {
		--                     winhighlight = {
		--                         Normal = "Normal",
		--                         FloatBorder = "DiagnosticSignInfo"
		--                     }
		--                 }
		--             }
		--         },
		--         routes = {
		--             -- skip displaying message that file was written to.
		--             {
		--                 filter = {
		--                     event = "msg_show",
		--                     kind = "",
		--                     find = "written"
		--                 },
		--                 opts = {skip = true}
		--             }, {
		--                 filter = {
		--                     event = "msg_show",
		--                     kind = "",
		--                     find = "more lines"
		--                 },
		--                 opts = {skip = true}
		--             }, {
		--                 filter = {
		--                     event = "msg_show",
		--                     kind = "",
		--                     find = "fewer lines"
		--                 },
		--                 opts = {skip = true}
		--             }, {
		--                 filter = {
		--                     event = "msg_show",
		--                     kind = "",
		--                     find = "lines yanked"
		--                 },
		--                 opts = {skip = true}
		--             },
		--             {
		--                 view = "split",
		--                 filter = {event = "msg_show", min_height = 10}
		--             }
		--         },
		--         presets = {long_message_to_split = true, lsp_doc_border = true},
		--         documentation = {
		--             opts = {
		--                 win_options = {
		--                     winhighlight = {FloatBorder = "DiagnosticSignInfo"}
		--                 }
		--             }
		--         },
		--         lsp = {
		--             progress = {
		--                 enabled = false -- I already use fidget configured in ./lsp.lua
		--             },
		--             override = {
		--                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
		--                 ["vim.lsp.util.stylize_markdown"] = true,
		--                 ["cmp.entry.get_documentation"] = true
		--             }
		--         }
		--     })
		-- end,
		-- dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}
	},
	{
		-- TAB UI IMPROVEMENTS
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = { mode = "tabs" },
			highlights = { tab = { fg = "#CCCCCC" } }
		}
	},
	{
		-- FZF USED BY BETTER-QUICKFIX PLUGIN
		"junegunn/fzf",
		build = function() vim.fn["fzf#install"]() end
	},
	{
		-- QUICKFIX IMPROVEMENTS
		--
		-- <Tab> to select items.
		-- zn to keep selected items.
		-- zN to filter selected items.
		-- zf to fuzzy search items.
		--
		-- <Ctrl-f> scroll down
		-- <Ctrl-b> scroll up
		"kevinhwang91/nvim-bqf",
		ft = "qf"
	},
	{
		-- SCROLLBAR
		"petertriho/nvim-scrollbar",
		config = true
	},
	{
		-- SCRATCH BUFFER MANAGEMENT
		"https://git.sr.ht/~swaits/scratch.nvim",
		lazy = true,
		keys = {
			-- { "<leader><leader>s", "<cmd>Scratch<cr>",      desc = "Scratch Buffer",         mode = "n" },
			{ "<leader><leader>S", "<cmd>ScratchSplit<cr>", desc = "Scratch Buffer (split)", mode = "n" },
		},
		cmd = {
			"Scratch",
			"ScratchSplit",
		},
		opts = {},
	},
	{
		-- HELP PAGES RENDERING
		"OXY2DEV/helpview.nvim",
		lazy = false
	},
	-- {
	-- 	"Tyler-Barham/floating-help.nvim",
	-- 	opts = {
	-- 		position = 'C', -- NW,N,NW,W,C,E,SW,S,SE (C==center)
	-- 		width = 160, -- whole numbers are columns/rows
	-- 		height = 0.7 -- decimals are a percentage of the editor
	-- 	},
	-- 	keys = {
	-- 		{ "<leader><leader>h", "<cmd>FloatingHelpToggle<cr>", desc = "Toggle floating help", mode = "n" },
	-- 	},
	-- },
	{
		-- KEY PRESSES (enable with :KeyToggle)
		-- "tamton-aquib/keys.nvim"
	}
}
