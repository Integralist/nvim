return {
  {
    -- NEOVIM DEVELOPMENT SETUP
    "folke/neodev.nvim"
  }, {
  -- MAPPING IDENTIFIER
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.register({
      -- ["<leader>d"] = { name = "todo" },
      ["<leader>l"] = { name = "lsp" },
      ["<leader><leader>b"] = { name = "dap/debug" },
      ["<leader><leader>d"] = { name = "diagnostics/todos" },
      ["<leader><leader>f"] = { name = "format" },
      ["<leader><leader>g"] = { name = "git" },
      ["<leader><leader>l"] = { name = "lsp" },
      -- ["<leader><leader>n"] = {name = "noice"},
      ["<leader><leader>o"] = { name = "outline" },
      ["<leader><leader>p"] = { name = "plugins" },
      ["<leader><leader>q"] = { name = "quickfix" },
      ["<leader><leader>r"] = { name = "rust lsp" },
      ["<leader><leader>t"] = { name = "terminal" }
    })
  end
}, {
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
