return function(use)
  use {
    "mfussenegger/nvim-dap",
    config = function()
      vim.keymap.set("n", "<leader><leader>dc", "<Cmd>lua require('dap').continue()<CR>", { desc = "start debugging" })
      vim.keymap.set("n", "<leader><leader>do", "<Cmd>lua require('dap').step_over()<CR>", { desc = "step over" })
      vim.keymap.set("n", "<leader><leader>di", "<Cmd>lua require('dap').step_into()<CR>", { desc = "step into" })
      vim.keymap.set("n", "<leader><leader>dt", "<Cmd>lua require('dap').step_out()<CR>", { desc = "step out" })
      vim.keymap.set("n", "<leader><leader>db", "<Cmd>lua require('dap').toggle_breakpoint()<CR>",
        { desc = "toggle breakpoint" })
      vim.keymap.set("n", "<leader><leader>dv",
        "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        { desc = "toggle breakpoint" })
      vim.keymap.set("n", "<leader><leader>dr", "<Cmd>lua require('dap').repl.open()<CR>", { desc = "open repl" })
      vim.keymap.set("n", "<leader><leader>du", "<Cmd>lua require('dapui').toggle()<CR>", { desc = "toggle dap ui" })
    end
  }
  use { "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end
  }
  use { "leoluz/nvim-dap-go",
    requires = { "mfussenegger/nvim-dap" },
    run = "go install github.com/go-delve/delve/cmd/dlv@latest",
    config = function()
      require("dap-go").setup()
    end
  }
  use { "theHamsta/nvim-dap-virtual-text",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }
end
