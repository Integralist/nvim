return {
    {
        -- NAVIGATION
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
        },
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            vim.fn.sign_define("DiagnosticSignError",
                               {text = " ", texthl = "DiagnosticSignError"})
            vim.fn.sign_define("DiagnosticSignWarn",
                               {text = " ", texthl = "DiagnosticSignWarn"})
            vim.fn.sign_define("DiagnosticSignInfo",
                               {text = " ", texthl = "DiagnosticSignInfo"})
            vim.fn.sign_define("DiagnosticSignHint",
                               {text = "󰌵", texthl = "DiagnosticSignHint"})

            vim.keymap.set("n", "<leader><Tab>", "<Cmd>Neotree toggle<CR>",
                           {desc = "open file tree"})
            vim.keymap.set("n", "<leader><leader>r",
                           "<Cmd>Neotree reveal_force_cwd<CR>", {
                desc = "Reveal current file in tree navigation bar"
            })

            -- Remap :Ex, :Sex, :Tex and :Vex to Neotree
            vim.cmd(":command! Ex Neotree toggle current reveal_force_cwd")
            vim.cmd(":command! Sex sp | Neotree toggle current reveal_force_cwd")
            vim.cmd(
                ":command! Tex tabnew | Neotree toggle current reveal_force_cwd")
            vim.cmd(
                ":command! Vex vert sp | Neotree toggle current reveal_force_cwd")

            require("neo-tree").setup({
                default_component_configs = {
                    git_status = {
                        symbols = {
                            -- Change type
                            added = "✚",
                            modified = "±",
                            deleted = "✖",
                            renamed = "󰁕",
                            -- Status type
                            untracked = "",
                            ignored = "",
                            unstaged = "󰄱",
                            staged = "",
                            conflict = ""
                        }
                    }
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        hide_by_name = {"node_modules"}
                    },
                    hijack_netrw_behavior = "open_current"
                },
                follow_current_file = true,
                use_libuv_file_watcher = true,
                window = {
                    mappings = {
                        ["s"] = "split_with_window_picker",
                        ["v"] = "vsplit_with_window_picker"
                    }
                },
                auto_expand_width = true
            })
        end
    }, {
        -- REPLACEMENT FOR NVIM-WEB-DEVICONS
        "DaikyXendo/nvim-material-icon",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local web_devicons_ok, web_devicons = pcall(require,
                                                        "nvim-web-devicons")
            if not web_devicons_ok then return end

            local material_icon_ok, material_icon = pcall(require,
                                                          "nvim-material-icon")
            if not material_icon_ok then return end

            web_devicons.setup({override = material_icon.get_icons()})

            require("nvim-material-icon").setup()
        end
    }
}
