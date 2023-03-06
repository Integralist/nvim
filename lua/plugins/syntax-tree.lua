return {
  {
    -- DOCUMENT/CODE SYNTAX TREE
    "simrat39/symbols-outline.nvim",
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
          TypeParameter = { icon = "𝙏", hl = "GruvboxRed" } -- TTSParameter
        }
      })
    end
  }, {
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
      vim.api.nvim_set_keymap("n", "<leader><leader>m",
        "<cmd>lua require('codewindow').toggle_minimap()<CR>",
        {
          noremap = true,
          silent = true,
          desc = "Toggle minimap"
        })
    end
  }
}
