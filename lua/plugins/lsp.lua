return function(use)
  use "Afourcat/treesitter-terraform-doc.nvim"
  use {
    "neovim/nvim-lspconfig",
    config = function()
      -- fix_imports ensures that imports are sorted and grouped correctly.
      local function fix_imports()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0,
          "textDocument/codeAction",
          params)
        for _, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
              vim.lsp.buf.execute_command(r.command)
            end
          end
        end
      end

      require("lspconfig").gopls.setup({
        on_attach = function(client, bufnr)
          require("settings/shared").on_attach(client, bufnr)
          require("lsp-inlayhints").setup({
            inlay_hints = { type_hints = { prefix = "=> " } }
          })
          require("lsp-inlayhints").on_attach(client, bufnr)
          require("illuminate").on_attach(client)

          vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            group = vim.api.nvim_create_augroup("FixGoImports",
              { clear = true }),
            pattern = "*.go",
            callback = function()
              fix_imports()
            end
          })

          vim.keymap.set("n", "<leader><leader>lv",
            "<Cmd>cex system('revive -exclude vendor/... ./...') | cwindow<CR>",
            {
              noremap = true,
              silent = true,
              buffer = bufnr,
              desc = "lint project code (revive)"
            })
        end,
        settings = {
          -- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
          gopls = {
            analyses = {
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true
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
              rangeVariableTypes = true
            }
          }
        }
        -- DISABLED: as it overlaps with `lvimuser/lsp-inlayhints.nvim`
        -- init_options = {
        --   usePlaceholders = true,
        -- }
      })
    end
  }

  use {
    "simrat39/rust-tools.nvim",
    requires = "neovim/nvim-lspconfig",
    after = "nvim-lspconfig",
    config = function()
      require("rust-tools").setup({
        -- rust-tools options
        tools = {
          autoSetHints = true,
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> "
          }
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

            local bufopts = {
              noremap = true,
              silent = true,
              buffer = bufnr
            }
            vim.keymap.set('n', '<leader><leader>rr',
              "<Cmd>RustRunnables<CR>", bufopts)
            vim.keymap.set('n', 'K', "<Cmd>RustHoverActions<CR>",
              bufopts)
          end,
          ["rust-analyzer"] = {
            assist = {
              importEnforceGranularity = true,
              importPrefix = "create"
            },
            cargo = { allFeatures = true },
            checkOnSave = {
              -- default: `cargo check`
              command = "clippy",
              allFeatures = true
            }
          },
          inlayHints = { -- NOT SURE THIS IS VALID/WORKS ????
            lifetimeElisionHints = {
              enable = true,
              useParameterNames = true
            }
          }
        }
      })
    end
  }

  use {
    "lvimuser/lsp-inlayhints.nvim",
    requires = "neovim/nvim-lspconfig",
    after = "nvim-lspconfig"
  } -- rust-tools already provides this feature, but gopls doesn't

  use {
    "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    config = function() require("mason").setup() end
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    after = { "mason.nvim", "treesitter-terraform-doc.nvim" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = {
          "bashls", "eslint", "gopls", "jsonls", "marksman", "pylsp",
          "rust_analyzer", "sumneko_lua", "terraformls", "tflint",
          "tsserver", "yamlls"
        }
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          -- Skip gopls and rust_analyzer as we manually configure them.
          -- Otherwise the following `setup()` would override our config.
          if server_name ~= "gopls" and server_name ~= "rust_analyzer" then
            require("lspconfig")[server_name].setup({
              on_attach = function(client, bufnr)
                require("settings/shared").on_attach(client,
                  bufnr)
                require("illuminate").on_attach(client)

                if server_name == "terraformls" then
                  require("treesitter-terraform-doc").setup()
                end
              end
            })
          end
        end
      })
    end
  }

  use { "j-hui/fidget.nvim", config = function() require("fidget").setup() end }

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup()

      local bufopts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader><leader>lc", "<Cmd>TroubleClose<CR>",
        bufopts)
      vim.keymap.set("n", "<leader><leader>li",
        "<Cmd>TroubleToggle document_diagnostics<CR>",
        bufopts)
      vim.keymap.set("n", "<leader><leader>lw",
        "<Cmd>TroubleToggle workspace_diagnostics<CR>",
        bufopts)
      vim.keymap.set("n", "<leader><leader>lr",
        "<Cmd>TroubleToggle lsp_references<CR>", bufopts)
      vim.keymap.set("n", "<leader><leader>lq",
        "<Cmd>TroubleToggle quickfix<CR>", bufopts)
      vim.keymap.set("n", "<leader><leader>ll",
        "<Cmd>TroubleToggle loclist<CR>", bufopts)
    end
  }

  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- See also: https://github.com/Maan2003/lsp_lines.nvim
    config = function()
      require("lsp_lines").setup()

      -- disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({ virtual_text = false })
    end
  })

  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        -- autofold_depth = 1, -- h: close, l: open, W: close all, E: open all
        auto_close = false,
        highlight_hovered_item = true,
        position = "left",
        width = 15,
        symbols = {
          File = { icon = "???", hl = "GruvboxAqua" }, -- TSURI
          Module = { icon = "???", hl = "GruvboxBlue" }, -- TSNamespace
          Namespace = { icon = "???", hl = "GruvboxBlue" }, -- TSNamespace
          Package = { icon = "???", hl = "GruvboxBlue" }, -- TSNamespace
          Class = { icon = "????", hl = "GruvboxGreen" }, -- TSType
          Method = { icon = "??", hl = "GruvboxOrange" }, -- TSMethod
          Property = { icon = "???", hl = "GruvboxOrange" }, -- TSMethod
          Field = { icon = "???", hl = "GruvboxRed" }, -- TSField
          Constructor = { icon = "???", hl = "TSConstructor" },
          Enum = { icon = "???", hl = "GruvboxGreen" }, -- TSType
          Interface = { icon = "???", hl = "GruvboxGreen" }, -- TSType
          Function = { icon = "???", hl = "GruvboxYellow" }, -- TSFunction
          Variable = { icon = "???", hl = "GruvboxPurple" }, -- TSConstant
          Constant = { icon = "???", hl = "GruvboxPurple" }, -- TSConstant
          String = { icon = "????", hl = "GruvboxGray" }, -- TSString
          Number = { icon = "#", hl = "TSNumber" },
          Boolean = { icon = "???", hl = "TSBoolean" },
          Array = { icon = "???", hl = "GruvboxPurple" }, -- TSConstant
          Object = { icon = "???", hl = "GruvboxGreen" }, -- TSType
          Key = { icon = "????", hl = "GruvboxGreen" }, -- TSType
          Null = { icon = "NULL", hl = "GruvboxGreen" }, -- TSType
          EnumMember = { icon = "???", hl = "GruvboxRed" }, -- TSField
          Struct = { icon = "????", hl = "GruvboxGreen" }, -- TSType
          Event = { icon = "????", hl = "GruvboxGreen" }, -- TSType
          Operator = { icon = "+", hl = "TSOperator" },
          TypeParameter = { icon = "????", hl = "GruvboxRed" } -- TTSParameter
        }
      })
    end
  }

  use {
    "gorbit99/codewindow.nvim",
    config = function()
      require("codewindow").setup({
        auto_enable = false,
        use_treesitter = true, -- disable to lose colours
        exclude_filetypes = {
          "Outline", "neo-tree", "qf", "packer", "help", "noice",
          "Trouble"
        }
      })
      vim.api.nvim_set_keymap("n", "<leader><leader>m",
        "<cmd>lua require('codewindow').toggle_minimap()<CR>",
        {
          noremap = true,
          silent = true,
          desc = "Toggle minimap"
        })
    end
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
    config = function() require("lsp-colors").setup() end
  }

  use {
    "weilbith/nvim-code-action-menu",
    config = function()
      vim.keymap.set("n", "<leader><leader>la", "<Cmd>CodeActionMenu<CR>",
        { noremap = true, desc = "code action menu" })
      vim.g.code_action_menu_window_border = "single"
    end
  }

  use {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("crates").setup() end
  }
end
