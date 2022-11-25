return function(use)
  -- camel case motion support
  use {
    "bkad/CamelCaseMotion",
    config = function()
      vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', { silent = true })
      vim.keymap.set('', 'b', '<Plug>CamelCaseMotion_b', { silent = true })
      vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', { silent = true })
      vim.keymap.set('', 'ge', '<Plug>CamelCaseMotion_ge', { silent = true })
    end
  }

  -- move lines around
  use { "matze/vim-move",
    config = function()
      vim.g.move_key_modifier = "C"
      vim.g.move_key_modifier_visualmode = "S" -- e.g. Shift-k to move up, Shift-j to move down
    end
  }
end
