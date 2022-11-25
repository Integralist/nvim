--[[
The configuration in this file should automatically install packer.nvim for you.

To update the configured packages (see below), execute the :PackerSync command.

Plugins will be compiled into:
/Users/integralist/.local/share/nvim/site/pack/packer/start

The ~/.config/nvim/plugin directory contains my own configuration files + the compiled package plugin.

NOTE: The plugin mappings defined have the following convention:

* Single <leader> for search operations (inc. file explorer + search/replace)
* Double <leader> for all other mappings

This helps to avoid overlap in letters.
--]]

-- The following configuration ensures that when we clone these dotfiles to a
-- new laptop, that they'll continue to work without any manual intervention.
-- Check the bottom of the .startup() function for our call to packer_bootstrap.
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

return require("packer").startup({
  function()
    -- plugin manager
    use "wbthomason/packer.nvim"

    -- icons used by many plugins
    use "nvim-tree/nvim-web-devicons"
    use {
      "DaikyXendo/nvim-material-icon",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
        if not web_devicons_ok then
          return
        end

        local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
        if not material_icon_ok then
          return
        end

        web_devicons.setup({
          override = material_icon.get_icons(),
        })

        require("nvim-material-icon").setup()
      end
    } -- replacement for nvim-web-devicons

    -- The following code loads our plugins based on their category group (e.g. autocomplete, lsp, search etc).
    local plugins = vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true)
    for _, abspath in ipairs(plugins) do
      for _, filename in ipairs(vim.split(abspath, "/lua/", { trimempty = true })) do
        if vim.endswith(filename, ".lua") and not vim.endswith(filename, "init.lua") then
          for _, name in ipairs(vim.split(filename, "[.]lua", { trimempty = true })) do
            require(name)(use)
          end
        end
      end
    end

    -- automatically set up your configuration after cloning packer.nvim
    -- put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    git = {
      clone_timeout = 120
    }
  }
})
