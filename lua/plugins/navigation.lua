return function(use)
  use { "nvim-neo-tree/neo-tree.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",
        { text = "", texthl = "DiagnosticSignHint" })

      vim.keymap.set("n", "<leader><Tab>", "<Cmd>Neotree toggle<CR>", { desc = "open file tree" })
      vim.keymap.set("n", "gp", "<Cmd>Neotree reveal_force_cwd<CR>",
        { desc = "change working directory to current file location" })

      if vim.g.colors_name == "gruvbox" then
        vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { fg = "#000000", bg = "#fabd2f" })
      end

      -- Remap :Ex, :Sex to Neotree
      vim.cmd(":command! Ex Neotree toggle current reveal_force_cwd")
      vim.cmd(":command! Sex sp | Neotree toggle current reveal_force_cwd")

      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_by_name = {
              "node_modules"
            },
          },
          hijack_netrw_behavior = "open_current",
        },
      })
    end
  }
end
