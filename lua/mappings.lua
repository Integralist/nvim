vim.keymap.set("", "<leader><leader>ps", "<Cmd>PackerSync<CR>",
  { desc = "update vim plugins" })

vim.keymap.set("", "<leader><leader>pc",
  ":PackerCompile<CR>:echo 'PackerCompile complete'<CR>",
  { desc = "packer compile" })

vim.keymap.set("", "±", "<Cmd>nohlsearch<CR>",
  { desc = "turn off search highlight" })

vim.keymap.set("n", "<C-d>", "<C-d>zz",
  { desc = "scroll down and then center the cursorline" })

vim.keymap.set("n", "<C-u>", "<C-u>zz",
  { desc = "scroll up and then center the cursorline" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
