return {
  {
    -- DOCUMENT/CODE SYNTAX TREE
    -- h: close, l: open, W: close all, E: open all
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "gs", "<cmd>Outline<CR>", desc = "List document symbols in a tree" },
      {
        "<leader><leader>of",
        "<cmd>OutlineFocus<CR>",
        desc = "Focus cursor inside symbols outline window"
      }
    },
    opts = { outline_window = { position = "left", width = 25 } }
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
