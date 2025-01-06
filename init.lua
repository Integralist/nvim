-- Bootstrap lazy.nvim
-- :h standard-path (~/.local/share/nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy package manager:
-- https://lazy.folke.io/configuration
--
-- Configuring plugins:
-- https://lazy.folke.io/spec
--
require("lazy").setup({
	checker = {
		enabled = true,
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
require("highlights")
