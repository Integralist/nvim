return {
  {
    -- DOCUMENT/CODE SYNTAX TREE
    -- h: close, l: open, W: close all, E: open all
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "gs", "<cmd>Outline<CR>", desc = "List document symbols in a tree" },
      {
        "<leader><leader>of",
        "<cmd>OutlineFollow<CR>",
        desc = "Focus cursor inside symbols outline window on current node"
      }
    },
    config = function()
      require("outline").setup({
        outline_window = { position = "left", width = 25 },
        symbols = {
          icons = {
            File = { icon = '󰈔', hl = 'Identifier' },
            Module = { icon = '󰆧', hl = 'Include' },
            Namespace = { icon = '󰌗', hl = 'Include' }, -- 󰅪
            Package = { icon = '', hl = 'Include' }, -- 󰏗
            Class = { icon = '𝓒', hl = 'Type' },
            Method = { icon = '', hl = 'Function' }, -- ƒ ➡️
            Property = { icon = '', hl = 'Identifier' },
            Field = { icon = '', hl = 'Identifier' }, -- 󰆨 
            Constructor = { icon = '', hl = 'Special' }, -- 
            Enum = { icon = 'ℰ', hl = 'Type' },
            Interface = { icon = '', hl = 'Type' }, -- 󰜰
            Function = { icon = 'ƒ', hl = 'Function' }, -- 
            Variable = { icon = '', hl = 'Constant' }, -- 
            Constant = { icon = '', hl = 'Constant' },
            String = { icon = '𝓢', hl = 'String' }, -- 𝓐
            Number = { icon = '#', hl = 'Number' },
            Boolean = { icon = '◩', hl = 'Boolean' }, -- ⊨ 
            Array = { icon = '󰅪', hl = 'Constant' },
            Object = { icon = '', hl = 'Type' }, -- ⦿
            Key = { icon = '󰌋', hl = 'Type' }, -- 🔐
            Null = { icon = 'NULL', hl = 'Type' },
            EnumMember = { icon = '', hl = 'Identifier' },
            Struct = { icon = '', hl = 'Structure' }, -- 𝓢
            Event = { icon = '🗲', hl = 'Type' },
            Operator = { icon = '󰆕', hl = 'Identifier' }, -- + 
            TypeParameter = { icon = '󰊄', hl = 'Identifier' }, -- 𝙏
            Component = { icon = '󰅴', hl = 'Function' },
            Fragment = { icon = '󰅴', hl = 'Constant' },
            TypeAlias = { icon = ' ', hl = 'Type' }, -- 
            Parameter = { icon = ' ', hl = 'Identifier' },
            StaticMethod = { icon = ' ', hl = 'Function' },
            Macro = { icon = ' ', hl = 'Function' },
          },
        }
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "Outline",
        command = "setlocal nofoldenable"
      })
    end
  },
  {
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
        -- prevent barbecue from automatically attaching nvim-navic
        -- this is so shared LSP attach handler can handle attaching only when LSP running
        attach_navic = false,
        kinds = {
          File = "",
          Module = "󰆧", -- 
          Namespace = "󰌗", --  󰅪
          Package = "",
          Class = "𝓒", -- 
          Method = "", -- 
          Property = "", -- 
          Field = "", --  
          Constructor = "", --  
          Enum = "ℰ", -- 
          Interface = "",
          Function = "ƒ", -- 
          Variable = "", --  
          Constant = "", -- 
          String = "𝓢", -- 
          Number = "#", -- 
          Boolean = "◩", -- 
          Array = "",
          Object = "",
          Key = "󰌋", -- 
          Null = "",
          EnumMember = "", -- 
          Struct = "", -- 
          Event = "",
          Operator = "󰆕", -- 
          TypeParameter = "󰊄", --  𝙏
        },
      })
    end
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig", "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
    keys = {
      {
        "<leader>lt",
        function() require("nvim-navbuddy").open() end,
        desc = "Navigate symbols via Navbuddy tree",
        mode = "n",
        noremap = true,
        silent = true
      }
    },
    config = function()
      local navbuddy = require("nvim-navbuddy")
      local actions = require("nvim-navbuddy.actions")
      navbuddy.setup({
        icons = {
          File          = "󰈙 ",
          Module        = "󰆧 ", -- 
          Namespace     = "󰌗 ",
          Package       = " ", -- 
          Class         = "𝓒 ", -- 󰌗
          Method        = " ", -- 󰆧
          Property      = " ", -- 
          Field         = " ", --  
          Constructor   = " ",
          Enum          = "ℰ", -- 󰕘
          Interface     = "", -- 󰕘
          Function      = "󰊕 ",
          Variable      = "", -- 󰆧 
          Constant      = "󰏿 ",
          String        = "𝓢 ", -- 
          Number        = "# ", -- 󰎠
          Boolean       = "◩ ",
          Array         = "󰅪 ",
          Object        = " ", -- 󰅩
          Key           = "󰌋 ",
          Null          = " ", -- 󰟢
          EnumMember    = " ",
          Struct        = " ", -- 󰌗
          Event         = " ", -- 
          Operator      = "󰆕 ",
          TypeParameter = "󰊄 ",
        },
        mappings = {
          ["<Down>"] = actions.next_sibling(),   -- down
          ["<Up>"] = actions.previous_sibling(), -- up
          ["<Left>"] = actions.parent(),         -- Move to left panel
          ["<Right>"] = actions.children()       -- Move to right panel
        },
        window = {
          border = "rounded",
          size = "90%",
          sections = { left = { size = "30%" }, mid = { size = "40%" } }
        }
      })
    end
  },
  {
    -- MINIMAP
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
      vim.keymap.set("n", "<leader><leader>m",
        "<cmd>lua require('codewindow').toggle_minimap()<CR>",
        {
          noremap = true,
          silent = true,
          desc = "Toggle minimap"
        })
    end
  }
}
-- diagnostics = {
--       Error = ' ',
--       Hint = '󰌵 ',
--       Information = ' ',
--       Question = ' ',
--       Warning = ' ',
--   },
--   documents = {
--       File = ' ',
--       FileEmpty = ' ',
--       Files = ' ',
--       Folder = ' ',
--       FolderEmpty = ' ',
--       OpenFolder = ' ',
--       OpenFolderEmpty = ' ',
--       SymLink = ' ',
--       SymlinkFolder = ' ',
--       Import = ' ',
--   },
--   git = {
--       Add = ' ',
--       AddAlt = ' ',
--       Branch = ' ',
--       Diff = ' ',
--       DiffAlt = ' ',
--       Ignore = '◌ ',
--       Mod = ' ',
--       Octoface = ' ',
--       Remove = ' ',
--       RemoveAlt = ' ',
--       Rename = ' ',
--       Repo = ' ',
--       Tag = ' ',
--       Untrack = ' ',
--   },
--   kind = {
--       Class = ' ',
--       Color = ' ',
--       Constant = ' ',
--       Constructor = '󰈏 ',
--       Enum = ' ',
--       EnumMember = ' ',
--       Event = ' ',
--       Field = ' ',
--       File = ' ',
--       Folder = ' ',
--       Function = '󰊕 ',
--       Interface = ' ',
--       Keyword = ' ',
--       Method = ' ',
--       Module = '',
--       Operator = ' ',
--       Property = ' ',
--       Reference = ' ',
--       Snippet = ' ',
--       Struct = ' ',
--       Text = ' ',
--       TypeParameter = ' ',
--       Unit = ' ',
--       Value = ' ',
--       Variable = ' ',
--   },
--   type = {
--       Array = ' ',
--       Boolean = '⏻ ',
--       Number = ' ',
--       Object = ' ',
--       String = ' ',
--   },
--   ui = {
--       Arrow = '➜ ',
--       ArrowClosed = ' ',
--       ArrowLeft = ' ',
--       ArrowOpen = ' ',
--       ArrowRight = ' ',
--       Bluetooth = ' ',
--       Bookmark = ' ',
--       Bug = ' ',
--       Calendar = ' ',
--       Camera = ' ',
--       Check = ' ',
--       ChevronRight = '',
--       Circle = ' ',
--       CircleSmall = '● ',
--       CircleSmallEmpty = '○ ',
--       Clipboard = ' ',
--       Close = ' ',
--       Code = ' ',
--       Collection = ' ',
--       Color = ' ',
--       Command = ' ',
--       Comment = ' ',
--       Corner = '└ ',
--       Dashboard = ' ',
--       Database = ' ',
--       Download = ' ',
--       Edge = '│ ',
--       Electric = ' ',
--       Fire = ' ',
--       Firefox = ' ',
--       Game = ' ',
--       Gear = ' ',
--       GitHub = ' ',
--       Heart = ' ',
--       History = ' ',
--       Home = ' ',
--       Incoming = ' ',
--       Keyboard = '  ',
--       List = '',
--       Lock = ' ',
--       Minus = '‒ ',
--       Music = '󰝚 ',
--       NeoVim = ' ',
--       NewFile = ' ',
--       None = ' ',
--       Note = ' ',
--       Outgoing = ' ',
--       Package = ' ',
--       Paint = ' ',
--       Pause = ' ',
--       Pencil = ' ',
--       Person = ' ',
--       Pin = ' ',
--       Play = ' ',
--       Plug = ' ',
--       Plus = ' ',
--       Power = ' ',
--       PowerlineArrowLeft = '',
--       PowerlineArrowRight = '',
--       PowerlineLeftRound = '',
--       PowerlineRightRound = '',
--       Project = ' ',
--       Question = ' ',
--       Reload = ' ',
--       Rocket = ' ',
--       Save = '󰆓 ',
--       Search = ' ',
--       Separator = '▊ ',
--       SignIn = ' ',
--       SignOut = ' ',
--       Sleep = '󰒲 ',
--       Star = ' ',
--       Table = ' ',
--       Telescope = ' ',
--       Terminal = ' ',
--       Test = ' ',
--       Time = ' ',
--       Trash = ' ',
--       Vim = ' ',
--       Wifi = ' ',
--       Windows = ' ',
--   },
