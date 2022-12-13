return function(use)
  -- status line
  use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_c = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- relative path
              shorting_target = 40 -- Shortens path to leave 40 space in the window
            },
          },
        }
      })
    end
  }

  -- ui improvements
  use { "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end
  }

  -- NOTE: `:Noice` to open message history + `:Noice telescope` to open message history in Telescope.
  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("noice").setup({
        views = {
          cmdline_popup = {
            size = {
              width = "40%",
              height = "auto",
            },
            win_options = {
              winhighlight = {
                Normal = "Normal",
                FloatBorder = "DiagnosticSignInfo",
                IncSearch = "",
                Search = "",
              },
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 8,
              col = "50%",
            },
            size = {
              width = 100,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 0.5 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticSignInfo" },
            },
          },
        },
        routes = {
          -- skip displaying message that file was written to.
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
        presets = {
          long_message_to_split = true,
          lsp_doc_border = true,
        },
        documentation = {
          opts = {
            win_options = {
              winhighlight = {
                FloatBorder = "DiagnosticSignInfo",
              },
            },
          },
        },
        lsp = {
          progress = {
            enabled = false, -- I already use fidget configured in ./lsp.lua
          }
        }
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })

  -- tab ui improvements
  use { "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs"
        },
        highlights = {
          tab = {
            fg = "#CCCCCC",
          },
          -- tab_selected = {
          --   fg = "#FF0000"
          -- },
        },
      })
    end
  }

  -- quickfix improvements
  --
  -- <Tab> to select items.
  -- zn to keep selected items.
  -- zN to filter selected items.
  -- zf to fuzzy search items.
  --
  -- <Ctrl-f> scroll down
  -- <Ctrl-b> scroll up
  use { "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end
  }
  use { "kevinhwang91/nvim-bqf", ft = "qf" }

  -- window bar breadcrumbs
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup({
        highlight = true,
      })
    end
  }

  -- scrollbar
  use {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  }
end
