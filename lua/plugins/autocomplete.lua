return function(use)
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<Left>"] = cmp.mapping.select_prev_item(),
          ["<Right>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        },
        sources = cmp.config.sources({
          -- ordered by priority
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "nvim_lua" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(), -- Tab for selection (arrows needed for selecting past items)
        sources = {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline({ ":" }, {
        mapping = cmp.mapping.preset.cmdline(), -- Tab for selection (arrows needed for selecting past items)
        sources = {
          { name = "cmdline" },
          { name = "path" }
        }
      })
    end
  }
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "hrsh7th/cmp-path"
  use {
    "L3MON4D3/LuaSnip",
    requires = { "saadparwaiz1/cmp_luasnip" },
    config = function()
      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      keymap("i", "<leader><leader>'", "<cmd>lua require('luasnip').jump(1)<CR>", opts)
      keymap("i", "<leader><leader>;", "<cmd>lua require('luasnip').jump(-1)<CR>", opts)
      require("luasnip.loaders.from_lua").load({ paths = "~/.snippets" })
    end
  }
end
