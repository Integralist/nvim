return function(use)
  -- syntax tree parsing for more intelligent syntax highlighting and code navigation
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "bash", "c", "cmake", "css", "dockerfile", "go", "gomod", "gowork", "hcl", "help", "html",
          "http", "javascript", "json", "lua", "make", "markdown", "python", "regex", "ruby", "rust", "toml", "vim",
          "yaml", "zig" },
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        }
      })
    end
  }
  use { "nvim-treesitter/nvim-treesitter-textobjects",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- start treesitter selection process
            scope_incremental = "gnm", -- increment selection to surrounding scope
            node_incremental = ";", -- increment selection to next 'node'
            node_decremental = ",", -- decrement selection to prev 'node'
          },
        },
        indent = {
          enable = true
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = false,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "select around a function" },
              ["if"] = { query = "@function.inner", desc = "select inner part of a function" },
              ["ac"] = { query = "@class.outer", desc = "select around a class" },
              ["ic"] = { query = "@class.inner", desc = "select inner part of a class" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]]"] = "@function.outer",
              ["]\\"] = "@class.outer",
            },
            goto_previous_start = {
              ["[["] = "@function.outer",
              ["[\\"] = "@class.outer",
            },
          },
        },
      })
    end
  }
  use { "lewis6991/spellsitter.nvim",
    config = function()
      require("spellsitter").setup()
    end
  }
  use { "m-demare/hlargs.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("hlargs").setup()
    end
  }
  use { "nvim-treesitter/nvim-treesitter-context", requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("treesitter-context").setup({
        separator = "-",
      })
    end
  } -- buffer scroll context
end
