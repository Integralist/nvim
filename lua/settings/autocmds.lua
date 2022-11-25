vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("PackerCompiler", { clear = true }),
  pattern = "*.lua",
  command = "source <afile> | PackerCompile | LuaCacheClear",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    "*.lua"
  },
  command = "source ~/.config/nvim/init.lua"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "sh", "go", "rust"
  },
  command = "setlocal textwidth=80"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.mdx"
  },
  command = "set filetype=markdown"
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = {
    "*"
  },
  callback = function()
    vim.cmd("highlight BufDimText guibg='NONE' guifg=darkgrey guisp=darkgrey gui='NONE'")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("WrapLineInMarkdown", { clear = true }),
  pattern = {
    "markdown"
  },
  command = "setlocal wrap"
})

-- The following code implements dimming of inactive buffers
-- An alternative is https://github.com/levouh/tint.nvim

local function windowIsRelative(windowId)
  return vim.api.nvim_win_get_config(windowId).relative ~= ''
end

local function windowIsCf(windowId)
  local buftype = vim.bo.buftype

  if windowId ~= nil then
    local bufferId = vim.api.nvim_win_get_buf(windowId)
    buftype = vim.api.nvim_buf_get_option(bufferId, 'buftype')
  end

  return buftype == 'quickfix'
end

local function toggleDimWindows()
  local windowsIds = vim.api.nvim_list_wins()
  local currentWindowId = vim.api.nvim_get_current_win()

  if windowIsRelative(currentWindowId) then
    return
  end

  pcall(vim.fn.matchdelete, currentWindowId)

  if windowIsCf(currentWindowId) then
    return
  end

  for _, id in ipairs(windowsIds) do
    if id ~= currentWindowId and not windowIsRelative(id) then
      pcall(vim.fn.matchadd, 'BufDimText', '.', 200, id, { window = id })
    end
  end
end

vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = vim.api.nvim_create_augroup("DimInactiveBuffers", { clear = true }),
  pattern = "*",
  callback = function()
    toggleDimWindows()
  end,
})
