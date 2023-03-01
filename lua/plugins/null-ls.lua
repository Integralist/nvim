return function(use)
  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local helpers = require("null-ls.helpers") -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/HELPERS.md

      local tfproviderlintx = {
        name = "tfproviderlintx",
        method = null_ls.methods.DIAGNOSTICS,
        filetypes = { "go" },
        generator = helpers.generator_factory({
          args = { "-XAT001=false", "-R018=false", "$FILENAME" },
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
              groups = { "path", "row", "col", "code", "message" }
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
        sources = {
          -- tfproviderlintx,
          require("null-ls").builtins.code_actions.shellcheck, -- https://www.shellcheck.net/
          require("null-ls").builtins.diagnostics.checkmake, -- https://github.com/mrtazz/checkmake
          require("null-ls").builtins.diagnostics.codespell, -- https://github.com/codespell-project/codespell
          require("null-ls").builtins.diagnostics.golangci_lint, -- https://github.com/golangci/golangci-lint (~/.golangci.yml)
          -- require("null-ls").builtins.diagnostics.semgrep.with({
          --   args = { "--config", "auto", "-q", "--json", "$FILENAME" },
          --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          --   timeout = 30000 -- 30 seconds
          -- }), -- https://semgrep.dev/
          require("null-ls").builtins.diagnostics.write_good, -- https://github.com/btford/write-good
          require("null-ls").builtins.diagnostics.zsh, -- https://www.zsh.org/ (uses zsh command's -n option to evaluate code, not execute it)
          require("null-ls").builtins.formatting.autopep8, -- https://github.com/hhatto/autopep8
          require("null-ls").builtins.formatting.codespell, -- https://github.com/codespell-project/codespell
          require("null-ls").builtins.formatting.fixjson, -- https://github.com/rhysd/fixjson
          require("null-ls").builtins.formatting.goimports_reviser, -- https://pkg.go.dev/github.com/incu6us/goimports-reviser
          require("null-ls").builtins.formatting.isort, -- https://github.com/PyCQA/isort
          require("null-ls").builtins.formatting.lua_format, -- https://github.com/Koihik/LuaFormatter
          require("null-ls").builtins.formatting.markdown_toc, -- https://github.com/jonschlinkert/markdown-toc
          require("null-ls").builtins.formatting.mdformat, -- https://github.com/executablebooks/mdformat
          require("null-ls").builtins.formatting.ocdc, -- https://github.com/mdwint/ocdc
          require("null-ls").builtins.formatting.shfmt, -- https://github.com/mvdan/sh
          require("null-ls").builtins.formatting.taplo, -- https://taplo.tamasfe.dev/
          require("null-ls").builtins.formatting.terraform_fmt, -- https://www.terraform.io/docs/cli/commands/fmt.html
          require("null-ls").builtins.formatting.yamlfmt -- https://github.com/google/yamlfmt
        }
      })
    end
  }
end
