local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = "  " .. "" .. "  " .. tostring(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix ..
                             (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, "NonText"})
    return newVirtText
end

return {
    {
        -- STATUS LINE
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons", opt = true},
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_c = {
                        {
                            "filename",
                            file_status = true, -- displays file status (readonly status, modified status)
                            path = 1, -- relative path
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
                options = {mode = "tabs"},
                highlights = {tab = {fg = "#CCCCCC"}}
            })
        end
    }, {
        -- FZF USED BY BETTER-QUICKFIX PLUGIN
        "junegunn/fzf",
        build = function() vim.fn["fzf#install"]() end
    }, { -- UFO
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "BufReadPost", -- needed for folds to load in time
        keys = {
            {
                "zr",
                function()
                    require("ufo").openFoldsExceptKinds {"comment"}
                end,
                desc = " 󱃄 Open All Folds except comments"
            }, {
                "zm",
                function() require("ufo").closeAllFolds() end,
                desc = " 󱃄 Close All Folds"
            }, {
                "z1",
                function() require("ufo").closeFoldsWith(1) end,
                desc = " 󱃄 Close L1 Folds"
            }, {
                "z2",
                function() require("ufo").closeFoldsWith(2) end,
                desc = " 󱃄 Close L2 Folds"
            }, {
                "z3",
                function() require("ufo").closeFoldsWith(3) end,
                desc = " 󱃄 Close L3 Folds"
            }, {
                "z4",
                function() require("ufo").closeFoldsWith(4) end,
                desc = " 󱃄 Close L4 Folds"
            }
        },
        init = function()
            -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
            -- auto-closing them after leaving insert mode, however ufo does not seem to
            -- have equivalents for zr and zm because there is no saved fold level.
            -- Consequently, the vim-internal fold levels need to be disabled by setting
            -- them to 99
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
        opts = {
            provider_selector = function(_, ft, _)
                -- INFO some filetypes only allow indent, some only LSP, some only
                -- treesitter. However, ufo only accepts two kinds as priority,
                -- therefore making this function necessary :/
                local lspWithOutFolding = {
                    "markdown", "sh", "css", "html", "python"
                }
                if vim.tbl_contains(lspWithOutFolding, ft) then
                    return {"treesitter", "indent"}
                end
                return {"lsp", "indent"}
            end,
            -- open opening the buffer, close these fold kinds
            -- use `:UfoInspect` to get available fold kinds from the LSP
            close_fold_kinds = {"imports", "comment"},
            open_fold_hl_timeout = 800,
            fold_virt_text_handler = foldTextFormatter
        }
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
        -- WINDOW BAR BREADCRUMBS
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "neovim/nvim-lspconfig", "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("barbecue").setup({
                attach_navic = false -- prevent barbecue from automatically attaching nvim-navic
                -- this is so shared LSP attach handler can handle attaching only when LSP running
            })
        end
    }, {
        -- SCROLLBAR
        "petertriho/nvim-scrollbar",
        config = true
    }
}
