return function(use)
  -- git change indicator
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GruvboxYellowSign" })

      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { desc = "next change hunk", expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { desc = "prev change hunk", expr = true })

          map('n', '<leader><leader>gb', function()
            gs.blame_line { full = true }
          end, { desc = "git blame" })

          map('n', '<leader><leader>gs', function()
            gs.blame_line {}
          end, { desc = "git blame short" })

          map('n', '<leader><leader>gd', gs.diffthis, { desc = "git diff (:q to close)" })
        end
      })
    end
  }

  -- git history
  use {
    "sindrets/diffview.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup()
      vim.keymap.set("n", "<leader><leader>gh", "<Cmd>DiffviewFileHistory<CR>", { desc = "diff history" })
      vim.keymap.set("n", "<leader><leader>go", "<Cmd>DiffviewOpen<CR>", { desc = "diff open" })
      vim.keymap.set("n", "<leader><leader>gc", "<Cmd>DiffviewClose<CR>", { desc = "diff close" })
    end
  }

  -- open lines in github
  use {
    "ruanyl/vim-gh-line",
    config = function()
      vim.g.gh_line_map = "<leader><leader>gl"
    end
  }
end
