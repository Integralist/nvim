return {
  -- {
  --   "yutkat/confirm-quit.nvim",
  --   event = "CmdlineEnter",
  --   config = function()
  --     require("confirm-quit").setup()
  --     vim.cmd("unabbreviate qa")
  --   end,
  -- },
  {
    -- NEOVIM DEVELOPMENT SETUP
    "folke/neodev.nvim"
  },
  {
    -- MAKE DOT OPERATOR WORK IN A SENSIBLE WAY
    "tpope/vim-repeat"
  },
  {
    -- SWAPPABLE ARGUMENTS AND LIST ELEMENTS
    "mizlan/iswap.nvim",
    config = true
  },
  {
    -- BLOCK SORTER
    "chiedo/vim-sort-blocks-by"
  },
  {
    -- MODIFY SURROUNDING CHARACTERS
    "kylechui/nvim-surround",
    config = true
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      {
        "<leader><leader>a",
        "<Plug>(EasyAlign)",
        desc = "Align for visual selection",
        mode = "x",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>a",
        "<Plug>(EasyAlign)",
        desc = "Align for motion/text object",
        mode = "n",
        noremap = true,
        silent = true
      }
    }
  },
  {
    -- DISPLAY HEX COLOURS
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end -- WARNING: Don't replace with `opts = {}` or `config = true` as it doesn't work
  },
  {
    -- GENERATE HEX COLOURS
    -- :CccPick
    "uga-rosa/ccc.nvim",
    config = true
  },
  {
    -- ASYNC DISPATCH
    "tpope/vim-dispatch"
  },
}
