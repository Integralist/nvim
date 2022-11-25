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
              groups = { "path", "row", "col", "code", "message" },
            },
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
            return params.bufname:find("terraform%-provider%-") ~= nil -- % is a character escape
          end,
          to_stdin = true,
        }),
      }

      local config = vim.fn.expand("$HOME/revive-single-file.toml")
      local revive = {
        name = "revive",
        method = null_ls.methods.DIAGNOSTICS,
        filetypes = { "go" },
        generator = helpers.generator_factory({
          args = {
            "-set_exit_status",
            "-config=" .. config,
            "-exclude=vendor/...",
            "$FILENAME"
          },
          check_exit_code = function(code)
            return code < 1
          end,
          command = "revive",
          format = "line",
          from_stderr = true,
          on_output = helpers.diagnostics.from_patterns({
            {
              -- EXAMPLE:
              -- /Users/integralist/Code/EXAMPLE/example.go:123:456: whoops you did X wrong
              pattern = "([^:]+):(%d+):(%d+):%s(.+)", -- Lua patterns https://www.lua.org/pil/20.2.html
              groups = { "path", "row", "col", "message" },
            },
          }),
          to_stdin = true,
        }),
      }

      null_ls.setup({
        sources = {
          tfproviderlintx,
          revive,
          require("null-ls").builtins.diagnostics.checkmake, -- https://github.com/mrtazz/checkmake
        }
      })
    end
  }
end
