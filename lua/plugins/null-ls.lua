return {
    {
        -- NULL-LS
        "nvimtools/none-ls.nvim", -- "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            vim.keymap.set("n", "<leader><leader>lx",
                           function() null_ls.disable({}) end,
                           {desc = "Disable none-ls"})

            null_ls.setup({
                debug = true,
                -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
                sources = {
                    -- https://www.shellcheck.net/
                    null_ls.builtins.code_actions.shellcheck,
                    -- https://github.com/mrtazz/checkmake
                    null_ls.builtins.diagnostics.checkmake,
                    -- https://github.com/codespell-project/codespell
                    --
                    -- DISABLED:
                    -- You can't configure it to only check code comments.
                    --
                    -- require("null-ls").builtins.diagnostics.codespell.with({
                    --     extra_args = {"-L", "noice,crate"}
                    -- }),
                    --
                    -- https://github.com/golangci/golangci-lint (~/.golangci.yml)
                    null_ls.builtins.diagnostics.golangci_lint,
                    -- https://semgrep.dev/
                    --
                    -- DISABLED:
                    -- Too slow to run!
                    --
                    -- require("null-ls").builtins.diagnostics.semgrep.with({
                    --   args = { "--config", "auto", "-q", "--json", "$FILENAME" },
                    --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
                    --   timeout = 30000 -- 30 seconds
                    -- }),
                    --
                    -- https://github.com/dominikh/go-tools
                    null_ls.builtins.diagnostics.staticcheck,
                    -- https://github.com/btford/write-good
                    require("null-ls").builtins.diagnostics.write_good.with({
                        extra_args = {"--no-passive"}
                    }),
                    -- https://www.zsh.org/ (uses zsh command's -n option to evaluate code, not execute it)
                    null_ls.builtins.diagnostics.zsh,
                    -- https://github.com/psf/black
                    null_ls.builtins.formatting.black,
                    -- https://github.com/hhatto/autopep8
                    null_ls.builtins.formatting.autopep8,
                    -- https://github.com/codespell-project/codespell
                    --
                    -- DISABLED:
                    -- Because it auto-formats code and ends up breaking code.
                    --
                    -- null_ls.builtins.formatting.codespell,
                    --
                    -- https://github.com/rhysd/fixjson
                    null_ls.builtins.formatting.fixjson,
                    -- https://pkg.go.dev/github.com/incu6us/goimports-reviser
                    null_ls.builtins.formatting.goimports_reviser,
                    -- https://github.com/PyCQA/isort
                    null_ls.builtins.formatting.isort,
                    -- https://github.com/Koihik/LuaFormatter
                    null_ls.builtins.formatting.lua_format,
                    -- https://github.com/jonschlinkert/markdown-toc
                    null_ls.builtins.formatting.markdown_toc,
                    -- https://github.com/executablebooks/mdformat
                    null_ls.builtins.formatting.mdformat,
                    -- https://github.com/mdwint/ocdc
                    null_ls.builtins.formatting.ocdc,
                    -- https://github.com/mvdan/sh
                    null_ls.builtins.formatting.shfmt,
                    -- https://taplo.tamasfe.dev/
                    null_ls.builtins.formatting.taplo,
                    -- https://www.terraform.io/docs/cli/commands/fmt.html
                    null_ls.builtins.formatting.terraform_fmt,
                    -- https://github.com/google/yamlfmt
                    null_ls.builtins.formatting.yamlfmt
                }
            })
        end
    }
}
