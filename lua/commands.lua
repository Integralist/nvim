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

-- Create a Neovim command called 'Grep' that works like normal :grep but prefixes with `silent` option.
-- The silent option prevents Neovim showing a message asking for "ENTER" to be pressed before it opens the quickfix window.
vim.cmd("command! -nargs=* -complete=command Grep silent grep! <args>")

-- Create a Neovim command called 'Messages' that grabs the output from :messages and redirects it to a new vertical split.
-- NOTE: We also use `<q-args>` instead of `<args>` to handle quoting of the input argument.
function ExtractMessages(split)
  vim.cmd('redir @m | silent messages | redir END')
  if split and split == 'vnew' then
    vim.cmd('vnew')
  else
    vim.cmd('new')
  end
  vim.cmd('put! m')
  -- NOTE: If we had executed a single pipeline, then we'd have used `exec 'norm "mp'` rather than `put! m` because it would avoid having to press ENTER after :messages is displayed.
  -- But as we've split the Ex commands over multiple vim.cmd calls it seems `put! m` is fine.
end

-- vim.cmd("command! -nargs=? Messages lua ExtractMessages(<q-args>)")
