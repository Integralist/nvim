return {
  {
    -- INDENTATION AUTOPAIRING
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }, {
    -- WHITESPACE MANAGEMENT
    "zakharykaplan/nvim-retrail",
    config = function()
      require("retrail").setup({
        filetype = {
          exclude = {
            "markdown", "neo-tree",
            -- following are defaults that need to be added or they'll be overridden
            "", "alpha", "checkhealth", "diff", "help", "lspinfo",
            "man", "mason", "TelescopePrompt", "Trouble", "WhichKey"
          }
        }
      })
    end
  }
}
