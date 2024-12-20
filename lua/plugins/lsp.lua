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
	local diag_next = "<Cmd>lua vim.diagnostic.goto_next()<CR>"
	local diag_next_opts = merge({ desc = "Go to next diagnostic" }, opts)
	local diag_open_float = "<Cmd>lua vim.diagnostic.open_float()<CR>"
	local diag_open_float_opts = merge({ desc = "Float current diag" }, opts)
	local diag_prev = "<Cmd>lua vim.diagnostic.goto_prev()<CR>"
	local diag_prev_opts = merge({ desc = "Go to prev diagnostic" }, opts)
	local diag_show = "<Cmd>lua vim.diagnostic.show()<CR>"
	local diag_show_opts = merge({ desc = "Show project diagnostics" }, opts)

	vim.keymap.set('n', '<c-s>', buf_def_split, opts)
	vim.keymap.set('n', '<c-\\>', buf_def_vsplit, opts)
	vim.keymap.set('n', '<c-]>', buf_def, opts)
	vim.keymap.set('n', '[x', diag_prev, diag_prev_opts)
	vim.keymap.set('n', ']r', diag_open_float, diag_open_float_opts)
	vim.keymap.set('n', ']s', diag_show, diag_show_opts)
	vim.keymap.set('n', ']x', diag_next, diag_next_opts)
	vim.keymap.set('n', 'K', buf_hover, opts)
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
	-- Looks to be handled by ./lint-and-format.lua stevearc/conform.nvim
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
			-- GOLANG LSP
			require("lspconfig").gopls.setup({
				on_attach = function(client, bufnr)
					mappings(client, bufnr)
					require("lsp-inlayhints").setup({
						inlay_hints = {
							parameter_hints = { prefix = "in: " }, -- "<- "
							type_hints = { prefix = "out: " } -- "=> "
						}
					})
					require("lsp-inlayhints").on_attach(client, bufnr)
					require("illuminate").on_attach(client)

					-- workaround for gopls not supporting semanticTokensProvider
					-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
					if not client.server_capabilities.semanticTokensProvider then
						local semantic = client.config.capabilities.textDocument.semanticTokens
						client.server_capabilities.semanticTokensProvider = {
							full = true,
							legend = {
								tokenTypes = semantic.tokenTypes,
								tokenModifiers = semantic.tokenModifiers,
							},
							range = true,
						}
					end

					-- DISABLED: FixGoImports
					--
					-- Instead I use https://github.com/incu6us/goimports-reviser
					-- Via https://github.com/stevearc/conform.nvim
					--
					-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
					--   group = vim.api.nvim_create_augroup("FixGoImports",
					--     { clear = true }),
					--   pattern = "*.go",
					--   callback = function()
					--     -- ensure imports are sorted and grouped correctly
					--     local params = vim.lsp.util.make_range_params()
					--     params.context = { only = { "source.organizeImports" } }
					--     local result =
					--         vim.lsp.buf_request_sync(0,
					--           "textDocument/codeAction",
					--           params)
					--     for _, res in pairs(result or {}) do
					--       for _, r in pairs(res.result or {}) do
					--         if r.edit then
					--           vim.lsp.util.apply_workspace_edit(
					--             r.edit, "UTF-8")
					--         else
					--           vim.lsp.buf.execute_command(r.command)
					--         end
					--       end
					--     end
					--   end
					-- })

					-- DISABLED:
					-- I don't use revive separately anymore. It's only used via golangci-lint.
					--
					-- vim.keymap.set("n", "<leader><leader>lv",
					--                "<Cmd>cex system('revive -exclude vendor/... ./...') | cwindow<CR>",
					--                {
					--     noremap = true,
					--     silent = true,
					--     buffer = bufnr,
					--     desc = "lint project code (revive)"
					-- })
				end,
				settings = {
					-- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
					-- https://www.lazyvim.org/extras/lang/go (borrowed some ideas from here)
					gopls = {
						analyses = {
							fieldalignment = false, -- find structs that would use less memory if their fields were sorted
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true
						},
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						experimentalPostfixCompletions = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true
						},
						gofumpt = true,
						semanticTokens = true,
						-- DISABLED: staticcheck
						--
						-- gopls doesn't invoke the staticcheck binary.
						-- Instead it imports the analyzers directly.
						-- This means it can report on issues the binary can't.
						-- But it's not a good thing (like it initially sounds).
						-- You can't then use line directives to ignore issues.
						--
						-- Instead of using staticcheck via gopls.
						-- We have golangci-lint execute it instead.
						--
						-- For more details:
						-- https://github.com/golang/go/issues/36373#issuecomment-570643870
						-- https://github.com/golangci/golangci-lint/issues/741#issuecomment-1488116634
						--
						-- staticcheck = true,
						usePlaceholders = true,
					}
				}
				-- DISABLED: as it overlaps with `lvimuser/lsp-inlayhints.nvim`
				-- init_options = {
				--   usePlaceholders = true,
				-- }
			})
		end
	},
	{
		-- RUST LSP
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
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
						require("lsp-inlayhints").setup({
							inlay_hints = { type_hints = { prefix = "=> " } }
						})
						require("lsp-inlayhints").on_attach(client, bufnr)
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
		"lvimuser/lsp-inlayhints.nvim",
		dependencies = "neovim/nvim-lspconfig"
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
					"bashls", "gopls", "jsonls",
					"lua_ls", "marksman", "pylsp",
					"rust_analyzer", "taplo", "terraformls", "tflint", "ts_ls", -- https://github.com/williamboman/mason-lspconfig.nvim/issues/458
					"yamlls", "zls"
				}
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					-- Skip gopls and rust_analyzer as we manually configure them.
					-- Otherwise the following `setup()` would override our config.
					if server_name ~= "gopls" and server_name ~= "rust_analyzer" then
						-- Unfortunately had to if/else so I could configure 'settings' for yamlls.
						if server_name == "yamlls" then
							require("lspconfig")[server_name].setup({
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
							require("lspconfig")[server_name].setup({
								on_attach = function(client, bufnr)
									mappings(client, bufnr)
									require("illuminate").on_attach(client)

									if server_name == "terraformls" then
										require("treesitter-terraform-doc").setup()
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
	{
		-- LSP VIRTUAL TEXT
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()

			-- disable virtual_text since it's redundant due to lsp_lines.
			vim.diagnostic.config({ virtual_text = false })

			-- TODO: Consider https://github.com/folke/lazy.nvim/discussions/1652
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
