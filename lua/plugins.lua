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
      ["<leader><leader>d"] = { name = "todo" },
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
  config = function() vim.cmd("colorscheme nightfox") end
}
}
