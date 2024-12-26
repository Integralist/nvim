return {
	{
		'saghen/blink.cmp',
		dependencies = 'L3MON4D3/LuaSnip',
		version = '*',
		opts = {
			-- https://cmp.saghen.dev/configuration/keymap
			keymap = { preset = 'enter' },
			-- https://cmp.saghen.dev/configuration/appearance.html
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},
			-- https://cmp.saghen.dev/configuration/completion.html
			completion = {
				-- https://cmp.saghen.dev/configuration/completion.html#accept
				accept = { auto_brackets = { enabled = true } },
				-- https://cmp.saghen.dev/configuration/completion.html#documentation
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 250,
					treesitter_highlighting = true,
					window = { border = "rounded" },
				},
				-- https://cmp.saghen.dev/configuration/completion.html#list
				list = {
					selection = function(ctx)
						return ctx.mode == "cmdline" and "auto_insert" or "preselect"
					end,
				},
				-- https://cmp.saghen.dev/configuration/completion.html#menu
				menu = {
					border = "rounded",
				},
				-- https://cmp.saghen.dev/configuration/reference#completion-ghost-text
				ghost_text = { enabled = true },
			},
			-- https://cmp.saghen.dev/configuration/sources.html
			sources = {
				default = { 'lsp', 'path', 'luasnip', 'buffer' },
			},
			-- https://cmp.saghen.dev/configuration/signature.html
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
			-- https://cmp.saghen.dev/configuration/snippets.html#luasnip
			snippets = {
				expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
				active = function(filter)
					if filter and filter.direction then
						return require('luasnip').jumpable(filter.direction)
					end
					return require('luasnip').in_snippet()
				end,
				jump = function(direction) require('luasnip').jump(direction) end,
			},
		},
		opts_extend = { "sources.default" }
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		keys = {
			{
				"<leader><leader>;",
				function() require("luasnip").jump(1) end,
				desc = "Jump forward a snippet placement",
				mode = "i",
				noremap = true,
				silent = true
			},
			{
				"<leader><leader>,",
				function() require("luasnip").jump(-1) end,
				desc = "Jump backward a snippet placement",
				mode = "i",
				noremap = true,
				silent = true
			}
		},
		config = function()
			require("luasnip.loaders.from_lua").load({ paths = "~/.snippets" })
		end
	}
}
