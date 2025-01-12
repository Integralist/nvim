return {
	Array         = "󰅪 ",
	Boolean       = "◩ ",
	Class         = "𝓒 ", -- 󰌗
	Constant      = "󰏿 ",
	Constructor   = " ",
	Enum          = "ℰ", -- 󰕘
	EnumMember    = " ",
	Event         = " ", -- 
	Field         = " ", --  
	File          = " ", -- 󰈙
	Function      = "󰊕 ",
	Interface     = "", -- 󰕘
	Key           = "󰌋 ",
	Method        = " ", -- 󰆧
	Module        = "󰆧 ", --  
	Namespace     = "󰌗 ",
	Null          = " ", -- 󰟢
	Number        = "# ", -- 󰎠
	Object        = " ", -- 󰅩
	Operator      = "󰆕 ",
	Package       = " ", -- 
	Property      = " ", -- 
	String        = "𝓢 ", -- 
	Struct        = " ", -- 󰌗
	TypeParameter = "󰊄 ",
	Variable      = "", -- 󰆧 
}

-- :NvimWebDeviconsHiTest

-- hedyhli/outline.nvim
-- Array = { icon = '󰅪', hl = 'Constant' },
-- Boolean = { icon = '◩', hl = 'Boolean' }, -- ⊨ 
-- Class = { icon = '𝓒', hl = 'Type' },
-- Component = { icon = '󰅴', hl = 'Function' },
-- Constant = { icon = '󰏿', hl = 'Constant' }, -- 
-- Constructor = { icon = '', hl = 'Special' }, -- 
-- Enum = { icon = 'ℰ', hl = 'Type' },
-- EnumMember = { icon = '', hl = 'Identifier' },
-- Event = { icon = '', hl = 'Type' }, -- 🗲
-- Field = { icon = '', hl = 'Identifier' }, -- 󰆨 
-- File = { icon = '', hl = 'Identifier' }, -- 󰈔
-- Fragment = { icon = '󰅴', hl = 'Constant' },
-- Function = { icon = 'ƒ', hl = 'Function' }, -- 
-- Interface = { icon = '', hl = 'Type' }, -- 󰜰
-- Key = { icon = '󰌋', hl = 'Type' }, -- 🔐
-- Macro = { icon = ' ', hl = 'Function' },
-- Method = { icon = '', hl = 'Function' }, -- ƒ ➡️
-- Module = { icon = '', hl = 'Include' }, -- 󰆧 (changed because yaml considers an object a module)
-- Namespace = { icon = '󰌗', hl = 'Include' }, -- 󰅪
-- Null = { icon = '', hl = 'Type' }, -- NULL
-- Number = { icon = '#', hl = 'Number' },
-- Object = { icon = '', hl = 'Type' }, -- ⦿
-- Operator = { icon = '󰆕', hl = 'Identifier' }, -- + 
-- Package = { icon = '', hl = 'Include' }, -- 󰏗
-- Parameter = { icon = ' ', hl = 'Identifier' },
-- Property = { icon = '', hl = 'Identifier' },
-- StaticMethod = { icon = ' ', hl = 'Function' }, -- 
-- String = { icon = '𝓢', hl = 'String' }, -- 𝓐
-- Struct = { icon = '', hl = 'Structure' }, -- 𝓢
-- TypeAlias = { icon = ' ', hl = 'Type' }, -- 
-- TypeParameter = { icon = '󰊄', hl = 'Identifier' }, -- 𝙏
-- Variable = { icon = '', hl = 'Constant' }, -- 

-- SmiteshP/nvim-navic
-- Array = "",
-- Boolean = "◩", -- 
-- Class = "𝓒", -- 
-- Constant = "󰏿", --  
-- Constructor = "", --  
-- Enum = "ℰ", -- 
-- EnumMember = "", -- 
-- Event = "",
-- Field = "", --  
-- File = "",
-- Function = "ƒ", -- 
-- Interface = "",
-- Key = "󰌋", -- 
-- Method = "", -- 
-- Module = "󰆧", -- 
-- Namespace = "󰌗", --  󰅪
-- Null = "",
-- Number = "#", -- 
-- Object = "",
-- Operator = "󰆕", -- 
-- Package = "",
-- Property = "", -- 
-- String = "𝓢", -- 
-- Struct = "", -- 
-- TypeParameter = "󰊄", --  𝙏
-- Variable = "", --  

-- utilyre/barbecue.nvim
-- Array = "",
-- Boolean = "◩", -- 
-- Class = "𝓒", -- 
-- Constant = "󰏿", --  
-- Constructor = "", --  
-- Enum = "ℰ", -- 
-- EnumMember = "", -- 
-- Event = "",
-- Field = "", --  
-- File = "",
-- Function = "ƒ", -- 
-- Interface = "",
-- Key = "󰌋", -- 
-- Method = "", -- 
-- Module = "󰆧", -- 
-- Namespace = "󰌗", --  󰅪
-- Null = "",
-- Number = "#", -- 
-- Object = "",
-- Operator = "󰆕", -- 
-- Package = "",
-- Property = "", -- 
-- String = "𝓢", -- 
-- Struct = "", -- 
-- TypeParameter = "󰊄", --  𝙏
-- Variable = "", --  

-- SmiteshP/nvim-navbuddy
-- Array         = "󰅪 ",
-- Boolean       = "◩ ",
-- Class         = "𝓒 ", -- 󰌗
-- Constant      = "󰏿 ",
-- Constructor   = " ",
-- Enum          = "ℰ", -- 󰕘
-- EnumMember    = " ",
-- Event         = " ", -- 
-- Field         = " ", --  
-- File          = " ", -- 󰈙
-- Function      = "󰊕 ",
-- Interface     = "", -- 󰕘
-- Key           = "󰌋 ",
-- Method        = " ", -- 󰆧
-- Module        = " ", --  󰆧 (changed because yaml considers an object a module)
-- Namespace     = "󰌗 ",
-- Null          = " ", -- 󰟢
-- Number        = "# ", -- 󰎠
-- Object        = " ", -- 󰅩
-- Operator      = "󰆕 ",
-- Package       = " ", -- 
-- Property      = " ", -- 
-- String        = "𝓢 ", -- 
-- Struct        = " ", -- 󰌗
-- TypeParameter = "󰊄 ",
-- Variable      = "", -- 󰆧 

-- diagnostics = {
--       Error = ' ',
--       Hint = '󰌵 ',
--       Information = ' ',
--       Question = ' ',
--       Warning = ' ',
--   },
--   documents = {
--       File = ' ',
--       FileEmpty = ' ',
--       Files = ' ',
--       Folder = ' ',
--       FolderEmpty = ' ',
--       OpenFolder = ' ',
--       OpenFolderEmpty = ' ',
--       SymLink = ' ',
--       SymlinkFolder = ' ',
--       Import = ' ',
--   },
--   git = {
--       Add = ' ',
--       AddAlt = ' ',
--       Branch = ' ',
--       Diff = ' ',
--       DiffAlt = ' ',
--       Ignore = '◌ ',
--       Mod = ' ',
--       Octoface = ' ',
--       Remove = ' ',
--       RemoveAlt = ' ',
--       Rename = ' ',
--       Repo = ' ',
--       Tag = ' ',
--       Untrack = ' ',
--   },
--   kind = {
--       Class = ' ',
--       Color = ' ',
--       Constant = ' ',
--       Constructor = '󰈏 ',
--       Enum = ' ',
--       EnumMember = ' ',
--       Event = ' ',
--       Field = ' ',
--       File = ' ',
--       Folder = ' ',
--       Function = '󰊕 ',
--       Interface = ' ',
--       Keyword = ' ',
--       Method = ' ',
--       Module = '',
--       Operator = ' ',
--       Property = ' ',
--       Reference = ' ',
--       Snippet = ' ',
--       Struct = ' ',
--       Text = ' ',
--       TypeParameter = ' ',
--       Unit = ' ',
--       Value = ' ',
--       Variable = ' ',
--   },
--   type = {
--       Array = ' ',
--       Boolean = '⏻ ',
--       Number = ' ',
--       Object = ' ',
--       String = ' ',
--   },
--   ui = {
--       Arrow = '➜ ',
--       ArrowClosed = ' ',
--       ArrowLeft = ' ',
--       ArrowOpen = ' ',
--       ArrowRight = ' ',
--       Bluetooth = ' ',
--       Bookmark = ' ',
--       Bug = ' ',
--       Calendar = ' ',
--       Camera = ' ',
--       Check = ' ',
--       ChevronRight = '',
--       Circle = ' ',
--       CircleSmall = '● ',
--       CircleSmallEmpty = '○ ',
--       Clipboard = ' ',
--       Close = ' ',
--       Code = ' ',
--       Collection = ' ',
--       Color = ' ',
--       Command = ' ',
--       Comment = ' ',
--       Corner = '└ ',
--       Dashboard = ' ',
--       Database = ' ',
--       Download = ' ',
--       Edge = '│ ',
--       Electric = ' ',
--       Fire = ' ',
--       Firefox = ' ',
--       Game = ' ',
--       Gear = ' ',
--       GitHub = ' ',
--       Heart = ' ',
--       History = ' ',
--       Home = ' ',
--       Incoming = ' ',
--       Keyboard = '  ',
--       List = '',
--       Lock = ' ',
--       Minus = '‒ ',
--       Music = '󰝚 ',
--       NeoVim = ' ',
--       NewFile = ' ',
--       None = ' ',
--       Note = ' ',
--       Outgoing = ' ',
--       Package = ' ',
--       Paint = ' ',
--       Pause = ' ',
--       Pencil = ' ',
--       Person = ' ',
--       Pin = ' ',
--       Play = ' ',
--       Plug = ' ',
--       Plus = ' ',
--       Power = ' ',
--       PowerlineArrowLeft = '',
--       PowerlineArrowRight = '',
--       PowerlineLeftRound = '',
--       PowerlineRightRound = '',
--       Project = ' ',
--       Question = ' ',
--       Reload = ' ',
--       Rocket = ' ',
--       Save = '󰆓 ',
--       Search = ' ',
--       Separator = '▊ ',
--       SignIn = ' ',
--       SignOut = ' ',
--       Sleep = '󰒲 ',
--       Star = ' ',
--       Table = ' ',
--       Telescope = ' ',
--       Terminal = ' ',
--       Test = ' ',
--       Time = ' ',
--       Trash = ' ',
--       Vim = ' ',
--       Wifi = ' ',
--       Windows = ' ',
--   },
