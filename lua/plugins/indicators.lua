return function(use)
  -- word usage highlighter
  use { "RRethy/vim-illuminate",
    config = function()
      vim.api.nvim_create_autocmd("IlluminateWords", {
        pattern = {
          "*"
        },
        callback = function()
          vim.api.nvim_set_hl(0, "illuminatedWord", { fg = "Red", bg = "White" })
          vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "Red", bg = "White" })
          vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "Red", bg = "White" })
          vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "Red", bg = "White" })
        end
      })
    end
  }

  -- jump to word indictors
  use { "jinh0/eyeliner.nvim",
    config = function()
      vim.api.nvim_set_hl(0, "EyelinerPrimary", { underline = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = {
          "*"
        },
        callback = function()
          vim.api.nvim_set_hl(0, "EyelinerPrimary", { underline = true })
        end
      })
    end
  }

  -- cursor movement highlighter
  use "DanilaMihailov/beacon.nvim"

  -- highlight yanked region
  use "machakann/vim-highlightedyank"

  -- suggest mappings
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  }
end
