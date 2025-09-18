-- NOTE: lazy.nvim doesn't like loading modules from within the plugins/ directory.
-- This means I've had to nest this custom module inside of plugins/lsp/
local M = {}

function M.setup(mappings)
	local capabilities = require('blink.cmp').get_lsp_capabilities()

	vim.lsp.config.gopls = vim.tbl_extend("force", vim.lsp.config.gopls or {},
		{
			diagnostics = {
				virtual_text = false -- don't use neovim's default virtual_text now we're using "rachartier/tiny-inline-diagnostic.nvim"
			},
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				mappings(client, bufnr)
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

				-- NOTE: Neovim 0.11 revealed the LSP changes formatprg=gofmt
				-- This breaks the traditional `gp` action.
				-- So for golang LSP we'll unset that property
				--
				-- To read the value:
				-- lua print(vim.o.formatprg)
				--
				-- To unset the value:
				-- lua vim.opt.formatprg = ""
				--
				-- https://neovim.io/doc/user/options.html#'formatprg'
				-- https://neovim.io/doc/user/change.html#gq
				vim.opt.formatprg = ""
			end,
			settings = {
				-- https://tip.golang.org/gopls/settings
				-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
				-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
				gopls = {
					-- I only include features that aren't already enabled by default
					analyses = {
						shadow = false,        -- DISABLED: as the `err` variable warning was driving me nuts
					},
					buildFlags = { "-tags=e2e" }, -- any project that uses build tags can break `go list`, which is used when discovering files.
					-- The tag issue is being tracked here -> https://github.com/golang/go/issues/65089
					-- There is mention of the issue here -> https://go.dev/gopls/workspace
					-- "Gopls is currently unable to guess build flags that include arbitrary user-defined build constraints"
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
					-- IMPORTANT: I've re-enabled staticcheck here while golangci-lint isn't working
					--
					-- gopls doesn't invoke the staticcheck binary.
					-- Instead it imports the analyzers directly.
					-- This means it can report on issues the binary can't.
					-- But it's not a good thing (like it initially sounds).
					-- You can't then use line directives to ignore issues.
					--
					-- For more details:
					-- https://github.com/golang/go/issues/36373#issuecomment-570643870
					-- https://github.com/golangci/golangci-lint/issues/741#issuecomment-1488116634
					--
					-- Instead of using staticcheck via gopls.
					-- We have golangci-lint execute it instead.
					--
					-- But recently I've had issues with golangci-lint in neovim
					-- https://github.com/mfussenegger/nvim-lint/issues/744
					--
					staticcheck = true,
					usePlaceholders = true,
				}
			},
			init_options = {
				usePlaceholders = true,
			}
		}
	)
	vim.lsp.enable('gopls')
end

return M
