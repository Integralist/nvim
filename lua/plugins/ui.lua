return {
  {
    -- STATUS LINE
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_c = {
            {
              "filename",
              file_status = true,  -- displays file status (readonly status, modified status)
              path = 1,            -- relative path
              shorting_target = 40 -- Shortens path to leave 40 space in the window
            }
          }
        }
      })
    end
  }, {
  -- UI IMPROVEMENTS
  "stevearc/dressing.nvim",
  config = true
}, {
  -- DISABLING
  -- -- NOTE: `:Noice` to open message history + `:Noice telescope` to open message history in Telescope.
  -- "folke/noice.nvim",
  -- event = "VimEnter",
  -- keys = {
  --     {
  --         "<leader><leader>nd",
  --         function() vim.cmd("Noice dismiss") end,
  --         desc = "Dismiss visible messages",
  --         mode = "n",
  --         noremap = true,
  --         silent = true
  --     }
  -- },
  -- config = function()
  --     require("noice").setup({
  --         views = {
  --             cmdline_popup = {
  --                 size = {width = "40%", height = "auto"},
  --                 win_options = {
  --                     winhighlight = {
  --                         Normal = "Normal",
  --                         FloatBorder = "DiagnosticSignInfo",
  --                         IncSearch = "",
  --                         Search = ""
  --                     }
  --                 }
  --             },
  --             popupmenu = {
  --                 relative = "editor",
  --                 position = {row = 8, col = "50%"},
  --                 size = {width = 100, height = 10},
  --                 border = {style = "rounded", padding = {0, 0.5}},
  --                 win_options = {
  --                     winhighlight = {
  --                         Normal = "Normal",
  --                         FloatBorder = "DiagnosticSignInfo"
  --                     }
  --                 }
  --             }
  --         },
  --         routes = {
  --             -- skip displaying message that file was written to.
  --             {
  --                 filter = {
  --                     event = "msg_show",
  --                     kind = "",
  --                     find = "written"
  --                 },
  --                 opts = {skip = true}
  --             }, {
  --                 filter = {
  --                     event = "msg_show",
  --                     kind = "",
  --                     find = "more lines"
  --                 },
  --                 opts = {skip = true}
  --             }, {
  --                 filter = {
  --                     event = "msg_show",
  --                     kind = "",
  --                     find = "fewer lines"
  --                 },
  --                 opts = {skip = true}
  --             }, {
  --                 filter = {
  --                     event = "msg_show",
  --                     kind = "",
  --                     find = "lines yanked"
  --                 },
  --                 opts = {skip = true}
  --             },
  --             {
  --                 view = "split",
  --                 filter = {event = "msg_show", min_height = 10}
  --             }
  --         },
  --         presets = {long_message_to_split = true, lsp_doc_border = true},
  --         documentation = {
  --             opts = {
  --                 win_options = {
  --                     winhighlight = {FloatBorder = "DiagnosticSignInfo"}
  --                 }
  --             }
  --         },
  --         lsp = {
  --             progress = {
  --                 enabled = false -- I already use fidget configured in ./lsp.lua
  --             },
  --             override = {
  --                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --                 ["vim.lsp.util.stylize_markdown"] = true,
  --                 ["cmp.entry.get_documentation"] = true
  --             }
  --         }
  --     })
  -- end,
  -- dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}
}, {
  -- TAB UI IMPROVEMENTS
  "akinsho/bufferline.nvim",
  version = "v3.*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = { mode = "tabs" },
      highlights = { tab = { fg = "#CCCCCC" } }
    })
  end
}, {
  -- FZF USED BY BETTER-QUICKFIX PLUGIN
  "junegunn/fzf",
  build = function() vim.fn["fzf#install"]() end
}, {
  -- QUICKFIX IMPROVEMENTS
  --
  -- <Tab> to select items.
  -- zn to keep selected items.
  -- zN to filter selected items.
  -- zf to fuzzy search items.
  --
  -- <Ctrl-f> scroll down
  -- <Ctrl-b> scroll up
  "kevinhwang91/nvim-bqf",
  ft = "qf"
}, {
  -- SCROLLBAR
  "petertriho/nvim-scrollbar",
  config = true
}
}
