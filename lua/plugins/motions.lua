return {
  {
    -- CAMEL CASE MOTION SUPPORT
    "bkad/CamelCaseMotion",
    keys = {
      {
        "w",
        "<Plug>CamelCaseMotion_w",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "b",
        "<Plug>CamelCaseMotion_b",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "e",
        "<Plug>CamelCaseMotion_e",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "ge",
        "<Plug>CamelCaseMotion_ge",
        mode = "n",
        noremap = true,
        silent = true
      },
    }
  },
  {
    -- MOVE LINES AROUND
    "fedepujol/move.nvim",
    keys = {
      {
        "<C-j>",
        ":MoveLine(1)<CR>",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<C-k>",
        ":MoveLine(-1)<CR>",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<S-j>",
        ":MoveBlock(1)<CR>",
        mode = "v",
        noremap = true,
        silent = true
      },
      {
        "<S-k>",
        ":MoveBlock(-1)<CR>",
        mode = "v",
        noremap = true,
        silent = true
      },
    },
    config = true
  }
}
