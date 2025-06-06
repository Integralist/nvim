-- OPTIONS
-- To see what an option is set to execute `:lua = vim.o.<name>` -- NOTE: Include : before lua (e.g. type : to start Ex mode, then :lua...)
-- change default copy command to be recursive by default.
vim.g.netrw_localcopydircmd = "cp -r"

vim.o.background = "dark"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.cursorline = true
vim.o.dictionary = "/usr/share/dict/words"
vim.o.expandtab = true -- Neovim will insert spaces when you press the Tab key.
vim.o.foldcolumn = "1"
-- DISABLED FOLDING AS IT JUST WASNT USEFUL
-- vim.o.foldmethod = "indent"                                                                                           -- za to toggle all levels of current fold, zo/zc to open/close current fold, zR to open all folds, zM to close all folds
vim.o.grepprg =
"rg --smart-case --vimgrep --no-heading --follow --multiline --multiline-dotall --hidden --pcre2 --regexp" -- IMPORTANT: pipes should be escaped! e.g. `"text\.(Success\|Info)\("`
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.lazyredraw = true -- (re-enabled when Noice is uninstalled)
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 2           -- Since expandtab is set to true, << or >> will match tabstop and use spaces for indentation, and so each tab press will insert 2 spaces.
-- vim.o.shortmess = vim.o.shortmess .. "c" -- .. is equivalent to += in vimscript
vim.o.shortmess = "filnxToOFc" -- copied default and removed `t` (long paths were being truncated) while adding `c`
vim.o.showmatch = true
vim.o.signcolumn = "auto"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spell = true -- use z= to see suggestions for the correct spelling
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2       -- When expandtab is false (e.g. .editorconfig override), pressing the Tab key will insert a tab character that visually takes up this number of spaces
vim.o.updatetime = 1000 -- affects CursorHold and subsequently things like highlighting Code Actions, and the Noice UI popups.
vim.o.wildmenu = true   -- I disabled blink.cmp in Ex-mode as it wasn't working well enough for me
vim.o.wrap = false

if vim.fn.has("termguicolors") == 1 then vim.o.termguicolors = true end

--[[
vim.o allows you to set global vim options, but not local buffer vim options.
vim.opt has a more expansive API that can handle local and global vim options.
See :h lua-vim-options
]]
vim.opt.colorcolumn = "80"

-- NETRW
--
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/

-- keep the current directory and the browsing directory synced.
-- this helps avoid the "move files" error.
vim.g.netrw_keepdir = 0

-- configure the horizontal split size.
vim.g.netrw_winsize = 30

-- hide the banner (`I` will temporarily display it).
-- vim.g.netrw_banner = 0

-- QUICKFIX

vim.cmd("packadd cfilter")

-- UI

-- LSP UI boxes improvements
--
-- NOTE: Noice plugin can/will override these settings.
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help, { border = "rounded" }
)
vim.diagnostic.config({
	underline = true,
	float = { border = "rounded", style = "minimal" }
})

-- DISABLED: I noticed Telescope had extra border lines.
-- Instead of setting winborder for everything, I need to only set for hover.
-- See K mapping in ./plugins/lsp.lua (local mappings function).
--
-- vim.o.winborder = 'rounded' -- updates LSP Hover window style

-- COMMENTS
-- nvim 0.10.0 has builtin support for commenting
-- :h commenting
-- But doesn't work when remapping with `vim.keymap.set` so we call directly...
-- gc<motion> I'll still use manually
vim.cmd("nmap <leader><leader><leader> gcc")
vim.cmd("vmap <leader><leader><leader> gc")
