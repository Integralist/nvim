return function(use)
  use {
    "neovim/nvim-lspconfig",
    "Afourcat/treesitter-terraform-doc.nvim"
  }
  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup(
        {
          ensure_installed = {
            "bashls",
            "eslint",
            "gopls",
            "jsonls",
            "marksman",
            "pylsp",
            "rust_analyzer",
            "sumneko_lua",
            "terraformls",
            "tflint",
            "tsserver",
            "yamlls"
          }
        }
      )

      mason_lspconfig.setup_handlers(
        {
          function(server_name)
            require("lspconfig")[server_name].setup(
              {
                on_attach = function(client, bufnr)
                  require("settings/shared").on_attach(client, bufnr)
                  require("illuminate").on_attach(client)

                  if server_name == "terraformls" then
                    require("treesitter-terraform-doc").setup()
                  end
                end
              }
            )
          end
        }
      )
    end
  }
  use {
    "jayp0521/mason-null-ls.nvim",
    requires = "jose-elias-alvarez/null-ls.nvim",
    after = "mason.nvim",
    config = function()
      require("mason-null-ls").setup(
        {
          ensure_installed = {
            "autoflake",
            "autopep8",
            "checkmate",
            "codespell",
            "commitlint",
            "fixjson",
            "flake8",
            "goimports_reviser",
            "golangci_lint",
            "isort",
            "lua_format",
            "markdown_toc",
            "mdformat",
            "mypy",
            "ocdc",
            "semgrep",
            "shellcheck",
            "shfmt",
            "taplo",
            "terraform_fmt",
            "write_good",
            "yamlfmt"
          }
        }
      )
    end
  }

  use { "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  }

  use { "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup()

      local bufopts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader><leader>lc", "<Cmd>TroubleClose<CR>", bufopts)
      vim.keymap.set("n", "<leader><leader>li", "<Cmd>TroubleToggle document_diagnostics<CR>", bufopts)
      vim.keymap.set("n", "<leader><leader>lw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", bufopts)
      vim.keymap.set("n", "<leader><leader>lr", "<Cmd>TroubleToggle lsp_references<CR>", bufopts)
      vim.keymap.set("n", "<leader><leader>lq", "<Cmd>TroubleToggle quickfix<CR>", bufopts)
      vim.keymap.set("n", "<leader><leader>ll", "<Cmd>TroubleToggle loclist<CR>", bufopts)
    end
  }

  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- See also: https://github.com/Maan2003/lsp_lines.nvim
    config = function()
      require("lsp_lines").setup()

      -- disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  })

  use { "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        -- autofold_depth = 1, -- h: close, l: open, W: close all, E: open all
        auto_close = false,
        highlight_hovered_item = true,
        position = "left",
        width = 15,
        symbols = {
          File = { icon = "", hl = "GruvboxAqua" }, -- TSURI
          Module = { icon = "", hl = "GruvboxBlue" }, -- TSNamespace
          Namespace = { icon = "", hl = "GruvboxBlue" }, -- TSNamespace
          Package = { icon = "", hl = "GruvboxBlue" }, -- TSNamespace
          Class = { icon = "𝓒", hl = "GruvboxGreen" }, -- TSType
          Method = { icon = "ƒ", hl = "GruvboxOrange" }, -- TSMethod
          Property = { icon = "", hl = "GruvboxOrange" }, -- TSMethod
          Field = { icon = "", hl = "GruvboxRed" }, -- TSField
          Constructor = { icon = "", hl = "TSConstructor" },
          Enum = { icon = "ℰ", hl = "GruvboxGreen" }, -- TSType
          Interface = { icon = "ﰮ", hl = "GruvboxGreen" }, -- TSType
          Function = { icon = "", hl = "GruvboxYellow" }, -- TSFunction
          Variable = { icon = "", hl = "GruvboxPurple" }, -- TSConstant
          Constant = { icon = "", hl = "GruvboxPurple" }, -- TSConstant
          String = { icon = "𝓐", hl = "GruvboxGray" }, -- TSString
          Number = { icon = "#", hl = "TSNumber" },
          Boolean = { icon = "⊨", hl = "TSBoolean" },
          Array = { icon = "", hl = "GruvboxPurple" }, -- TSConstant
          Object = { icon = "⦿", hl = "GruvboxGreen" }, -- TSType
          Key = { icon = "🔐", hl = "GruvboxGreen" }, -- TSType
          Null = { icon = "NULL", hl = "GruvboxGreen" }, -- TSType
          EnumMember = { icon = "", hl = "GruvboxRed" }, -- TSField
          Struct = { icon = "𝓢", hl = "GruvboxGreen" }, -- TSType
          Event = { icon = "🗲", hl = "GruvboxGreen" }, -- TSType
          Operator = { icon = "+", hl = "TSOperator" },
          TypeParameter = { icon = "𝙏", hl = "GruvboxRed" } --TTSParameter
        },
      })
    end
  }

  use {
    "gorbit99/codewindow.nvim",
    config = function()
      require("codewindow").setup({
        auto_enable = false,
        use_treesitter = true, -- disable to lose colours
        exclude_filetypes = { "Outline", "neo-tree", "qf", "packer", "help", "noice", "Trouble" }
      })
      vim.api.nvim_set_keymap("n", "<leader><leader>m", "<cmd>lua require('codewindow').toggle_minimap()<CR>",
        { noremap = true, silent = true, desc = "Toggle minimap" })
    end,
  }

  use {
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        pattern = "*",
        command = "lua require('nvim-lightbulb').update_lightbulb()"
      })
    end
  }

  use {
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup()
    end
  }

  use {
    "weilbith/nvim-code-action-menu",
    config = function()
      vim.keymap.set("n", "<leader><leader>la", "<Cmd>CodeActionMenu<CR>", {
        noremap = true,
        desc = "code action menu"
      })
      vim.g.code_action_menu_window_border = "single"
    end
  }

  use {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  }

  use "simrat39/rust-tools.nvim"
  use "lvimuser/lsp-inlayhints.nvim" -- rust-tools already provides this feature, but gopls doesn't

  --[[
    NOTE: I currently manually attach my shared mappings for each LSP server.
    But, we can set a generic one using lspconfig:

    require("lspconfig").util.default_config.on_attach = function()
  --]]

  require("lspconfig").gopls.setup({
    on_attach = function(client, bufnr)
      require("settings/shared").on_attach(client, bufnr)
      require("lsp-inlayhints").setup({
        inlay_hints = {
          type_hints = {
            prefix = "=> "
          },
        },
      })
      require("lsp-inlayhints").on_attach(client, bufnr)
      require("illuminate").on_attach(client)

      vim.keymap.set(
        "n", "<leader><leader>lv",
        "<Cmd>cex system('revive -exclude vendor/... ./...') | cwindow<CR>",
        {
          noremap = true,
          silent = true,
          buffer = bufnr,
          desc = "lint project code (revive)"
        }
      )
    end,
    settings = {
      gopls = {
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        experimentalPostfixCompletions = true,
        gofumpt = true,
        staticcheck = true,
        usePlaceholders = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        }
      },
    },
  })

  require("rust-tools").setup({
    -- rust-tools options
    tools = {
      autoSetHints = true,
      inlay_hints = {
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
      },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
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
        require("settings/shared").on_attach(client, bufnr)
        require("illuminate").on_attach(client)

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader><leader>rr', "<Cmd>RustRunnables<CR>", bufopts)
        vim.keymap.set('n', 'K', "<Cmd>RustHoverActions<CR>", bufopts)
      end,
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate"
        },
        cargo = {
          allFeatures = true
        },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy",
          allFeatures = true,
        },
      },
      inlayHints = { -- NOT SURE THIS IS VALID/WORKS 😬
        lifetimeElisionHints = {
          enable = true,
          useParameterNames = true
        },
      },
    }
  })
end
