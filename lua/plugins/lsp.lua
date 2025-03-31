-- LSP PROGRESS STATUS
--
-- Previously used:
--
-- "j-hui/fidget.nvim",
-- config = true
--
-- Now switched to linrongbin16/lsp-progress.nvim
-- See ./ui.lua and the lualine configuration

local function merge(t1, t2)
	for i = 1, #t2 do t1[#t1 + 1] = t2[i] end
	return t1
end

local function mappings(client, bufnr)
	-- DISABLED: Because it was not as useful as folke/trouble
	-- vim.api.nvim_create_autocmd({ "BufWrite" }, {
	--   callback = function(_)
	--     local namespace = vim.lsp.diagnostic.get_namespace(client.id)
	--     vim.diagnostic.setqflist({ namespace = namespace })
	--   end
	-- })

	local opts = { noremap = true, silent = true, buffer = bufnr }

	local buf_code_action = "<Cmd>lua vim.lsp.buf.code_action()<CR>"
	local buf_code_action_opts = merge({ desc = "View code actions" }, opts)
	local buf_def = "<Cmd>lua vim.lsp.buf.definition()<CR>"
	local buf_def_split = "<Cmd>sp | lua vim.lsp.buf.definition()<CR>"
	local buf_def_vsplit = "<Cmd>vsp | lua vim.lsp.buf.definition()<CR>"
	local buf_doc_sym = "<Cmd>lua vim.lsp.buf.document_symbol()<CR>"
	local buf_doc_sym_opts = merge({ desc = "List doc symbols in qf win" }, opts)
	local buf_hover = "<Cmd>lua vim.lsp.buf.hover()<CR>"
	local buf_impl = "<Cmd>lua vim.lsp.buf.implementation()<CR>"
	local buf_impl_opts = merge({ desc = "List all implementations" }, opts)
	local buf_incoming_calls = "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>"
	local buf_incoming_calls_opts = merge({ desc = "List all callers" }, opts)
	local buf_project = "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>"
	local buf_project_opts = merge({ desc = "Search project-wide symbols" }, opts)
	local buf_ref = "<Cmd>lua vim.lsp.buf.references()<CR>"
	local buf_ref_opts = merge({ desc = "List all references" }, opts)
	local buf_rename = "<Cmd>lua vim.lsp.buf.rename()<CR>"
	local buf_rename_opts = merge({ desc = "Rename symbol" }, opts)
	local buf_sig_help = "<Cmd>lua vim.lsp.buf.signature_help()<CR>"
	local buf_sig_help_opts = merge({ desc = "Sig help (cursor over arg)" }, opts)
	local buf_type = "<Cmd>lua vim.lsp.buf.type_definition()<CR>"
	local buf_type_opts = merge({ desc = "Go to 'type' definition" }, opts)
	local diag_next = "<Cmd>lua vim.diagnostic.goto_next({ float = false })<CR>"
	local diag_next_opts = merge({ desc = "Go to next diagnostic" }, opts)
	local diag_open_float = "<Cmd>lua vim.diagnostic.open_float()<CR>"
	local diag_open_float_opts = merge({ desc = "Float current diag" }, opts)
	local diag_prev = "<Cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>"
	local diag_prev_opts = merge({ desc = "Go to prev diagnostic" }, opts)
	local diag_show = "<Cmd>lua vim.diagnostic.show()<CR>"
	local diag_show_opts = merge({ desc = "Show project diagnostics" }, opts)

	-- IMPORTANT: Since adding "rachartier/tiny-inline-diagnostic.nvim"
	-- we need to configure `float = false` above in `diag_next` and `diag_prev`.
	vim.keymap.set('n', '[x', diag_prev, diag_prev_opts)
	vim.keymap.set('n', ']x', diag_next, diag_next_opts)

	vim.keymap.set('n', '<c-s>', buf_def_split, opts)
	vim.keymap.set('n', '<c-\\>', buf_def_vsplit, opts)
	vim.keymap.set('n', '<c-]>', buf_def, opts)
	vim.keymap.set('n', ']r', diag_open_float, diag_open_float_opts)
	vim.keymap.set('n', ']s', diag_show, diag_show_opts)
	vim.keymap.set('n', 'K', function()
		vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 100 }
	end, opts)
	vim.keymap.set('n', 'ga', buf_code_action, buf_code_action_opts)
	vim.keymap.set('n', 'gi', buf_incoming_calls, buf_incoming_calls_opts)
	vim.keymap.set('n', 'gd', buf_doc_sym, buf_doc_sym_opts)
	vim.keymap.set('n', 'gh', buf_sig_help, buf_sig_help_opts)
	vim.keymap.set('n', 'gm', buf_impl, buf_impl_opts)
	vim.keymap.set('n', 'gn', buf_rename, buf_rename_opts)
	vim.keymap.set('n', 'gp', buf_project, buf_project_opts)
	vim.keymap.set('n', 'gr', buf_ref, buf_ref_opts)
	vim.keymap.set('n', 'gy', buf_type, buf_type_opts)

	-- DISABLED: LSP formatting
	--
	-- Looks to be handled by ./lint-and-format.lua (stevearc/conform.nvim)
	--
	-- if client.supports_method("textDocument/formatting") then
	--   vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	--     group = vim.api.nvim_create_augroup("SharedLspFormatting",
	--       { clear = true }),
	--     pattern = "*",
	--     command = "lua vim.lsp.buf.format()"
	--   })
	-- end

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
		require("nvim-navbuddy").attach(client, bufnr)
		vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
	end
end

return {
	{
		-- TERRAFORM DOCS
		"Afourcat/treesitter-terraform-doc.nvim",
		dependencies = { "nvim-treesitter" }
	},
	{
		-- LSP
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp.golang").setup(mappings)

			local lspconfig = require("lspconfig")

			lspconfig.cue.setup({
				on_attach = function(client, bufnr)
					mappings(client, bufnr)
				end
			})
		end
	},
	{
		-- RUST LSP
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			vim.g.rustaceanvim = {
				capabilities = capabilities,
				-- Plugin configuration
				tools = {
					autoSetHints = true,
					inlay_hints = {
						show_parameter_hints = true,
						parameter_hints_prefix = "in: ", -- "<- "
						other_hints_prefix = "out: " -- "=> "
					}
				},
				-- LSP configuration
				--
				-- REFERENCE:
				-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
				-- https://rust-analyzer.github.io/manual.html#configuration
				-- https://rust-analyzer.github.io/manual.html#features
				--
				-- NOTE: The configuration format is `rust-analyzer.<section>.<property>`.
				--       <section> should be an object.
				--       <property> should be a primitive.
				server = {
					on_attach = function(client, bufnr)
						mappings(client, bufnr)
						require("illuminate").on_attach(client)

						local bufopts = {
							noremap = true,
							silent = true,
							buffer = bufnr
						}
						vim.keymap.set('n', '<leader><leader>rr',
							"<Cmd>RustLsp runnables<CR>", bufopts)
						vim.keymap.set('n', 'K',
							"<Cmd>RustLsp hover actions<CR>", bufopts)
					end,
					settings = {
						-- rust-analyzer language server configuration
						['rust-analyzer'] = {
							assist = {
								importEnforceGranularity = true,
								importPrefix = "create"
							},
							cargo = { allFeatures = true },
							checkOnSave = {
								-- default: `cargo check`
								command = "clippy",
								allFeatures = true
							},
							inlayHints = {
								lifetimeElisionHints = {
									enable = true,
									useParameterNames = true
								}
							}
						}
					}
				}
			}
		end
	},
	{
		-- LSP INLAY HINTS
		--
		-- NOTE: See ../autocommands.lua for LspAttach autocommand.
		'felpafel/inlay-hint.nvim',
		event = 'LspAttach',
		config = function()
			require('inlay-hint').setup({
				virt_text_pos = 'inline', -- eol, inline, right_align
			})
		end,
	},
	{
		-- LSP SERVER CONFIGURATION
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "treesitter-terraform-doc.nvim" },
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			-- NOTE: taplo -> TOML
			--
			-- Can't auto-install these as there is no mappings in mason-lspconfig.
			-- ◍ goimports
			-- ◍ goimports-reviser
			-- ◍ golangci-lint
			mason_lspconfig.setup({
				ensure_installed = {
					"bashls", "dockerls", "gopls", "html", "jsonls",
					"lua_ls", "marksman", "pylsp", "ruby_lsp",
					"rust_analyzer", "spectral",
					"taplo", "terraformls", "tflint", "ts_ls", -- https://github.com/williamboman/mason-lspconfig.nvim/issues/458
					"vimls", "yamlls", "zls"
				}
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					local lspconfig = require("lspconfig")
					local server = lspconfig[server_name] or {}
					local capabilities = require('blink.cmp').get_lsp_capabilities()
					-- Skip gopls and rust_analyzer as we manually configure them.
					-- Otherwise the following `setup()` would override our config.
					if server_name ~= "gopls" and server_name ~= "rust_analyzer" then
						-- Unfortunately had to if/else so I could configure 'settings' for yamlls.
						if server_name == "yamlls" then
							server.setup({
								diagnostics = {
									virtual_text = false -- don't use neovim's default virtual_text now we're using "rachartier/tiny-inline-diagnostic.nvim"
								},
								capabilities = vim.tbl_deep_extend(
									"force", {}, capabilities, server.capabilities or {}
								),
								on_attach = function(client, bufnr)
									mappings(client, bufnr)
									require("illuminate").on_attach(client)
								end,
								settings = {
									yaml = {
										keyOrdering = false -- Disable alphabetical ordering of keys
									}
								}
							})
						else
							if server_name ~= "zls" then
								-- don't show parse errors in a separate window
								vim.g.zig_fmt_parse_errors = 0
								-- disable format-on-save from `ziglang/zig.vim`
								-- it'll be handled by stevearc/conform.nvim instead
								vim.g.zig_fmt_autosave = 0
							end

							-- generic setup for all other lsp
							server.setup({
								diagnostics = {
									virtual_text = false -- don't use neovim's default virtual_text now we're using "rachartier/tiny-inline-diagnostic.nvim"
								},
								capabilities = vim.tbl_deep_extend(
									"force", {}, capabilities, server.capabilities or {}
								),
								on_attach = function(client, bufnr)
									mappings(client, bufnr)
									require("illuminate").on_attach(client)
									if server_name == "terraformls" then
										require("treesitter-terraform-doc").setup({})
										vim.keymap.set("n", "<leader><leader>D", "<Cmd>OpenDoc<CR>",
											{ noremap = true, silent = true, desc = "open terraform docs" })
									end
								end
							})
						end
					end
				end
			})
		end
	},
	{
		-- LSP DIAGNOSTICS
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{
				"<leader><leader>dc",
				"<Cmd>Trouble close<CR>",
				desc = "Close latest Trouble window",
				mode = "n",
				noremap = true,
				silent = true
			},
			{
				"<leader><leader>da",
				"<Cmd>Trouble diagnostics focus=true<CR>",
				desc = "Open diagnostics for all buffers in Trouble",
				mode = "n",
				noremap = true,
				silent = true
			},
			{
				"<leader><leader>db",
				"<Cmd>Trouble diagnostics focus=true filter.buf=0<CR>",
				desc = "Open diagnostics for current buffer in Trouble",
				mode = "n",
				noremap = true,
				silent = true
			},
			{
				"<leader><leader>lr",
				"<Cmd>Trouble lsp_references focus=true<CR>",
				desc = "Open any references to this symbol in Trouble",
				mode = "n",
				noremap = true,
				silent = true
			},
			{
				"]t",
				function() require("trouble").next({ skip_groups = false, jump = true }) end,
				desc = "Next item",
				mode = "n",
				noremap = true,
				silent = true
			},
			{
				"[t",
				function() require("trouble").prev({ skip_groups = false, jump = true }) end,
				desc = "Prev item",
				mode = "n",
				noremap = true,
				silent = true
			}
		},
		config = function()
			require("trouble").setup({
				-- modes = {
				--   diagerrs = {
				--     mode = "diagnostics", -- inherit from diagnostics mode
				--     filter = {
				--       any = {
				--         buf = 0,                                    -- current buffer
				--         {
				--           severity = vim.diagnostic.severity.ERROR, -- errors only
				--           -- limit to files in the current project
				--           function(item)
				--             return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
				--           end,
				--         }
				--       }
				--     }
				--   }
				-- }
			})

			-- Trouble todo toggle filter.buf=0
		end
	},
	-- {
	-- 	-- LSP VIRTUAL TEXT
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	--
	-- 		-- disable virtual_text since it's redundant due to lsp_lines.
	-- 		vim.diagnostic.config({ virtual_text = false })
	-- 	end
	-- },
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			vim.diagnostic.config({ virtual_text = false }) -- don't use neovim's default virtual_text
			require('tiny-inline-diagnostic').setup({
				options = {
					show_source = true,
					multiple_diag_under_cursor = true,
					-- break_line = {
					-- 	enabled = true,
					-- 	after = 60,
					-- }
				}
			})
		end
	},
	{
		-- -- CODE ACTION INDICATOR
		"luckasRanarison/clear-action.nvim",
		opts = {}
	},
	{
		-- CODE ACTIONS POPUP
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		config = function()
			require('tiny-code-action').setup()
			vim.keymap.set("n", "<leader><leader>la", function()
				require("tiny-code-action").code_action()
			end, { noremap = true, silent = true, desc = "code action menu" })
		end
	},
	{
		-- ADD MISSING DIAGNOSTICS HIGHLIGHT GROUPS
		"folke/lsp-colors.nvim",
		config = true
	}
}
