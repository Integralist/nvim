-- Define a Lua function to find files matching a glob pattern and populate the quickfix list.
function FindAndPopulateQuickfix(pattern)
    local files = vim.fn.glob(pattern, true, true)
    if #files > 0 then
        local files_list = {}
        for _, v in pairs(files) do
            local t = {}
            t.filename = v
            table.insert(files_list, t)
        end
        vim.fn.setqflist(files_list, "a")
        vim.cmd("copen")
    else
        print("No files found for pattern: " .. pattern)
    end
end

-- Create a Neovim command called 'Find' that accepts one argument (the pattern).
-- e.g. :Find "**/*.lua"
vim.cmd("command! -nargs=1 Find lua FindAndPopulateQuickfix(<args>)")
