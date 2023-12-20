return {
    {
        -- DEBUGGING
        "mfussenegger/nvim-dap",
        config = function()
            vim.keymap.set("n", "<leader><leader>bc",
                           "<Cmd>lua require('dap').continue()<CR>",
                           {desc = "start debugging"})
            vim.keymap.set("n", "<leader><leader>bx",
                           "<Cmd>lua require('dap').close()<CR>",
                           {desc = "stop debugging"})
            vim.keymap.set("n", "<leader><leader>bo",
                           "<Cmd>lua require('dap').step_over()<CR>",
                           {desc = "step over"})
            vim.keymap.set("n", "<leader><leader>bi",
                           "<Cmd>lua require('dap').step_into()<CR>",
                           {desc = "step into"})
            vim.keymap.set("n", "<leader><leader>bt",
                           "<Cmd>lua require('dap').step_out()<CR>",
                           {desc = "step out"})
            vim.keymap.set("n", "<leader><leader>bb",
                           "<Cmd>lua require('dap').toggle_breakpoint()<CR>",
                           {desc = "toggle breakpoint"})
            vim.keymap.set("n", "<leader><leader>bv",
                           "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                           {desc = "toggle breakpoint"})
            vim.keymap.set("n", "<leader><leader>br",
                           "<Cmd>lua require('dap').repl.open()<CR>",
                           {desc = "open repl"})
            vim.keymap.set("n", "<leader><leader>bu",
                           "<Cmd>lua require('dapui').toggle()<CR>",
                           {desc = "toggle dap ui"})
        end
    }, {
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
        dependencies = {"mfussenegger/nvim-dap"},
        config = true
    }, {
        "leoluz/nvim-dap-go",
        dependencies = {"mfussenegger/nvim-dap"},
        build = "go install github.com/go-delve/delve/cmd/dlv@latest",
        config = true
    }, {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {"mfussenegger/nvim-dap"},
        config = true
    }, {
        "mfussenegger/nvim-dap-python",
        dependencies = {"mfussenegger/nvim-dap"},
        config = function()
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
