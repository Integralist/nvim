return {
  {
    -- INDENTATION AUTOPAIRING
    "windwp/nvim-autopairs",
    config = true,
  },
  {
    -- WHITESPACE MANAGEMENT
    "kaplanz/retrail.nvim",
    opts = {
      filetype = {
        exclude = {
          "markdown", "neo-tree",
          -- following are defaults that need to be added or they'll be overridden
          "", "aerial", "alpha", "checkhealth", "cmp_menu", "diff", "help",
          "lazy", "lspinfo", "man", "mason", "TelescopePrompt", "toggleterm",
          "Trouble", "WhichKey"
        }
      }
    }
  }
}
