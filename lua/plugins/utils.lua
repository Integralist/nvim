return {
  {
    -- MAKE DOT OPERATOR WORK IN A SENSIBLE WAY
    "tpope/vim-repeat"
  }, {
  -- SWAPPABLE ARGUMENTS AND LIST ELEMENTS
  "mizlan/iswap.nvim",
  config = true
}, {
  -- BLOCK SORTER
  "chiedo/vim-sort-blocks-by"
}, {
  -- MODIFY SURROUNDING CHARACTERS
  "kylechui/nvim-surround",
  config = true
}, {
  -- CODE COMMENTS
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()

    vim.keymap.set("n", "<leader><leader><leader>", "<Cmd>norm gcc<CR>",
      { desc = "comment a single line" })
    vim.keymap.set("v", "<leader><leader><leader>",
      "<Plug>(comment_toggle_linewise_visual)",
      { desc = "comment multiple lines" })
  end
}, {
  -- DISPLAY HEX COLOURS
  "norcalli/nvim-colorizer.lua",
  config = function() require("colorizer").setup() end
}, {
  -- GENERATE HEX COLOURS
  "uga-rosa/ccc.nvim"
}, {
  -- ASYNC DISPATCH
  "tpope/vim-dispatch"
}
}
