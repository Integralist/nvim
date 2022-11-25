return function(use)
  -- word usage highlighter
  use { "RRethy/vim-illuminate",
    config = function()
      -- vim.cmd("highlight illuminatedWord guifg=red guibg=white")
      -- vim.api.nvim_command [[ highlight LspReferenceText guifg=red guibg=white ]]
      -- vim.api.nvim_command [[ highlight LspReferenceWrite guifg=red guibg=white ]]
      -- vim.api.nvim_command [[ highlight LspReferenceRead guifg=red guibg=white ]]
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
