return function(use)
  -- swappable arguments and list elements
  use {
    "mizlan/iswap.nvim",
    config = function()
      require("iswap").setup()
    end
  }

  -- block sorter
  use "chiedo/vim-sort-blocks-by"

  -- modify surrounding characters
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  })

  -- code comments
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()

      vim.keymap.set("n", "<leader><leader><leader>", "<Cmd>norm gcc<CR>", { desc = "comment a single line" })
      vim.keymap.set("v", "<leader><leader><leader>", "<Plug>(comment_toggle_linewise_visual)",
        { desc = "comment multiple lines" })
    end
  }

  -- display hex colours
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  }

  -- generate hex colours
  use "uga-rosa/ccc.nvim"
end
