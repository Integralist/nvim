return {
  {
    -- DEBUGGING
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader><leader>bc",
        function() require('dap').continue() end,
        desc = "start debugging",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>bx",
        function() require('dap').close() end,
        desc = "stop debugging",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>bo",
        function() require('dap').step_over() end,
        desc = "step over",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>bi",
        function() require('dap').step_into() end,
        desc = "step into",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>bt",
        function() require('dap').step_out() end,
        desc = "step out",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>bb",
        function() require('dap').toggle_breakpoint() end,
        desc = "toggle breakpoint",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>bv",
        function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc = "set breakpoint condition",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>br",
        function() require('dap').repl.open() end,
        desc = "open repl",
        mode = "n",
        noremap = true,
        silent = true
      },
      {
        "<leader><leader>bu",
        function() require('dapui').toggle() end,
        desc = "toggle dap ui",
        mode = "n",
        noremap = true,
        silent = true
      },
    }
  },
  {
    -- Refer to the following help file for REPL commands.
    -- :h dap.repl.open()
    --
    -- REPL Examples:
    -- .n == next
    -- .c == continue
    -- .into == step in
    -- .out == step out
    -- .scopes == print variables
    -- .frames == will show where you are in the program (aka stack trace).
    --
    -- Just typing an expression (e.g. typing a variable name) should evaluate its value.
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = true
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    build = "go install github.com/go-delve/delve/cmd/dlv@latest",
    config = true
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = true
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- TODO: Investigate using `require("mason-registry").get_package("python3"):get_bin_path()`
      -- source ~/.local/share/nvim/mason/packages/debugpy/venv/bin/activate
      -- python3 -m pip install -r requirements.txt
      local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
      require("dap-python").setup(mason_path ..
        "packages/debugpy/venv/bin/python")
      -- https://github.com/mfussenegger/nvim-dap-python/issues/46#issuecomment-1124175484
      require("dap").configurations.python[1].justMyCode = false
    end
  }
}
