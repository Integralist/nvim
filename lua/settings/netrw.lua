-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/

-- keep the current directory and the browsing directory synced.
-- this helps avoid the "move files" error.
vim.g.netrw_keepdir = 0

-- configure the horizontal split size.
vim.g.netrw_winsize = 30

-- hide the banner (`I` will temporarily display it).
-- vim.g.netrw_banner = 0

-- change default copy command to be recursive by default.
vim.g.netrw_localcopydircmd = "cp -r"
