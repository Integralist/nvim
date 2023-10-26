return {
  {
    -- TERMINAL
    "akinsho/toggleterm.nvim",
    version = "v2.*",
    config = function()
      require("toggleterm").setup()

      local Terminal = require('toggleterm.terminal').Terminal
      local htop = Terminal:new({
        cmd = "htop",
        hidden = true,
        direction = "float"
      })

      -- NOTE: This is a global function so it can be called from the below mapping.
      function Htop_toggle() htop:toggle() end

      vim.keymap.set("n", "<leader><leader>th",
        "<cmd>lua Htop_toggle()<CR>", {
          noremap = true,
          silent = true,
          desc = "toggle htop"
        })

      vim.keymap.set("n", "<leader><leader>tf",
        "<Cmd>ToggleTerm direction=float<CR>",
        { desc = "toggle floating terminal" })
    end
  }
}
