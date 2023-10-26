return {
  {
    -- DOCUMENT/CODE SYNTAX TREE
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        -- autofold_depth = 1, -- h: close, l: open, W: close all, E: open all
        auto_close = false,
        highlight_hovered_item = true,
        position = "left",
        width = 15
      })
    end
  }, {
  -- MINIMAP
  "gorbit99/codewindow.nvim",
  config = function()
    require("codewindow").setup({
      auto_enable = false,
      use_treesitter = true,           -- disable to lose colours
      exclude_filetypes = {
        "Outline", "neo-tree", "qf", "packer", "help", "noice",
        "Trouble"
      }
    })
    vim.keymap.set("n", "<leader><leader>m",
      "<cmd>lua require('codewindow').toggle_minimap()<CR>",
      {
        noremap = true,
        silent = true,
        desc = "Toggle minimap"
      })
  end
}
}
