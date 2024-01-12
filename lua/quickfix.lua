vim.keymap.set("n", "<leader><leader>da", "<Cmd>TodoQuickFix<CR>",
  { desc = "open all TODOs in QuickFix window" })

vim.keymap.set("n", "<leader><leader>dc",
  "<Cmd>exe ':TodoQuickFix cwd=' .. fnameescape(expand('%:p'))<CR>",
  { desc = "open TODOs for current file in QuickFix window" })

function _G.jumpToQuickfix()
  local jumplist, _ = unpack(vim.fn.getjumplist())
  local qf_list = {}
  for _, v in pairs(jumplist) do
    if vim.fn.bufloaded(v.bufnr) == 1 then
      table.insert(qf_list, {
        bufnr = v.bufnr,
        lnum = v.lnum,
        col = v.col,
        text = vim.api.nvim_buf_get_lines(v.bufnr, v.lnum - 1, v.lnum,
          false)[1]
      })
    end
  end
  vim.fn.setqflist(qf_list, " ")
  vim.cmd("copen")
end

vim.keymap.set("", "<leader><leader>qj", "<Cmd>lua _G.jumpToQuickfix()<CR>",
  { desc = "populate quickfix with jumplist" })

vim.keymap.set("n", "<leader><leader>qd", function()
  vim.diagnostic.setqflist({
    open = true,
    title = "Diagnostics",
    severity = { min = vim.diagnostic.severity.HINT }
  })
end, { desc = "populate quickfix with diagnostics" })

-- Configure the UI aspect of the quickfix window
-- NOTE: See https://github.com/kevinhwang91/nvim-bqf#customize-quickfix-window-easter-egg and ~/.config/nvim/syntax/qf.vim
local fn = vim.fn

-- QUICKFIX RESULTS SORTER
-- :lua _G.qfSort()
function _G.qfSort()
  local items = fn.getqflist()
  table.sort(items, function(a, b)
    if a.bufnr == b.bufnr then
      if a.lnum == b.lnum then
        return a.col < b.col
      else
        return a.lnum < b.lnum
      end
    else
      return a.bufnr < b.bufnr
    end
  end)
  fn.setqflist(items, 'r')
end

vim.keymap.set("", "<leader><leader>qs", "<Cmd>lua _G.qfSort()<CR>",
  { desc = "sort quickfix window" })

-- This will align the quickfix window list.
function _G.qftf(info)
  local items
  local ret = {}
  -- The name of item in list is based on the directory of quickfix window.
  -- Change the directory for quickfix window make the name of item shorter.
  -- It's a good opportunity to change current directory in quickfixtextfunc :)
  --
  -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
  -- local root = getRootByAlterBufnr(alterBufnr)
  -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
  --
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 50
  local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's',
      '…%.' .. (limit - 1) .. 's'
  local validFmt = '%s │%5d:%-3d│%s %s'
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

-- :h quickfixtextfunc
-- NOTE: This helps align the columns in the quickfix window.
vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
