return {
    {
        -- NULL-LS
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local helpers = require("null-ls.helpers") -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/HELPERS.md

            local tfproviderlintx = {
                name = "tfproviderlintx",
                method = null_ls.methods.DIAGNOSTICS,
                filetypes = {"go"},
                generator = helpers.generator_factory({
                    args = {"-XAT001=false", "-R018=false", "$FILENAME"},
                    check_exit_code = function(code)
                        return code < 1
                    end,
                    command = "tfproviderlintx",
                    format = "line",
                    from_stderr = true,
                    on_output = helpers.diagnostics.from_patterns({
                        {
                            -- EXAMPLE:
                            -- /Users/integralist/Code/EXAMPLE/example.go:123:456: an error code: whoops you did X wrong
                            pattern = "([^:]+):(%d+):(%d+):%s([^:]+):%s(.+)", -- Lua patterns https://www.lua.org/pil/20.2.html
                            groups = {"path", "row", "col", "code", "message"}
                        }
                    }),
                    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/6a98411e70fad6928f7311eeade4b1753cb83524/doc/BUILTIN_CONFIG.md#runtime_condition
                    --
                    -- We can improve performance by caching this operation:
                    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/6a98411e70fad6928f7311eeade4b1753cb83524/doc/HELPERS.md#cache
                    --
                    -- Example:
                    -- helpers.cache.by_bufnr(function(params) ... end)
                    runtime_condition = function(params)
                        -- params spec can be found here:
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/1569ad4817492e0daefa4e1bcf55f8280cdc82db/doc/MAIN.md#generators
                        --
                        -- NOTE: below the use of `%` is a character escape
                        local path_pattern = "terraform%-provider%-"
                        return params.bufname:find(path_pattern) ~= nil
                    end,
                    to_stdin = true
                })
            }

            null_ls.setup({
                debug = true,
                -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
                sources = {
                    -- tfproviderlintx,
                    null_ls.builtins.code_actions.shellcheck, -- https://www.shellcheck.net/
                    null_ls.builtins.diagnostics.checkmake, -- https://github.com/mrtazz/checkmake
                    null_ls.builtins.diagnostics.codespell, -- https://github.com/codespell-project/codespell
                    null_ls.builtins.diagnostics.golangci_lint, -- https://github.com/golangci/golangci-lint (~/.golangci.yml)
                    -- require("null-ls").builtins.diagnostics.semgrep.with({
                    --   args = { "--config", "auto", "-q", "--json", "$FILENAME" },
                    --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
                    --   timeout = 30000 -- 30 seconds
                    -- }), -- https://semgrep.dev/
                    null_ls.builtins.diagnostics.staticcheck, -- https://github.com/dominikh/go-tools
                    null_ls.builtins.diagnostics.write_good, -- https://github.com/btford/write-good
                    null_ls.builtins.diagnostics.zsh, -- https://www.zsh.org/ (uses zsh command's -n option to evaluate code, not execute it)
                    null_ls.builtins.formatting.black, -- https://github.com/psf/black
                    null_ls.builtins.formatting.autopep8, -- https://github.com/hhatto/autopep8
                    null_ls.builtins.formatting.codespell, -- https://github.com/codespell-project/codespell
                    null_ls.builtins.formatting.fixjson, -- https://github.com/rhysd/fixjson
                    null_ls.builtins.formatting.goimports_reviser, -- https://pkg.go.dev/github.com/incu6us/goimports-reviser
                    null_ls.builtins.formatting.isort, -- https://github.com/PyCQA/isort
                    null_ls.builtins.formatting.lua_format, -- https://github.com/Koihik/LuaFormatter
                    null_ls.builtins.formatting.markdown_toc, -- https://github.com/jonschlinkert/markdown-toc
                    null_ls.builtins.formatting.mdformat, -- https://github.com/executablebooks/mdformat
                    null_ls.builtins.formatting.ocdc, -- https://github.com/mdwint/ocdc
                    null_ls.builtins.formatting.shfmt, -- https://github.com/mvdan/sh
                    null_ls.builtins.formatting.taplo, -- https://taplo.tamasfe.dev/
                    null_ls.builtins.formatting.terraform_fmt, -- https://www.terraform.io/docs/cli/commands/fmt.html
                    null_ls.builtins.formatting.yamlfmt -- https://github.com/google/yamlfmt
                }
            })
        end
    }
}
