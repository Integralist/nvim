return {
  {
    -- NEOVIM DEVELOPMENT SETUP
    "folke/neodev.nvim"
  },
  {
    -- MAPPING IDENTIFIER
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>d",         group = "todo" },
        { "<leader>l",         group = "lsp" },
        { "<leader><leader>b", group = "dap/debug" },
        { "<leader><leader>d", group = "diagnostics/todos" },
        { "<leader><leader>f", group = "format" },
        { "<leader><leader>g", group = "git" },
        { "<leader><leader>l", group = "lsp" },
        { "<leader><leader>o", group = "oil" },
        { "<leader><leader>p", group = "plugins" },
        { "<leader><leader>q", group = "quickfix" },
        { "<leader><leader>r", group = "rust" },
        { "<leader><leader>t", group = "terminal" },
      }
    }
  },
  {
    -- COLORSCHEME
    "EdenEast/nightfox.nvim",
    lazy = false,    -- make sure we load this during startup as it is our main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd("colorscheme nightfox")

      -- The following was in an autocommand in ./autocommands.lua
      -- But for some reason wouldn't load until I attempted to switch schemes.
      -- It looks like some other colourscheme is loaded first.
      -- That scheme takes precedence over me setting nightfox here.
      -- Possibly the new default theme that comes with neovim 0.10.0
      -- So the solution is to set the highlights here and keep them in autocommand.
      vim.api.nvim_set_hl(0, "illuminatedWord",
        { fg = "#063970", bg = "#76b5c5" })
      vim.api.nvim_set_hl(0, "LspReferenceText",
        { fg = "#063970", bg = "#76b5c5" })
      vim.api.nvim_set_hl(0, "LspReferenceWrite",
        { fg = "#063970", bg = "#76b5c5" })
      vim.api.nvim_set_hl(0, "LspReferenceRead",
        { fg = "#063970", bg = "#76b5c5" })
      vim.api.nvim_set_hl(0, 'EyelinerPrimary',
        { fg = "#FF0000", bold = true, underline = true })
      vim.api.nvim_set_hl(0, 'EyelinerSecondary',
        { fg = "#FFFF00", underline = true })
    end
  },
}
