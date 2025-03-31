-- NOTE: lazy.nvim doesn't like loading modules from within the plugins/ directory.
-- This means I've had to nest this custom module inside of plugins/lsp/
local M = {}

function M.setup(mappings)
	local lspconfig = require('lspconfig')
	local capabilities = require('blink.cmp').get_lsp_capabilities()
	local server = lspconfig.gopls
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
			-- https://neovim.io/doc/user/options.html#'formatprg'
			-- https://neovim.io/doc/user/change.html#gq
			vim.opt.formatprg = ""
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
		},
		init_options = {
			usePlaceholders = true,
		}
	})
end

return M
