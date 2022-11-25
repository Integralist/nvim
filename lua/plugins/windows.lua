return function(use)
  -- window picker
  use { "s1n7ax/nvim-window-picker", tag = "v1.*",
    config = function()
      local picker = require("window-picker")
      picker.setup({
        fg_color = "#000000",
      })

      vim.keymap.set("n", "<leader><leader>w", function()
        local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = "Pick a window" })
    end,
  }

  -- window zoom (avoids layout reset from <Ctrl-w>=)
  -- Caveat: NeoZoom doesn't play well with workflows that use the quickfix window.
  use { "nyngwang/NeoZoom.lua",
    config = function()
      require('neo-zoom').setup({
        left_ratio = 0.2,
        top_ratio = 0,
        width_ratio = 0.6,
        height_ration = 1,
      })
      vim.keymap.set("", "<leader><leader>z", "<Cmd>NeoZoomToggle<CR>", { desc = "full screen active window" })
    end
  }
  -- windows.nvim is more like the traditional <Ctrl-w>_ and <Ctrl-w>|
  use { "anuvyklack/windows.nvim",
    requires = {
      "anuvyklack/middleclass",
    },
    config = function()
      vim.o.winwidth = 1
      vim.o.winminwidth = 0
      vim.o.equalalways = false
      require("windows").setup({
        autowidth = {
          enable = false, -- prevents messing up simrat39/symbols-outline.nvim (e.g. relative width of side-bar was being made larger)
        }
      })

      local function cmd(command)
        return table.concat({ "<Cmd>", command, "<CR>" })
      end

      vim.keymap.set("n", "<C-w>\\", cmd "WindowsMaximize")
      vim.keymap.set("n", "<C-w>_", cmd "WindowsMaximizeVertically")
      vim.keymap.set("n", "<C-w>|", cmd "WindowsMaximizeHorizontally")
      vim.keymap.set("n", "<C-w>=", cmd "WindowsEqualize")
    end
  }
end
