local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- SHARED LSP HANDLER

local function shared_on_attach(client, bufnr)
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', '<c-]>', "<Cmd>lua vim.lsp.buf.definition()<CR>",
                   bufopts)
    vim.keymap.set('n', 'K', "<Cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
    vim.keymap.set('n', 'gh', "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
                   bufopts)
    vim.keymap.set('n', 'ga', "<Cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
    vim.keymap.set('n', 'gm', "<Cmd>lua vim.lsp.buf.implementation()<CR>",
                   bufopts)
    vim.keymap.set('n', 'gl', "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>",
                   bufopts)
    vim.keymap.set('n', 'gd', "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
                   bufopts)
    vim.keymap.set('n', 'gr', "<Cmd>lua vim.lsp.buf.references()<CR>", bufopts)
    vim.keymap.set('n', 'gn', "<Cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
    -- vim.keymap.set('n', 'gs', "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", bufopts)
    vim.keymap.set('n', 'gs', "<Cmd>SymbolsOutline<CR>", bufopts)
    vim.keymap.set('n', 'gw', "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
                   bufopts)
    vim.keymap
        .set('n', '[x', "<Cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
    vim.keymap
        .set('n', ']x', "<Cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
    vim.keymap.set('n', ']r', "<Cmd>lua vim.diagnostic.open_float()<CR>",
                   bufopts)
    vim.keymap.set('n', ']s', "<Cmd>lua vim.diagnostic.show()<CR>", bufopts)

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd({"BufWritePre"}, {
            group = vim.api.nvim_create_augroup("SharedLspFormatting",
                                                {clear = true}),
            pattern = "*",
            command = "lua vim.lsp.buf.format()"
        })
    end

    if client.server_capabilities.documentSymbolProvider then
        -- WARNING: ../plugins/lsp.lua must be loaded first to avoid error loading navic plugin.
        require("nvim-navic").attach(client, bufnr)

        vim.api.nvim_set_hl(0, "NavicIconsFile",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsModule",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsNamespace",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsPackage",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsClass",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsMethod",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsProperty",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsField",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsConstructor",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsEnum",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsInterface",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsFunction",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsVariable",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsConstant",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsString",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsNumber",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsBoolean",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsArray",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsObject",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsKey",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsNull",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsEnumMember",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsStruct",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsEvent",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsOperator",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicIconsTypeParameter",
                            {default = true, bg = "#000000", fg = "#83a598"})
        vim.api.nvim_set_hl(0, "NavicText",
                            {default = true, bg = "#000000", fg = "#ffffff"})
        vim.api.nvim_set_hl(0, "NavicSeparator",
                            {default = true, bg = "#000000", fg = "#fabd2f"})

        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
end

require("lazy").setup({
    --
    -- COLORSCHEME
    {
        "EdenEast/nightfox.nvim",
        lazy = false, -- make sure we load this during startup as it is our main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function() vim.cmd([[colorscheme nightfox]]) end
    }, --
    --
    -- SYNTAX HIGHLIGHTING
    {"vito-c/jq.vim", lazy = true}, --
    -- AUTOCOMPLETE
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                experimental = {ghost_text = true},
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = {
                    ["<Up>"] = cmp.mapping.select_prev_item(),
                    ["<Down>"] = cmp.mapping.select_next_item(),
                    ["<Left>"] = cmp.mapping.select_prev_item(),
                    ["<Right>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(),
                                                {"i", "c"}),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true
                    })
                },
                sources = cmp.config.sources({
                    -- ordered by priority
                    {name = "nvim_lsp", keyword_length = 1},
                    {name = "nvim_lsp_signature_help"}, {name = "luasnip"},
                    {name = "path"}, {name = "buffer"}, {name = "nvim_lua"}
                })
            })

            cmp.setup.cmdline({"/", "?"}, {
                mapping = cmp.mapping.preset.cmdline(), -- Tab for selection (arrows needed for selecting past items)
                sources = {{name = "buffer"}}
            })

            cmp.setup.cmdline({":"}, {
                mapping = cmp.mapping.preset.cmdline(), -- Tab for selection (arrows needed for selecting past items)
                sources = {{name = "cmdline"}, {name = "path"}}
            })
        end
    }, "hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path", {
        "L3MON4D3/LuaSnip",
        dependencies = {"saadparwaiz1/cmp_luasnip"},
        config = function()
            local keymap = vim.api.nvim_set_keymap
            local opts = {noremap = true, silent = true}
            keymap("i", "<leader><leader>'",
                   "<cmd>lua require('luasnip').jump(1)<CR>", opts)
            keymap("i", "<leader><leader>;",
                   "<cmd>lua require('luasnip').jump(-1)<CR>", opts)
            require("luasnip.loaders.from_lua").load({paths = "~/.snippets"})
        end
    }, {"folke/neodev.nvim", config = function() require("neodev").setup() end},
    --
    -- DEBUGGING
    {
        "mfussenegger/nvim-dap",
        config = function()
            vim.keymap.set("n", "<leader><leader>dc",
                           "<Cmd>lua require('dap').continue()<CR>",
                           {desc = "start debugging"})
            vim.keymap.set("n", "<leader><leader>do",
                           "<Cmd>lua require('dap').step_over()<CR>",
                           {desc = "step over"})
            vim.keymap.set("n", "<leader><leader>di",
                           "<Cmd>lua require('dap').step_into()<CR>",
                           {desc = "step into"})
            vim.keymap.set("n", "<leader><leader>dt",
                           "<Cmd>lua require('dap').step_out()<CR>",
                           {desc = "step out"})
            vim.keymap.set("n", "<leader><leader>db",
                           "<Cmd>lua require('dap').toggle_breakpoint()<CR>",
                           {desc = "toggle breakpoint"})
            vim.keymap.set("n", "<leader><leader>dv",
                           "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                           {desc = "toggle breakpoint"})
            vim.keymap.set("n", "<leader><leader>dr",
                           "<Cmd>lua require('dap').repl.open()<CR>",
                           {desc = "open repl"})
            vim.keymap.set("n", "<leader><leader>du",
                           "<Cmd>lua require('dapui').toggle()<CR>",
                           {desc = "toggle dap ui"})
        end
    }, {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap"},
        config = function() require("dapui").setup() end
    }, {
        "leoluz/nvim-dap-go",
        dependencies = {"mfussenegger/nvim-dap"},
        build = "go install github.com/go-delve/delve/cmd/dlv@latest",
        config = function() require("dap-go").setup() end
    }, {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {"mfussenegger/nvim-dap"},
        config = function() require("nvim-dap-virtual-text").setup() end
    }, --
    -- GIT
    --
    -- git change indicator
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            vim.api.nvim_set_hl(0, "GitSignsChange",
                                {link = "GruvboxYellowSign"})

            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return '<Ignore>'
                    end, {desc = "next change hunk", expr = true})

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return '<Ignore>'
                    end, {desc = "prev change hunk", expr = true})

                    map('n', '<leader><leader>gb',
                        function()
                        gs.blame_line {full = true}
                    end, {desc = "git blame"})

                    map('n', '<leader><leader>gs',
                        function() gs.blame_line {} end,
                        {desc = "git blame short"})

                    map('n', '<leader><leader>gd', gs.diffthis,
                        {desc = "git diff (:q to close)"})
                end
            })
        end
    }, --
    -- git history
    {
        "sindrets/diffview.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            require("diffview").setup()
            vim.keymap.set("n", "<leader><leader>gh",
                           "<Cmd>DiffviewFileHistory<CR>",
                           {desc = "diff history"})
            vim.keymap.set("n", "<leader><leader>go", "<Cmd>DiffviewOpen<CR>",
                           {desc = "diff open"})
            vim.keymap.set("n", "<leader><leader>gc", "<Cmd>DiffviewClose<CR>",
                           {desc = "diff close"})
        end
    }, --
    -- open lines in github
    {
        "ruanyl/vim-gh-line",
        config = function() vim.g.gh_line_map = "<leader><leader>gl" end
    }, --
    -- indentation autopairing
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }, --
    -- whitespace management
    {
        "zakharykaplan/nvim-retrail",
        config = function()
            require("retrail").setup({
                filetype = {
                    exclude = {
                        "markdown", "neo-tree",
                        -- following are defaults that need to be added or they'll be overridden
                        "", "alpha", "checkhealth", "diff", "help", "lspinfo",
                        "man", "mason", "TelescopePrompt", "Trouble", "WhichKey"
                    }
                }
            })
        end
    }, --
    -- word usage highlighter
    "RRethy/vim-illuminate", --
    -- jump to word indictors
    "jinh0/eyeliner.nvim", --
    -- cursor movement highlighter
    "DanilaMihailov/beacon.nvim", --
    -- highlight yanked region
    "machakann/vim-highlightedyank", --
    -- suggest mappings
    {
        "folke/which-key.nvim",
        config = function() require("which-key").setup() end
    }, --
    -- LSP
    "Afourcat/treesitter-terraform-doc.nvim", {
        "neovim/nvim-lspconfig",
        config = function()
            -- fix_imports ensures that imports are sorted and grouped correctly.
            local function fix_imports()
                local params = vim.lsp.util.make_range_params()
                params.context = {only = {"source.organizeImports"}}
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
                    shared_on_attach(client, bufnr)
                    require("lsp-inlayhints").setup({
                        inlay_hints = {type_hints = {prefix = "=> "}}
                    })
                    require("lsp-inlayhints").on_attach(client, bufnr)
                    require("illuminate").on_attach(client)

                    vim.api.nvim_create_autocmd({"BufWritePost"}, {
                        group = vim.api.nvim_create_augroup("FixGoImports",
                                                            {clear = true}),
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
    }, {
        "simrat39/rust-tools.nvim",
        dependencies = "neovim/nvim-lspconfig",
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
                        shared_on_attach(client, bufnr)
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
                        cargo = {allFeatures = true},
                        checkOnSave = {
                            -- default: `cargo check`
                            command = "clippy",
                            allFeatures = true
                        }
                    },
                    inlayHints = { -- NOT SURE THIS IS VALID/WORKS 😬
                        lifetimeElisionHints = {
                            enable = true,
                            useParameterNames = true
                        }
                    }
                }
            })
        end
    }, {"lvimuser/lsp-inlayhints.nvim", dependencies = "neovim/nvim-lspconfig"}, -- rust-tools already provides this feature, but gopls doesn't
    {
        "williamboman/mason.nvim",
        dependencies = "nvim-lspconfig",
        config = function() require("mason").setup() end
    }, {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {"mason.nvim", "treesitter-terraform-doc.nvim"},
        config = function()
            local mason_lspconfig = require("mason-lspconfig")

            -- NOTE: sumneko_lua -> lua_ls
            -- https://github.com/williamboman/mason-lspconfig.nvim/pull/148
            mason_lspconfig.setup({
                ensure_installed = {
                    "bashls", "eslint", "gopls", "jsonls", "marksman", "pylsp",
                    "rust_analyzer", "lua_ls", "terraformls", "tflint",
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
                                shared_on_attach(client, bufnr)
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
    }, {"j-hui/fidget.nvim", config = function() require("fidget").setup() end},
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup()

            local bufopts = {noremap = true, silent = true}
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
    }, {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- See also: https://github.com/Maan2003/lsp_lines.nvim
        config = function()
            require("lsp_lines").setup()

            -- disable virtual_text since it's redundant due to lsp_lines.
            vim.diagnostic.config({virtual_text = false})
        end
    }, {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup({
                -- autofold_depth = 1, -- h: close, l: open, W: close all, E: open all
                auto_close = false,
                highlight_hovered_item = true,
                position = "left",
                width = 15,
                symbols = {
                    File = {icon = "", hl = "GruvboxAqua"}, -- TSURI
                    Module = {icon = "", hl = "GruvboxBlue"}, -- TSNamespace
                    Namespace = {icon = "", hl = "GruvboxBlue"}, -- TSNamespace
                    Package = {icon = "", hl = "GruvboxBlue"}, -- TSNamespace
                    Class = {icon = "𝓒", hl = "GruvboxGreen"}, -- TSType
                    Method = {icon = "ƒ", hl = "GruvboxOrange"}, -- TSMethod
                    Property = {icon = "", hl = "GruvboxOrange"}, -- TSMethod
                    Field = {icon = "", hl = "GruvboxRed"}, -- TSField
                    Constructor = {icon = "", hl = "TSConstructor"},
                    Enum = {icon = "ℰ", hl = "GruvboxGreen"}, -- TSType
                    Interface = {icon = "ﰮ", hl = "GruvboxGreen"}, -- TSType
                    Function = {icon = "", hl = "GruvboxYellow"}, -- TSFunction
                    Variable = {icon = "", hl = "GruvboxPurple"}, -- TSConstant
                    Constant = {icon = "", hl = "GruvboxPurple"}, -- TSConstant
                    String = {icon = "𝓐", hl = "GruvboxGray"}, -- TSString
                    Number = {icon = "#", hl = "TSNumber"},
                    Boolean = {icon = "⊨", hl = "TSBoolean"},
                    Array = {icon = "", hl = "GruvboxPurple"}, -- TSConstant
                    Object = {icon = "⦿", hl = "GruvboxGreen"}, -- TSType
                    Key = {icon = "🔐", hl = "GruvboxGreen"}, -- TSType
                    Null = {icon = "NULL", hl = "GruvboxGreen"}, -- TSType
                    EnumMember = {icon = "", hl = "GruvboxRed"}, -- TSField
                    Struct = {icon = "𝓢", hl = "GruvboxGreen"}, -- TSType
                    Event = {icon = "🗲", hl = "GruvboxGreen"}, -- TSType
                    Operator = {icon = "+", hl = "TSOperator"},
                    TypeParameter = {icon = "𝙏", hl = "GruvboxRed"} -- TTSParameter
                }
            })
        end
    }, {
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
    }, {
        "kosayoda/nvim-lightbulb",
        config = function()
            vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
                pattern = "*",
                command = "lua require('nvim-lightbulb').update_lightbulb()"
            })
        end
    }, {
        "folke/lsp-colors.nvim",
        config = function() require("lsp-colors").setup() end
    }, {
        "weilbith/nvim-code-action-menu",
        config = function()
            vim.keymap.set("n", "<leader><leader>la", "<Cmd>CodeActionMenu<CR>",
                           {noremap = true, desc = "code action menu"})
            vim.g.code_action_menu_window_border = "single"
        end
    }, {
        "saecki/crates.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function() require("crates").setup() end
    }, -- ICONS
    --
    "nvim-tree/nvim-web-devicons", --
    -- replacement for nvim-web-devicons
    {
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
    }, --
    -- MOTION
    --
    -- camel case motion support
    {
        "bkad/CamelCaseMotion",
        config = function()
            vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', {silent = true})
            vim.keymap.set('', 'b', '<Plug>CamelCaseMotion_b', {silent = true})
            vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', {silent = true})
            vim.keymap
                .set('', 'ge', '<Plug>CamelCaseMotion_ge', {silent = true})
        end
    }, --
    -- move lines around
    {
        "fedepujol/move.nvim",
        config = function()
            local opts = {noremap = true, silent = true}
            -- Normal-mode commands
            vim.keymap.set('n', '<C-j>', ':MoveLine(1)<CR>', opts)
            vim.keymap.set('n', '<C-k>', ':MoveLine(-1)<CR>', opts)
            vim.keymap.set('n', '<C-h>', ':MoveHChar(-1)<CR>', opts)
            vim.keymap.set('n', '<C-l>', ':MoveHChar(1)<CR>', opts)

            -- Visual-mode commands
            vim.keymap.set('v', '<S-j>', ':MoveBlock(1)<CR>', opts)
            vim.keymap.set('v', '<S-k>', ':MoveBlock(-1)<CR>', opts)
            vim.keymap.set('v', '<S-h>', ':MoveHBlock(-1)<CR>', opts)
            vim.keymap.set('v', '<S-l>', ':MoveHBlock(1)<CR>', opts)
        end
    }, --
    -- NAVIGATION
    {
        "nvim-neo-tree/neo-tree.nvim",
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
                               {text = "", texthl = "DiagnosticSignHint"})

            vim.keymap.set("n", "<leader><Tab>", "<Cmd>Neotree toggle<CR>",
                           {desc = "open file tree"})
            vim.keymap.set("n", "gp", "<Cmd>Neotree reveal_force_cwd<CR>", {
                desc = "change working directory to current file location"
            })

            if vim.g.colors_name == "gruvbox" then
                vim.api.nvim_set_hl(0, "NeoTreeCursorLine",
                                    {fg = "#000000", bg = "#fabd2f"})
            end

            -- Remap :Ex, :Sex to Neotree
            vim.cmd(":command! Ex Neotree toggle current reveal_force_cwd")
            vim.cmd(":command! Sex sp | Neotree toggle current reveal_force_cwd")

            require("neo-tree").setup({
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
                }
            })
        end
    }, --
    -- NULL-LS
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local helpers = require("null-ls.helpers") -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/HELPERS.md

            local tfproviderlintx = {
                name = "tfproviderlintx",
                method = null_ls.methods.DIAGNOSTICS,
                filetypes = {"go"},
                generator = helpers.generator_factory({
                    args = {"-XAT001=false", "-R018=false", "$FILENAME"},
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
                            groups = {"path", "row", "col", "code", "message"}
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
    }, -- OPERATORS
    --
    -- make dot operator work in a sensible way
    "tpope/vim-repeat", --
    -- SEARCH
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            --[[
          Opening multiple files doesn't work by default.

          You can either following the implementation detailed here:
          https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1220846367

          Or you can have a more complex workflow:
          - Select multiple files using <Tab>
          - Send the selected files to the quickfix window using <C-o>
          - Search the quickfix window (using either :copen or <leader>q)

          NOTE: Scroll the preview window using <C-d> and <C-u>.
        ]]
            local actions = require("telescope.actions")
            local ts = require("telescope")

            ts.setup({
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {height = 0.75, preview_height = 0.7},
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-o>"] = actions.send_selected_to_qflist
                        }
                    },
                    scroll_strategy = "limit"
                },
                extensions = {heading = {treesitter = true}}
            })

            ts.load_extension("changed_files")
            ts.load_extension("emoji")
            ts.load_extension("fzf")
            ts.load_extension("heading")
            ts.load_extension("ui-select")
            ts.load_extension("windows")

            vim.g.telescope_changed_files_base_branch = "main"

            vim.keymap.set("n", "<leader>b", "<Cmd>Telescope buffers<CR>",
                           {desc = "search buffers"})
            vim.keymap.set("n", "<leader>c", "<Cmd>Telescope colorscheme<CR>",
                           {desc = "search colorschemes"})
            vim.keymap.set("n", "<leader>d", "<Cmd>TodoTelescope<CR>",
                           {desc = "search TODOs"})
            vim.keymap.set("n", "<leader>e", "<Cmd>Telescope commands<CR>",
                           {desc = "search Ex commands"})
            vim.keymap.set("n", "<leader>f",
                           "<Cmd>Telescope find_files hidden=true<CR>",
                           {desc = "search files"})
            vim.keymap.set("n", "<leader>g", "<Cmd>Telescope changed_files<CR>",
                           {desc = "search changed files"})
            vim.keymap.set("n", "<leader>h", "<Cmd>Telescope help_tags<CR>",
                           {desc = "search help"})
            vim.keymap.set("n", "<leader>i", "<Cmd>Telescope builtin<CR>",
                           {desc = "search builtins"})
            vim.keymap.set("n", "<leader>j", "<Cmd>Telescope emoji<CR>",
                           {desc = "search emojis"})
            vim.keymap.set("n", "<leader>k", "<Cmd>Telescope keymaps<CR>",
                           {desc = "search key mappings"})
            vim.keymap.set("n", "<leader>ld", "<Cmd>Telescope diagnostics<CR>",
                           {desc = "search lsp diagnostics"})
            vim.keymap.set("n", "<leader>li",
                           "<Cmd>Telescope lsp_incoming_calls<CR>",
                           {desc = "search lsp incoming calls"})
            vim.keymap.set("n", "<leader>lo",
                           "<Cmd>Telescope lsp_outgoing_calls<CR>",
                           {desc = "search lsp outgoing calls"})
            vim.keymap.set("n", "<leader>lr",
                           "<Cmd>Telescope lsp_references<CR>",
                           {desc = "search lsp code reference"})
            vim.keymap.set("n", "<leader>ls",
                           "<Cmd>lua require('telescope.builtin').lsp_document_symbols({show_line = true})<CR>",
                           {desc = "search lsp document tree"})
            vim.keymap.set("n", "<leader>m", "<Cmd>Telescope heading<CR>",
                           {desc = "search markdown headings"})
            vim.keymap.set("n", "<leader>n", "<Cmd>Noice telescope<CR>",
                           {desc = "search messages handled by Noice plugin"})
            vim.keymap.set("n", "<leader>q", "<Cmd>Telescope quickfix<CR>",
                           {desc = "search quickfix list"})
            vim.keymap.set("n", "<leader>r",
                           "<Cmd>Telescope current_buffer_fuzzy_find<CR>",
                           {desc = "search current buffer text"})
            vim.keymap.set("n", "<leader>s", "<Cmd>Telescope treesitter<CR>",
                           {desc = "search treesitter symbols"}) -- similar to lsp_document_symbols but treesitter doesn't know what a 'struct' is, just that it's a 'type'.
            vim.keymap.set("n", "<leader>w", "<Cmd>Telescope windows<CR>",
                           {desc = "search windows"})
            vim.keymap.set("n", "<leader>x", "<Cmd>Telescope live_grep<CR>",
                           {desc = "search text"})
        end
    }, {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}, {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function() require("telescope").setup({}) end
    }, "kyoh86/telescope-windows.nvim", "crispgm/telescope-heading.nvim",
    "xiyaowong/telescope-emoji.nvim", "axkirillov/telescope-changed-files", {
        "LukasPietzschmann/telescope-tabs",
        config = function()
            vim.keymap.set("n", "<leader>t",
                           "<Cmd>lua require('telescope-tabs').list_tabs()<CR>",
                           {desc = "search tabs"})
        end
    }, -- surface any TODO or NOTE code references
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({
                keywords = {
                    WARN = {
                        icon = " ",
                        color = "warning",
                        alt = {"WARNING", "XXX", "IMPORTANT"}
                    }
                }
            })
        end
    }, -- search indexer
    {
        "kevinhwang91/nvim-hlslens",
        config = function() require("hlslens").setup() end
    }, {
        "haya14busa/vim-asterisk",
        config = function()
            vim.api.nvim_set_keymap('n', '*',
                                    [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})
            vim.api.nvim_set_keymap('n', '#',
                                    [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})
            vim.api.nvim_set_keymap('n', 'g*',
                                    [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})
            vim.api.nvim_set_keymap('n', 'g#',
                                    [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})

            vim.api.nvim_set_keymap('x', '*',
                                    [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})
            vim.api.nvim_set_keymap('x', '#',
                                    [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})
            vim.api.nvim_set_keymap('x', 'g*',
                                    [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})
            vim.api.nvim_set_keymap('x', 'g#',
                                    [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
                                    {})
        end
    }, -- search and replace
    {
        "nvim-pack/nvim-spectre",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            require("spectre").setup({
                replace_engine = {["sed"] = {cmd = "gsed"}}
            })
            vim.keymap.set("n", "<leader>S",
                           "<Cmd>lua require('spectre').open()<CR>",
                           {desc = "search and replace"})
        end
    }, --
    -- TERMINAL
    {
        "akinsho/toggleterm.nvim",
        version = "v2.*",
        config = function()
            require("toggleterm").setup()

            local Terminal = require('toggleterm.terminal').Terminal
            local htop = Terminal:new({
                cmd = "htop",
                hidden = true,
                direction = "float"
            })

            -- NOTE: This is a global function so it can be called from the below mapping.
            function Htop_toggle() htop:toggle() end

            vim.api.nvim_set_keymap("n", "<leader><leader>th",
                                    "<cmd>lua Htop_toggle()<CR>", {
                noremap = true,
                silent = true,
                desc = "toggle htop"
            })

            vim.keymap.set("n", "<leader><leader>tf",
                           "<Cmd>ToggleTerm direction=float<CR>",
                           {desc = "toggle floating terminal"})
        end
    }, --
    -- TREESITTER
    --
    -- syntax tree parsing for more intelligent syntax highlighting and code navigation
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                "bash",
                "c",
                "cmake",
                "css",
                "dockerfile",
                "go",
                "gomod",
                "gowork",
                "hcl",
                "help",
                "html",
                "http",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "python",
                "regex",
                "ruby",
                "rust",
                "terraform",
                "toml",
                "vim",
                "yaml",
                "zig",
                ensure_installed = {},
                highlight = {enable = true},
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil
                }
            })
        end
    }, {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        config = function()
            require("nvim-treesitter.configs").setup({
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn", -- start treesitter selection process
                        scope_incremental = "gnm", -- increment selection to surrounding scope
                        node_incremental = ";", -- increment selection to next 'node'
                        node_decremental = "," -- decrement selection to prev 'node'
                    }
                },
                indent = {enable = true},
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        include_surrounding_whitespace = false,
                        keymaps = {
                            ["af"] = {
                                query = "@function.outer",
                                desc = "select around a function"
                            },
                            ["if"] = {
                                query = "@function.inner",
                                desc = "select inner part of a function"
                            },
                            ["ac"] = {
                                query = "@class.outer",
                                desc = "select around a class"
                            },
                            ["ic"] = {
                                query = "@class.inner",
                                desc = "select inner part of a class"
                            }
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v',
                            ['@function.outer'] = 'V',
                            ['@class.outer'] = '<c-v>'
                        }
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]]"] = "@function.outer",
                            ["]\\"] = "@class.outer"
                        },
                        goto_previous_start = {
                            ["[["] = "@function.outer",
                            ["[\\"] = "@class.outer"
                        }
                    }
                }
            })
        end
    }, {
        "lewis6991/spellsitter.nvim",
        config = function() require("spellsitter").setup() end
    }, {
        "m-demare/hlargs.nvim",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        config = function() require("hlargs").setup() end
    }, {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("treesitter-context").setup({separator = "-"})
        end
    }, -- buffer scroll context
    --
    -- UI
    --
    -- status line
    {
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
    }, -- ui improvements
    {
        "stevearc/dressing.nvim",
        config = function() require("dressing").setup() end
    },
    -- NOTE: `:Noice` to open message history + `:Noice telescope` to open message history in Telescope.
    {
        "folke/noice.nvim",
        event = "VimEnter",
        config = function()
            require("noice").setup({
                views = {
                    cmdline_popup = {
                        size = {width = "40%", height = "auto"},
                        win_options = {
                            winhighlight = {
                                Normal = "Normal",
                                FloatBorder = "DiagnosticSignInfo",
                                IncSearch = "",
                                Search = ""
                            }
                        }
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {row = 8, col = "50%"},
                        size = {width = 100, height = 10},
                        border = {style = "rounded", padding = {0, 0.5}},
                        win_options = {
                            winhighlight = {
                                Normal = "Normal",
                                FloatBorder = "DiagnosticSignInfo"
                            }
                        }
                    }
                },
                routes = {
                    -- skip displaying message that file was written to.
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            find = "written"
                        },
                        opts = {skip = true}
                    }
                },
                presets = {long_message_to_split = true, lsp_doc_border = true},
                documentation = {
                    opts = {
                        win_options = {
                            winhighlight = {FloatBorder = "DiagnosticSignInfo"}
                        }
                    }
                },
                lsp = {
                    progress = {
                        enabled = false -- I already use fidget configured in ./lsp.lua
                    }
                }
            })
        end,
        dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}
    }, -- tab ui improvements
    {
        "akinsho/bufferline.nvim",
        version = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {mode = "tabs"},
                highlights = {
                    tab = {fg = "#CCCCCC"}
                    -- tab_selected = {
                    --   fg = "#FF0000"
                    -- },
                }
            })
        end
    }, -- quickfix improvements
    --
    -- <Tab> to select items.
    -- zn to keep selected items.
    -- zN to filter selected items.
    -- zf to fuzzy search items.
    --
    -- <Ctrl-f> scroll down
    -- <Ctrl-b> scroll up
    {"junegunn/fzf", build = function() vim.fn["fzf#install"]() end},
    {"kevinhwang91/nvim-bqf", ft = "qf"}, -- window bar breadcrumbs
    {
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
    }, --
    -- scrollbar
    {
        "petertriho/nvim-scrollbar",
        config = function() require("scrollbar").setup() end
    }, --
    -- UTILITIES
    --
    -- swappable arguments and list elements
    {"mizlan/iswap.nvim", config = function() require("iswap").setup() end},
    -- block sorter
    "chiedo/vim-sort-blocks-by", -- modify surrounding characters
    {
        "kylechui/nvim-surround",
        config = function() require("nvim-surround").setup() end
    }, -- code comments
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()

            vim.keymap.set("n", "<leader><leader><leader>", "<Cmd>norm gcc<CR>",
                           {desc = "comment a single line"})
            vim.keymap.set("v", "<leader><leader><leader>",
                           "<Plug>(comment_toggle_linewise_visual)",
                           {desc = "comment multiple lines"})
        end
    }, -- display hex colours
    {
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end
    }, -- generate hex colours
    "uga-rosa/ccc.nvim", --
    -- WINDOWS
    --
    -- window picker
    {
        "s1n7ax/nvim-window-picker",
        version = "v1.*",
        config = function()
            local picker = require("window-picker")
            picker.setup({fg_color = "#000000"})

            vim.keymap.set("n", "<leader><leader>w", function()
                local picked_window_id =
                    picker.pick_window() or vim.api.nvim_get_current_win()
                vim.api.nvim_set_current_win(picked_window_id)
            end, {desc = "Pick a window"})
        end
    }, -- window zoom (avoids layout reset from <Ctrl-w>=)
    -- Caveat: NeoZoom doesn't play well with workflows that use the quickfix window.
    {
        "nyngwang/NeoZoom.lua",
        config = function()
            require('neo-zoom').setup({
                left_ratio = 0.2,
                top_ratio = 0,
                width_ratio = 0.6,
                height_ration = 1
            })
            vim.keymap.set("", "<leader><leader>z", "<Cmd>NeoZoomToggle<CR>",
                           {desc = "full screen active window"})
        end
    }, -- windows.nvim is more like the traditional <Ctrl-w>_ and <Ctrl-w>|
    {
        "anuvyklack/windows.nvim",
        dependencies = {"anuvyklack/middleclass"},
        config = function()
            vim.o.winwidth = 1
            vim.o.winminwidth = 0
            vim.o.equalalways = false
            require("windows").setup({
                autowidth = {
                    enable = false -- prevents messing up simrat39/symbols-outline.nvim (e.g. relative width of side-bar was being made larger)
                }
            })

            local function cmd(command)
                return table.concat({"<Cmd>", command, "<CR>"})
            end

            vim.keymap.set("n", "<C-w>\\", cmd "WindowsMaximize")
            vim.keymap.set("n", "<C-w>_", cmd "WindowsMaximizeVertically")
            vim.keymap.set("n", "<C-w>|", cmd "WindowsMaximizeHorizontally")
            vim.keymap.set("n", "<C-w>=", cmd "WindowsEqualize")
        end
    }, --
    -- WRITING
    {
        "marcelofern/vale.nvim",
        config = function()
            require("vale").setup({
                bin = "/usr/local/bin/vale",
                vale_config_path = "$HOME/.vale.ini"
            })
        end
    }
})

-- AUTOCOMMANDS

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    group = vim.api.nvim_create_augroup("AutoOpenQuickfix", {clear = true}),
    pattern = {"[^l]*"},
    command = "cwindow"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"sh", "go", "rust"},
    command = "setlocal textwidth=80"
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.mdx"},
    command = "set filetype=markdown"
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- vim.cmd("highlight BufDimText guibg='NONE' guifg=darkgrey guisp=darkgrey gui='NONE'")

        -- vim-illuminate (highlights every instance of word under the cursor)
        vim.api.nvim_set_hl(0, "illuminatedWord",
                            {fg = "#063970", bg = "#76b5c5"})
        vim.api.nvim_set_hl(0, "LspReferenceText",
                            {fg = "#063970", bg = "#76b5c5"})
        vim.api.nvim_set_hl(0, "LspReferenceWrite",
                            {fg = "#063970", bg = "#76b5c5"})
        vim.api.nvim_set_hl(0, "LspReferenceRead",
                            {fg = "#063970", bg = "#76b5c5"})

        -- eyeliner
        vim.api.nvim_set_hl(0, "EyelinerPrimary", {underline = true})
    end
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("WrapLineInMarkdown", {clear = true}),
    pattern = {"markdown"},
    command = "setlocal wrap"
})

-- HIGHLIGHTS

vim.api.nvim_create_autocmd({"VimEnter"}, {
    group = vim.api.nvim_create_augroup("ScrollbarHandleHighlight",
                                        {clear = true}),
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "ScrollbarHandle",
                            {fg = "#ff0000", bg = "#8ec07c"})
    end
})

-- MAPPINGS

vim.keymap.set("", "<leader><leader>ps", "<Cmd>PackerSync<CR>",
               {desc = "update vim plugins"})

vim.keymap.set("", "<leader><leader>pc",
               ":PackerCompile<CR>:echo 'PackerCompile complete'<CR>",
               {desc = "packer compile"})

vim.keymap.set("", "±", "<Cmd>nohlsearch<CR>",
               {desc = "turn off search highlight"})

vim.keymap.set("n", "<C-d>", "<C-d>zz",
               {desc = "scroll down and then center the cursorline"})

vim.keymap.set("n", "<C-u>", "<C-u>zz",
               {desc = "scroll up and then center the cursorline"})

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- NETRW

-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/

-- keep the current directory and the browsing directory synced.
-- this helps avoid the "move files" error.
vim.g.netrw_keepdir = 0

-- configure the horizontal split size.
vim.g.netrw_winsize = 30

-- hide the banner (`I` will temporarily display it).
-- vim.g.netrw_banner = 0

-- change default copy command to be recursive by default.
vim.g.netrw_localcopydircmd = "cp -r"

-- OPTIONS

--[[
To see what an option is set to execute :lua = vim.o.<name>
--]]

vim.o.background = "dark"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.cursorline = true
vim.o.dictionary = "/usr/share/dict/words"
vim.o.expandtab = true
vim.o.grepprg = "rg --vimgrep --multiline-dotall"
vim.o.ignorecase = true
vim.o.inccommand = "split"
-- vim.o.lazyredraw = true (disabled as problematic with Noice plugin)
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 2
-- vim.o.shortmess = vim.o.shortmess .. "c" -- .. is equivalent to += in vimscript
vim.o.shortmess = "filnxToOFc" -- copied default and removed `t` (long paths were being truncated) while adding `c`
vim.o.showmatch = true
vim.o.signcolumn = "auto"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spell = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.updatetime = 1000 -- affects CursorHold and subsequently things like highlighting Code Actions, and the Noice UI popups.
vim.o.wrap = false

if vim.fn.has("termguicolors") == 1 then vim.o.termguicolors = true end

--[[
vim.o allows you to set global vim options, but not local buffer vim options.
vim.opt has a more expansive API that can handle local and global vim options.
See :h lua-vim-options
]]
vim.opt.colorcolumn = "80"

-- QUICKFIX

vim.cmd("packadd cfilter")

-- UI

-- LSP UI boxes improvements
--
-- NOTE: Noice plugin will override these settings.
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
vim.diagnostic.config({float = {border = "rounded", style = "minimal"}})

-- Configure the UI aspect of the quickfix window
-- NOTE: See https://github.com/kevinhwang91/nvim-bqf#customize-quickfix-window-easter-egg and ~/.config/nvim/syntax/qf.vim
local fn = vim.fn

-- This will sort the quickfix results list.
--
-- :lua _G.qfSort()
function _G.qfSort()
    local items = fn.getqflist()
    table.sort(items, function(a, b)
        if a.bufnr == b.bufnr then
            if a.lnum == b.lnum then
                return a.col < b.col
            else
                return a.lnum < b.lnum
            end
        else
            return a.bufnr < b.bufnr
        end
    end)
    fn.setqflist(items, 'r')
end

vim.keymap.set("", "<leader><leader>qs", "<Cmd>lua _G.qfSort()<CR>",
               {desc = "sort quickfix window"})

-- This will align the quickfix window list.
function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's',
                                 '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
