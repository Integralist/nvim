return {
	{
		'hat0uma/csvview.nvim',
		config = function()
			local csvview = require('csvview')
			csvview.setup({
				view = {
					display_mode = "border",
				}
			})

			-- Run the plugin once a CSV file is loaded.
			-- NOTE: You can fake a frozen header row with a `:sp` and on the top pane do `ctrl-w1_` to make it 1 line high
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "csv",
				callback = function()
					csvview.toggle()
				end,
			})
		end
	}
}
