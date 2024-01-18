vim.keymap.set("", "<leader><leader>ps", "<Cmd>Lazy sync<CR>",
  { desc = "update vim plugins" })

vim.keymap.set("", "±", "<Cmd>nohlsearch<CR>",
  { desc = "turn off search highlight" })

vim.keymap.set("n", "<C-d>", "<C-d>zz",
  { desc = "scroll down and then center the cursorline" })

vim.keymap.set("n", "<C-u>", "<C-u>zz",
  { desc = "scroll up and then center the cursorline" })

vim.keymap.set("n", "zo", "zozz",
  { desc = "open fold and then center the cursorline" })

vim.keymap.set("n", "zr", "zrzz",
  { desc = "open fold and then center the cursorline" })

vim.keymap.set("n", "zR", "zRzz",
  { desc = "open all folds and then center the cursorline" })

vim.keymap.set("n", "zc", "zczz",
  { desc = "close fold and then center the cursorline" })

vim.keymap.set("n", "zm", "zmzz",
  { desc = "close fold and then center the cursorline" })

vim.keymap.set("n", "zM", "zMzz",
  { desc = "close all folds and then center the cursorline" })

vim.keymap.set("n", "n", "nzz",
  { desc = "move to the next search match and then center the cursorline" })

vim.keymap.set("n", "N", "Nzz",
  { desc = "move to the prev search match and then center the cursorline" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
