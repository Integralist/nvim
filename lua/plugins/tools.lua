return {
	{
		"neo451/feed.nvim",
		cmd = "Feed",
		build = "brew install pandoc", -- required for using plugin
		dependencies = {
			{ "j-hui/fidget.nvim", lazy = true },
		},
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
					tags = { "terminal", "repo" }
				},
				{
					"https://ziglang.org/news/index.xml",
					name = "Zig",
					tags = { "PL" }
				},
				{
					"https://open-web-advocacy.org/feed.xml",
					name = "Open Web Advocacy",
					tags = { "Web" }
				}
			}
		}
	}
}
