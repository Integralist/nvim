-- OPTIONS
-- To see what an option is set to execute `:lua = vim.o.<name>` -- NOTE: Include : before lua (e.g. type : to start Ex mode, then :lua...)
-- change default copy command to be recursive by default.
vim.g.netrw_localcopydircmd = "cp -r"

vim.o.background = "dark"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.cursorline = true
vim.o.dictionary = "/usr/share/dict/words"
vim.o.expandtab = true
vim.o.grepprg =
    "rg --smart-case --vimgrep --no-heading --follow --multiline-dotall --hidden --pcre2 --regexp" -- IMPORTANT: pipes should be escaped! e.g. `"text\.(Success\|Info)\("`
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.lazyredraw = true -- (re-enabled when Noice is uninstalled)
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 2
-- vim.o.shortmess = vim.o.shortmess .. "c" -- .. is equivalent to += in vimscript
vim.o.shortmess = "filnxToOFc" -- copied default and removed `t` (long paths were being truncated) while adding `c`
vim.o.showmatch = true
vim.o.signcolumn = "auto"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spell = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.updatetime = 1000 -- affects CursorHold and subsequently things like highlighting Code Actions, and the Noice UI popups.
vim.o.wrap = false

if vim.fn.has("termguicolors") == 1 then vim.o.termguicolors = true end

--[[
vim.o allows you to set global vim options, but not local buffer vim options.
vim.opt has a more expansive API that can handle local and global vim options.
See :h lua-vim-options
]]
vim.opt.colorcolumn = "80"

-- NETRW
--
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/

-- keep the current directory and the browsing directory synced.
-- this helps avoid the "move files" error.
vim.g.netrw_keepdir = 0

-- configure the horizontal split size.
vim.g.netrw_winsize = 30

-- hide the banner (`I` will temporarily display it).
-- vim.g.netrw_banner = 0

-- QUICKFIX

vim.cmd("packadd cfilter")

-- UI

-- LSP UI boxes improvements
--
-- NOTE: Noice plugin will override these settings.
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
vim.diagnostic.config({
    underline = true,
    float = {border = "rounded", style = "minimal"}
})

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
               {desc = "sort quickfix window"})

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
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
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

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
