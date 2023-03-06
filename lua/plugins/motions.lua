return {
  {
    -- CAMEL CASE MOTION SUPPORT
    "bkad/CamelCaseMotion",
    config = function()
      vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', { silent = true })
      vim.keymap.set('', 'b', '<Plug>CamelCaseMotion_b', { silent = true })
      vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', { silent = true })
      vim.keymap
          .set('', 'ge', '<Plug>CamelCaseMotion_ge', { silent = true })
    end
  }, {
    -- MOVE LINES AROUND
    "fedepujol/move.nvim",
    config = function()
      local opts = { noremap = true, silent = true }
      -- Normal-mode commands
      vim.keymap.set('n', '<C-j>', ':MoveLine(1)<CR>', opts)
      vim.keymap.set('n', '<C-k>', ':MoveLine(-1)<CR>', opts)
      vim.keymap.set('n', '<C-h>', ':MoveHChar(-1)<CR>', opts)
      vim.keymap.set('n', '<C-l>', ':MoveHChar(1)<CR>', opts)

      -- Visual-mode commands
      vim.keymap.set('v', '<S-j>', ':MoveBlock(1)<CR>', opts)
      vim.keymap.set('v', '<S-k>', ':MoveBlock(-1)<CR>', opts)
      vim.keymap.set('v', '<S-h>', ':MoveHBlock(-1)<CR>', opts)
      vim.keymap.set('v', '<S-l>', ':MoveHBlock(1)<CR>', opts)
    end
  }
}
