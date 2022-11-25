--[[
To see what an option is set to execute :lua = vim.o.<name>
--]]

vim.o.background = "dark"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.cursorline = true
vim.o.dictionary = "/usr/share/dict/words"
vim.o.expandtab = true
vim.o.grepprg = "rg --vimgrep --multiline-dotall"
vim.o.ignorecase = true
vim.o.inccommand = "split"
-- vim.o.lazyredraw = true (disabled as problematic with Noice plugin)
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 2
-- vim.o.shortmess = vim.o.shortmess .. "c" -- .. is equivalent to += in vimscript
vim.o.shortmess = "filnxToOFc" -- copied default and removed `t` (long paths were being truncated) while adding `c`
vim.o.showmatch = true
vim.o.signcolumn = "auto"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spell = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.updatetime = 1000 -- affects CursorHold and subsequently things like highlighting Code Actions, and the Noice UI popups.
vim.o.wrap = false

if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

--[[
vim.o allows you to set global vim options, but not local buffer vim options.
vim.opt has a more expansive API that can handle local and global vim options.
See :h lua-vim-options
]]
vim.opt.colorcolumn = "80"
