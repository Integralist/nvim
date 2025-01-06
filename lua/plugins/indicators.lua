return {
	{
		-- WORD USAGE HIGHLIGHTER
		"RRethy/vim-illuminate"
	},
	{
		-- JUMP TO WORD INDICTORS
		"jinh0/eyeliner.nvim",
		lazy = false,
		opts = { highlight_on_key = true, dim = true }
	},
	{
		-- CURSOR MOVEMENT HIGHLIGHTER
		"DanilaMihailov/beacon.nvim",
		opts = {
			min_jump = 5,
			speed = 10,
		},
	},
	{
		-- HIGHLIGHT YANKED REGION
		"machakann/vim-highlightedyank"
	},
	-- {
	--   "tris203/precognition.nvim",
	--   opts = {
	--     startVisible = true
	--   }
	-- }
}
