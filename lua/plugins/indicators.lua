return function(use)
  -- word usage highlighter
  use "RRethy/vim-illuminate"

  -- jump to word indictors
  use "jinh0/eyeliner.nvim"

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
