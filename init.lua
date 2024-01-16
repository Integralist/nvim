-- ~/.local/share/nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  checker = {
    enabled = true, -- automatically check for plugin updates
    notify = true
  },
  spec = {
    { import = "plugins" }
  },
})
require("autocommands")
require("mappings")
require("settings")
require("commands")
require("quickfix")
