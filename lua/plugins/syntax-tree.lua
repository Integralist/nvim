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
        outline_window = { position = "left", width = 25 }
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
          Module = "",
          Namespace = "",
          Package = "",
          Class = "",
          Method = "",
          Property = "",
          Field = "",
          Constructor = "",
          Enum = "",
          Interface = "",
          Function = "",
          Variable = "",
          Constant = "",
          String = "",
          Number = "",
          Boolean = "",
          Array = "",
          Object = "",
          Key = "",
          Null = "",
          EnumMember = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
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
