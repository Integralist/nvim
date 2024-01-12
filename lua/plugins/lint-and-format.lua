-- NOTE: Use the following to disable warnings/errors.
--
-- golangci-lint
-- //nolint:<TOOL>
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
return {
  {
    -- LINTING
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- https://github.com/codespell-project/codespell
        -- https://golangci-lint.run/
        go = { "codespell", "golangcilint" },
        -- https://github.com/mantoni/eslint_d.js
        javascript = { "eslint_d" },
        -- https://github.com/zaach/jsonlint
        json = { "jsonlint" },
        -- DISABLED: https://github.com/mpeterv/luacheck
        -- Was a problem with folke/neodev plugin
        -- lua = { "luacheck" },
        -- https://alexjs.com/
        -- https://github.com/DavidAnson/markdownlint
        -- https://docs.getwoke.tech/
        markdown = { "alex", "markdownlint", "woke" },
        -- https://www.shellcheck.net/
        sh = { "shellcheck" },
        -- https://github.com/aquasecurity/tfsec
        terraform = { "tfsec" },
        -- https://github.com/rhysd/actionlint
        -- https://github.com/adrienverge/yamllint https://yamllint.readthedocs.io/en/stable/rules.html
        yaml = { "actionlint", "yamllint" },
        -- https://www.shellcheck.net/
        -- https://www.zsh.org/
        zsh = { "shellcheck", "zsh" }
      }

      vim.api.nvim_create_autocmd({
        "BufReadPost", "BufWritePost", "InsertLeave"
      }, {
        group = vim.api.nvim_create_augroup("Linting", { clear = true }),
        callback = function() lint.try_lint() end
      })
    end
  }, {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- https://github.com/mvdan/gofumpt
        -- https://pkg.go.dev/golang.org/x/tools/cmd/goimports
        -- https://github.com/incu6us/goimports-reviser
        go = { "gofumpt", "goimports", "goimports-reviser" },
        -- https://github.com/mantoni/eslint_d.js/
        javascript = { "eslint_d" },
        -- https://github.com/stedolan/jq
        jq = { "jq" },
        -- https://github.com/rhysd/fixjson
        json = { "fixjson" },
        -- https://github.com/executablebooks/mdformat
        markdown = { "mdformat" },
        -- https://github.com/rust-lang/rustfmt
        rust = { "rustfmt" },
        -- https://github.com/koalaman/shellcheck
        sh = { "shellcheck" },
        -- https://www.terraform.io/docs/cli/commands/fmt.html
        terraform = { "terraform_fmt" },
        -- https://github.com/tamasfe/taplo
        toml = { "taplo" },
        -- https://github.com/koalaman/shellcheck
        zsh = { "shellcheck" }
      },
      format_on_save = { async = true, timeout_ms = 5000, lsp_fallback = true }
    })

    -- DISABLED: in favour of format_on_save.
    --
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   group = vim.api
    --       .nvim_create_augroup("Formatting", { clear = true }),
    --   pattern = "*",
    --   callback = function(args)
    --     require("conform").format({ bufnr = args.buf })
    --   end
    -- })
  end
}
}
