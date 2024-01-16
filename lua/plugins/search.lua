return {
  {
    -- SEARCH
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      --[[
          NOTE: Scroll the preview window using <C-d> and <C-u>.

          Opening multiple files isn't a built-in feature of Telescope.
          We can't get that behaviour without a lot of extra config.
          The best we can do is send results to the quickfix window.

          There are two different ways of approaching this:

          1. Filtering files using a search pattern.
          2. Manually selecting files.

          For first scenario just type a search pattern (which will filter the
          list), then press `<C-q>` to send filtered list to quickfix window.

          For the second scenario you would need to:

          - Select multiple files using <Tab>
          - Send the selected files to the quickfix window using <C-o>
          - Search the quickfix window (using either :copen or <leader>q)

          The first approach is fine for simple cases. For example, you want to
          open all Markdown files. You just type `.md` and then `<C-q>`. But if
          you wanted to open specific Markdown files like README.md and HELP.md
          then you'd need the second approach which gives finer-grain control.
        ]]
      local actions = require("telescope.actions")
      local ts = require("telescope")

      ts.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { height = 0.75 },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-o>"] = actions.send_selected_to_qflist
            }
          },
          scroll_strategy = "limit"
        },
        extensions = { heading = { treesitter = true } }
      })

      ts.load_extension("changed_files")
      ts.load_extension("emoji")
      ts.load_extension("fzf")
      ts.load_extension("heading")
      ts.load_extension("ui-select")
      ts.load_extension("windows")

      vim.g.telescope_changed_files_base_branch = "main"

      vim.keymap.set("n", "<leader>b", "<Cmd>Telescope buffers<CR>",
        { desc = "search buffers" })
      vim.keymap.set("n", "<leader>c", "<Cmd>Telescope colorscheme<CR>",
        { desc = "search colorschemes" })
      vim.keymap.set("n", "<leader>d", "<Cmd>TodoTelescope<CR>",
        { desc = "search TODOs across all files" })
      vim.keymap.set("n", "<leader>e", "<Cmd>Telescope commands<CR>",
        { desc = "search Ex commands" })
      vim.keymap.set("n", "<leader>f",
        "<Cmd>Telescope find_files hidden=true<CR>",
        { desc = "search files" })
      vim.keymap.set("n", "<leader>F",
        "<Cmd>Telescope find_files hidden=true cwd=%:h<CR>",
        { desc = "search files in current directory" })
      vim.keymap.set("n", "<leader>g", "<Cmd>Telescope changed_files<CR>",
        { desc = "search changed files" })
      vim.keymap.set("n", "<leader>h", "<Cmd>Telescope help_tags<CR>",
        { desc = "search help" })
      vim.keymap.set("n", "<leader>i", "<Cmd>Telescope builtin<CR>",
        { desc = "search builtins" })
      vim.keymap.set("n", "<leader>j", "<Cmd>Telescope emoji<CR>",
        { desc = "search emojis" })
      vim.keymap.set("n", "<leader>k", "<Cmd>Telescope keymaps<CR>",
        { desc = "search key mappings" })
      vim.keymap.set("n", "<leader>ld", "<Cmd>Telescope diagnostics<CR>",
        { desc = "search lsp diagnostics" })
      vim.keymap.set("n", "<leader>li",
        "<Cmd>Telescope lsp_incoming_calls<CR>",
        { desc = "search lsp incoming calls" })
      vim.keymap.set("n", "<leader>lo",
        "<Cmd>Telescope lsp_outgoing_calls<CR>",
        { desc = "search lsp outgoing calls" })
      vim.keymap.set("n", "<leader>lr",
        "<Cmd>Telescope lsp_references<CR>",
        { desc = "search lsp code reference" })
      vim.keymap.set("n", "<leader>ls",
        "<Cmd>lua require('telescope.builtin').lsp_document_symbols({show_line = true})<CR>",
        { desc = "search lsp document tree" })
      vim.keymap.set("n", "<leader>m", "<Cmd>Telescope heading<CR>",
        { desc = "search markdown headings" })
      vim.keymap.set("n", "<leader>p", "<Cmd>Telescope grep_string<CR>",
        { desc = "search for keyword under cursor" })
      vim.keymap.set("n", "<leader>q", "<Cmd>Telescope quickfix<CR>",
        { desc = "search quickfix list" })
      vim.keymap.set("n", "<leader>r",
        "<Cmd>Telescope current_buffer_fuzzy_find<CR>",
        { desc = "search current buffer text" })
      vim.keymap.set("n", "<leader>s", "<Cmd>Telescope treesitter<CR>",
        { desc = "search treesitter symbols" }) -- similar to lsp_document_symbols but treesitter doesn't know what a 'struct' is, just that it's a 'type'.
      -- vim.keymap.set("n", "<leader>u", "<Cmd>Noice telescope<CR>",
      --   { desc = "search messages handled by Noice plugin" })
      vim.keymap.set("n", "<leader>w", "<Cmd>Telescope windows<CR>",
        { desc = "search windows" })
      vim.keymap.set("n", "<leader>x", "<Cmd>Telescope live_grep<CR>",
        { desc = "search text" })

      -- Remove the Vim builtin colorschemes so they don't show in Telescope.
      vim.cmd("silent !rm $VIMRUNTIME/colors/*.vim &> /dev/null")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function()
          vim.cmd([[setlocal nofoldenable]])
          vim.api.nvim_set_hl(0, "TelescopePromptCounter", { link = "TelescopePromptPrefix" })
        end
      })
    end
  }, {
  -- FZF SORTER FOR TELESCOPE WRITTEN IN C
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make"
}, {
  -- USE TELESCOPE FOR UI ELEMENTS
  "nvim-telescope/telescope-ui-select.nvim",
  config = function() require("telescope").setup({}) end
}, {
  -- SEARCH WINDOWS IN TELESCOPE
  "kyoh86/telescope-windows.nvim"
}, {
  -- SEARCH MARKDOWN HEADINGS IN TELESCOPE
  "crispgm/telescope-heading.nvim"
}, {
  -- SEARCH EMOJIS IN TELESCOPE
  "xiyaowong/telescope-emoji.nvim"
}, {
  -- SEARCH CHANGED GIT FILES IN TELESCOPE
  "axkirillov/telescope-changed-files"
}, {
  -- SEARCH TABS IN TELESCOPE
  "LukasPietzschmann/telescope-tabs",
  config = function()
    vim.keymap.set("n", "<leader>t",
      "<Cmd>lua require('telescope-tabs').list_tabs()<CR>",
      { desc = "search tabs" })
  end
}, {
  -- SEARCH NOTES/TODOS IN TELESCOPE
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup({
      keywords = {
        WARN = {
          icon = " ",
          color = "warning",
          alt = { "WARNING", "XXX", "IMPORTANT" }
        }
      }
    })
  end
}, {
  -- SEARCH INDEXER
  "kevinhwang91/nvim-hlslens",
  config = true
}, {
  -- IMPROVES ASTERISK BEHAVIOR
  "haya14busa/vim-asterisk",
  config = function()
    vim.keymap.set('n', '*',
      [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
      {})
    vim.keymap.set('n', '#',
      [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
      {})
    vim.keymap.set('n', 'g*',
      [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
      {})
    vim.keymap.set('n', 'g#',
      [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
      {})

    vim.keymap.set('x', '*',
      [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
      {})
    vim.keymap.set('x', '#',
      [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
      {})
    vim.keymap.set('x', 'g*',
      [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
      {})
    vim.keymap.set('x', 'g#',
      [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
      {})
  end
}, {
  -- SEARCH AND REPLACE
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("spectre").setup({
      replace_engine = { ["sed"] = { cmd = "gsed" } }
    })
    vim.keymap.set("n", "<leader>S",
      "<Cmd>lua require('spectre').open()<CR>",
      { desc = "search and replace" })
  end
}
}
