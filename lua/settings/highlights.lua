vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("ScrollbarHandleHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "ScrollbarHandle", { fg = "#ff0000", bg = "#8ec07c" })
  end,
})
