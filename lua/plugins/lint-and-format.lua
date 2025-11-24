-- NOTE: Use the following to disable warnings/errors.
--
-- golangci-lint
-- // nolint:<TOOL>,<TOOL> // <REASON: has to be another code comment delimiter inbetween>
--
-- staticcheck (on same line as issue)
-- //lint:ignore <CODE> <REASON>
--
-- gosec (on same line as issue or line above issue)
-- // #nosec <CODE> <REASON>
--
-- yamllint (on same line as issue or line above issue, or across whole file)
-- # yamllint disable-line rule:<RULE>
-- # yamllint disable rule:<RULE>
--
-- codespell
-- //codespell:ignore
-- // codespell:ignore deatil
--
-- alex
-- <!--alex disable failures failure conservative-->
-- <!--alex ignore host-hostess-->
--
-- revive (disable rule across entire file, can use `:enable:` to re-enable after a block of code)
-- //revive:disable:<rule-name>
-- https://github.com/mgechev/revive?tab=readme-ov-file#comment-directives
return {
	{
		-- LINTING
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				-- https://www.gnu.org/software/gawk/
				awk = { "gawk" },
				-- https://github.com/codespell-project/codespell
				-- https://golangci-lint.run/
				go = { "codespell", "golangcilint" },
				-- https://htmlhint.com/
				-- https://www.html-tidy.org/
				html = { "tidy" },
				-- https://github.com/mantoni/eslint_d.js
				javascript = { "eslint_d" },
				-- https://github.com/zaach/jsonlint
				json = { "jsonlint" },
				-- https://github.com/mrtazz/checkmake
				make = { "checkmake" },
				-- https://alexjs.com/
				-- https://github.com/DavidAnson/markdownlint
				-- https://docs.getwoke.tech/
				markdown = { "alex", "markdownlint", "woke" },
				-- https://github.com/rust-lang/rust-clippy
				rust = { "clippy" },
				-- https://www.gnu.org/software/bash/
				-- https://www.shellcheck.net/
				sh = { "bash", "shellcheck" },
				-- https://github.com/terraform-linters/tflint
				-- https://github.com/aquasecurity/trivy (originally https://github.com/aquasecurity/tfsec)
				terraform = { "tflint", "trivy" },
				-- https://www.shellcheck.net/
				-- https://www.zsh.org/
				zsh = { "shellcheck", "zsh" }
			}

			-- WARNING: Removed luacheck linter due to problem with folke/neodev
			-- https://github.com/mpeterv/luacheck
			-- lua = { "luacheck" },

			-- Checkmake requires a ini file in the current directory
			-- Otherwise you have to specify a global one
			lint.linters.checkmake.args = {
				"--format='{{.LineNumber}}:{{.Rule}}:{{.Violation}}\n'",
				"--config", os.getenv("HOME") .. "/.config/checkmake.ini",
			}

			-- Spectral requires a ruleset in the current directory
			-- Otherwise you have to specify a global one
			lint.linters.spectral.args = {
				"lint", "-f", "json", "--ruleset", os.getenv("HOME") .. "/.spectral.yaml",
			}

			-- NOTE: We need custom logic for handling YAML linting.
			--
			-- https://github.com/rhysd/actionlint
			-- https://github.com/adrienverge/yamllint (https://yamllint.readthedocs.io/en/stable/rules.html)
			-- https://github.com/stoplightio/spectral (`npm install -g @stoplight/spectral-cli`)
			vim.api.nvim_create_autocmd({
				"BufReadPost", "BufWritePost", "InsertLeave"
			}, {
				group = vim.api.nvim_create_augroup("Linting", { clear = true }),
				callback = function(ev)
					-- print(string.format('event fired: %s', vim.inspect(ev)))
					-- print(vim.bo.filetype)
					if (string.find(ev.file, ".github/workflows/") or string.find(ev.file, ".github/actions/")) and vim.bo.filetype == "yaml" then
						lint.try_lint("actionlint")
					elseif vim.bo.filetype == "yaml" then
						local first_line = vim.fn.getline(1)
						if string.find(first_line, "openapi:") then
							lint.try_lint("spectral")
						else
							lint.try_lint("yamllint")
						end
					else
						lint.try_lint()
					end
				end
			})
		end
	},
	{
		-- FORMATTING
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			conform.setup({
				log_level = vim.log.levels.DEBUG, -- :ConformInfo to show log info
				formatters_by_ft = {
					-- https://www.gnu.org/software/gawk/manual/gawk.html
					awk = { "gawk" },
					-- https://github.com/reteps/dockerfmt
					dockerfile = { "dockerfmt" },
					-- https://github.com/mvdan/gofumpt
					-- https://pkg.go.dev/golang.org/x/tools/cmd/goimports (auto imports)
					-- https://github.com/incu6us/goimports-reviser
					go = { "gofumpt", "goimports", "goimports-reviser" },
					-- https://github.com/threedaymonk/htmlbeautifier
					html = { "htmlbeautifier" },
					-- https://github.com/mantoni/eslint_d.js/
					-- https://github.com/beautifier/js-beautify
					javascript = { "eslint_d", "js_beautify" },
					-- https://github.com/stedolan/jq
					jq = { "jq" },
					-- https://github.com/rhysd/fixjson
					json = { "fixjson" },
					-- https://github.com/hukkin/mdformat
					markdown = { "mdformat" },
					-- https://github.com/rust-lang/rustfmt
					rust = { "rustfmt" },
					-- https://github.com/koalaman/shellcheck
					sh = { "shellcheck" },
					-- https://www.terraform.io/docs/cli/commands/fmt.html
					-- https://opentofu.org/docs/cli/commands/fmt/  NOTE: This is an alternative `tofu_fmt`
					terraform = { "terraform_fmt" },
					-- https://github.com/tamasfe/taplo
					toml = { "taplo" },
					-- http://xmlsoft.org/xmllint.html
					xml = { "xmllint" },
					-- https://github.com/mikefarah/yq
					yq = { "yq" },
					-- https://github.com/ziglang/zig
					zig = { "zigfmt" },
					zon = { "zigfmt" },
					-- https://github.com/koalaman/shellcheck
					zsh = { "shellcheck" }
				},
				format_after_save = function(bufnr)
					-- disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 5000, lsp_format = "fallback" }
				end
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			vim.keymap.set("n", "<leader><leader>fi", "<Cmd>ConformInfo<CR>", { desc = "Show Conform log" })
			vim.keymap.set("n", "<leader><leader>fd", "<Cmd>FormatDisable<CR>", { desc = "Disable autoformat-on-save" })
			vim.keymap.set("n", "<leader><leader>fe", "<Cmd>FormatEnable<CR>", { desc = "Re-enable autoformat-on-save" })
			vim.keymap.set("n", "<leader><leader>fg", function() vim.cmd("silent !gofumpt -w %") end,
				{ desc = "Format file with gofumpt" })

			-- DISABLED: in favour of format_on_save.
			--
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			--   group = vim.api.nvim_create_augroup("Formatting", { clear = true }),
			--   pattern = "*",
			--   callback = function(args)
			--     require("conform").format({ bufnr = args.buf })
			--   end
			-- })
		end,
	},
	-- RE-FORMAT TABLE MARKDOWN
	{
		'Kicamon/markdown-table-mode.nvim',
		config = function()
			require('markdown-table-mode').setup()
		end
	}
}
