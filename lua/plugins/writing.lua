return {
  {
    -- WRITING
    "marcelofern/vale.nvim",
    config = function()
      require("vale").setup({
        bin = "/usr/local/bin/vale",
        vale_config_path = "$HOME/.vale.ini"
      })
    end
  }
}
