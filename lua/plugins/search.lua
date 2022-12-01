return function(use)
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      --[[
          Opening mulitple files doesn't work by default.

          You can either following the implementation detailed here:
          https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1220846367

          Or you can have a more complex workflow:
          - Select multiple files using <Tab>
          - Send the selected files to the quickfix window using <C-o>
          - Search the quickfix window (using either :copen or <leader>q)

          NOTE: Scroll the preview window using <C-d> and <C-u>.
        ]]
      local actions = require("telescope.actions")
      local ts = require("telescope")

      ts.setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-o>"] = actions.send_selected_to_qflist,
            },
          },
        },
        extensions = {
          heading = {
            treesitter = true,
          },
        },
      })

      ts.load_extension("changed_files")
      ts.load_extension("emoji")
      ts.load_extension("fzf")
      ts.load_extension("heading")
      ts.load_extension("ui-select")
      ts.load_extension("windows")

      vim.g.telescope_changed_files_base_branch = "main"

      vim.keymap.set("n", "<leader>b", "<Cmd>Telescope buffers<CR>", { desc = "search buffers" })
      vim.keymap.set("n", "<leader>c", "<Cmd>Telescope colorscheme<CR>", { desc = "search colorschemes" })
      vim.keymap.set("n", "<leader>d", "<Cmd>TodoTelescope<CR>", { desc = "search TODOs" })
      vim.keymap.set("n", "<leader>ej", "<Cmd>Telescope emoji<CR>", { desc = "search emojis" })
      vim.keymap.set("n", "<leader>ex", "<Cmd>Telescope commands<CR>", { desc = "search Ex commands" })
      vim.keymap.set("n", "<leader>f", "<Cmd>Telescope find_files hidden=true<CR>", { desc = "search files" })
      vim.keymap.set("n", "<leader>g", "<Cmd>Telescope changed_files<CR>", { desc = "search changed files" })
      vim.keymap.set("n", "<leader>h", "<Cmd>Telescope help_tags<CR>", { desc = "search help" })
      vim.keymap.set("n", "<leader>i", "<Cmd>Telescope builtin<CR>", { desc = "search builtins" })
      vim.keymap.set("n", "<leader>k", "<Cmd>Telescope keymaps<CR>", { desc = "search key mappings" })
      vim.keymap.set("n", "<leader>ld", "<Cmd>Telescope diagnostics<CR>", { desc = "search lsp diagnostics" })
      vim.keymap.set("n", "<leader>li", "<Cmd>Telescope lsp_incoming_calls<CR>", { desc = "search lsp incoming calls" })
      vim.keymap.set("n", "<leader>lo", "<Cmd>Telescope lsp_outgoing_calls<CR>", { desc = "search lsp outgoing calls" })
      vim.keymap.set("n", "<leader>lr", "<Cmd>Telescope lsp_references<CR>", { desc = "search lsp code reference" })
      vim.keymap.set("n", "<leader>ls", "<Cmd>Telescope lsp_document_symbols<CR>",
        { desc = "search lsp document tree" })
      vim.keymap.set("n", "<leader>m", "<Cmd>Telescope heading<CR>", { desc = "search markdown headings" })
      vim.keymap.set("n", "<leader>n", "<Cmd>Noice telescope<CR>", { desc = "search messages handled by Noice plugin" })
      vim.keymap.set("n", "<leader>q", "<Cmd>Telescope quickfix<CR>", { desc = "search quickfix list" })
      vim.keymap.set("n", "<leader>r", "<Cmd>Telescope current_buffer_fuzzy_find<CR>",
        { desc = "search current buffer text" })
      vim.keymap.set("n", "<leader>s", "<Cmd>Telescope treesitter<CR>", { desc = "search treesitter symbols" }) -- similar to lsp_document_symbols but treesitter doesn't know what a 'struct' is, just that it's a 'type'.
      vim.keymap.set("n", "<leader>w", "<Cmd>Telescope windows<CR>", { desc = "search windows" })
      vim.keymap.set("n", "<leader>x", "<Cmd>Telescope live_grep<CR>", { desc = "search text" })
    end
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use { "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({})
    end
  }
  use "kyoh86/telescope-windows.nvim"
  use "crispgm/telescope-heading.nvim"
  use "xiyaowong/telescope-emoji.nvim"
  use "axkirillov/telescope-changed-files"
  use { "LukasPietzschmann/telescope-tabs",
    config = function()
      vim.keymap.set("n", "<leader>t", "<Cmd>lua require('telescope-tabs').list_tabs()<CR>", { desc = "search tabs" })
    end
  }

  -- surface any TODO or NOTE code references
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  }

  -- pattern searching
  use {
    "mileszs/ack.vim",
    config = function()
      vim.g.ackprg = "rg --vimgrep --smart-case --hidden"
    end
  }

  -- search indexer
  use { "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
    end
  }
  use { "haya14busa/vim-asterisk",
    config = function()
      vim.api.nvim_set_keymap('n', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('n', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

      vim.api.nvim_set_keymap('x', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('x', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
    end
  }

  -- search and replace
  use {
    "nvim-pack/nvim-spectre",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup({
        replace_engine = {
          ["sed"] = {
            cmd = "gsed",
          },
        },
      })
      vim.keymap.set("n", "<leader>S", "<Cmd>lua require('spectre').open()<CR>", { desc = "search and replace" })
    end
  }
end
