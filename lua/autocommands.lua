-- always open quickfix window automatically.
-- this uses cwindows which will open it only if there are entries.
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = vim.api.nvim_create_augroup("AutoOpenQuickfix", { clear = true }),
	pattern = { "[^l]*" },
	command = "cwindow"
})

-- NOTE: The following forces my settings over a local editorconfig.
-- Some projects I work on have a local editorconfig with much larger width.
-- It really bothers me so I force this override.
--
-- BufWinEnter fires later than FileType, ensuring it runs after EditorConfig.
-- vim.schedule defers execution slightly, making sure it's the final override.
-- vim.opt_local.textwidth = 80 is the Lua equivalent of setlocal textwidth=80.
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.sh", "*.go", "*.rs", "*.md" },
	callback = function()
		vim.schedule(function()
			vim.opt_local.textwidth = 80
		end)
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.mdx" },
	command = "set filetype=markdown"
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- vim.cmd("highlight BufDimText guibg='NONE' guifg=darkgrey guisp=darkgrey gui='NONE'")

		-- vim-illuminate (highlights every instance of word under the cursor)
		vim.api.nvim_set_hl(0, "illuminatedWord",
			{ fg = "#063970", bg = "#76b5c5" })
		vim.api.nvim_set_hl(0, "LspReferenceText",
			{ fg = "#063970", bg = "#76b5c5" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite",
			{ fg = "#063970", bg = "#76b5c5" })
		vim.api.nvim_set_hl(0, "LspReferenceRead",
			{ fg = "#063970", bg = "#76b5c5" })

		-- eyeliner
		vim.api.nvim_set_hl(0, 'EyelinerPrimary',
			{ fg = "#FF0000", bold = true, underline = true })
		vim.api.nvim_set_hl(0, 'EyelinerSecondary',
			{ fg = "#FFFF00", underline = true })
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("WrapLineInMarkdown", { clear = true }),
	pattern = { "markdown" },
	command = "setlocal wrap"
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = vim.api.nvim_create_augroup("ScrollbarHandleHighlight",
		{ clear = true }),
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "ScrollbarHandle",
			{ fg = "#ff0000", bg = "#8ec07c" })
	end
})

vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
	group = vim.api.nvim_create_augroup("AutoSaveFolds", { clear = true }),
	pattern = { "markdown" },
	callback = function(args)
		if vim.b[args.buf].view_activated then
			vim.cmd.mkview { mods = { emsg_silent = true } }
		end
	end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("AutoLoadFolds", { clear = true }),
	pattern = { "markdown" },
	callback = function(args)
		if not vim.b[args.buf].view_activated then
			local filetype = vim.api.nvim_get_option_value("filetype",
				{ buf = args.buf })
			local buftype = vim.api.nvim_get_option_value("buftype",
				{ buf = args.buf })
			local ignore_filetypes = {
				"gitcommit", "gitrebase", "svg", "hgcommit"
			}
			if buftype == "" and filetype and filetype ~= "" and
					not vim.tbl_contains(ignore_filetypes, filetype) then
				vim.b[args.buf].view_activated = true
				vim.cmd.loadview { mods = { emsg_silent = true } }
			end
		end
	end
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "Jenkinsfile" },
	command = "set filetype=groovy"
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("GoFumpt",
		{ clear = true }),
	pattern = "*.go",
	-- callback = function(event)
	--   local file_name = vim.fn.bufname(event.buf)
	--   print("about to gofumpt file: " .. file_name)
	--   vim.cmd('silent !gofumpt -w ' .. file_name)
	-- end,
	command = "silent !gofumpt -w %"
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("GoImports",
		{ clear = true }),
	pattern = "*.go",
	command = "silent !goimports -w %"
})

-- Dim inactive windows

vim.cmd("highlight default DimInactiveWindows guifg=#666666")

local exclude_filetypes = { "neo-tree", "trouble", "Outline", "qf" }

-- Check if the current window should be excluded
local function should_exclude()
	local filetype = vim.bo.filetype
	for _, ft in ipairs(exclude_filetypes) do
		if ft == filetype then
			return true
		end
	end
	return false
end

-- When leaving a window, set all highlight groups to a "dimmed" hl_group
vim.api.nvim_create_autocmd({ "WinLeave" }, {
	callback = function()
		if should_exclude() then return end
		local highlights = {}
		for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
			table.insert(highlights, hl .. ":DimInactiveWindows")
		end
		vim.wo.winhighlight = table.concat(highlights, ",")
	end,
})

-- When entering a window, restore all highlight groups to original
vim.api.nvim_create_autocmd({ "WinEnter" }, {
	callback = function()
		vim.wo.winhighlight = ""
	end,
})
