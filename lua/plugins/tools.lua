return {
	{
		"neo451/feed.nvim",
		cmd = "Feed",
		build = "brew install pandoc", -- required for using plugin
		opts = {
			feeds = {
				{
					"https://www.opensrsstatus.com/history.rss",
					name = "OpenSRS Status",
					tags = { "domains", "maintenance" }
				},
				{
					"ghostty-org/ghostty",
					name = "Ghostty",
					tags = { "terminal" }
				}
			}
		}
	}
}
