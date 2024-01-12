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
            Namespace = { icon = '󰅪', hl = 'Include' },
            Package = { icon = '', hl = 'Include' }, -- 󰏗
            Class = { icon = '𝓒', hl = 'Type' },
            Method = { icon = '', hl = 'Function' }, -- ƒ ➡️
            Property = { icon = '', hl = 'Identifier' },
            Field = { icon = '', hl = 'Identifier' }, -- 󰆨
            Constructor = { icon = '', hl = 'Special' },
            Enum = { icon = 'ℰ', hl = 'Type' },
            Interface = { icon = '', hl = 'Type' }, -- 󰜰
            Function = { icon = 'ƒ', hl = 'Function' }, -- 
            Variable = { icon = '', hl = 'Constant' },
            Constant = { icon = '', hl = 'Constant' },
            String = { icon = '𝓢', hl = 'String' }, -- 𝓐
            Number = { icon = '#', hl = 'Number' },
            Boolean = { icon = '', hl = 'Boolean' }, -- ⊨
            Array = { icon = '󰅪', hl = 'Constant' },
            Object = { icon = '', hl = 'Type' }, -- ⦿
            Key = { icon = '🔐', hl = 'Type' },
            Null = { icon = 'NULL', hl = 'Type' },
            EnumMember = { icon = '', hl = 'Identifier' },
            Struct = { icon = '', hl = 'Structure' }, -- 𝓢
            Event = { icon = '🗲', hl = 'Type' },
            Operator = { icon = '', hl = 'Identifier' }, -- +
            TypeParameter = { icon = '𝙏', hl = 'Identifier' },
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
          Namespace = "󰅪", -- 
          Package = "",
          Class = "𝓒", -- 
          Method = "", -- 
          Property = "", -- 
          Field = "", -- 
          Constructor = "", -- 
          Enum = "ℰ", -- 
          Interface = "",
          Function = "ƒ", -- 
          Variable = "", -- 
          Constant = "", -- 
          String = "𝓢", -- 
          Number = "#", -- 
          Boolean = "",
          Array = "",
          Object = "",
          Key = "",
          Null = "",
          EnumMember = "",
          Struct = "", -- 
          Event = "",
          Operator = "",
          TypeParameter = "𝙏", -- 
        },
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
