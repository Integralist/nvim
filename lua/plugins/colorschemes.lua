return function(use)
  use "EdenEast/nightfox.nvim"
  use { "ellisonleao/gruvbox.nvim",
    config = function()
      -- require("gruvbox").setup({
      --   contrast = "hard",
      -- })
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
        palette_overrides = {
          dark0_hard = "#0A0E14",
          dark0 = "#282828",
          dark0_soft = "#32302f",
          dark1 = "#00010A",
          dark2 = "#504945",
          dark3 = "#665c54",
          dark4 = "#7c6f64",
          light0_hard = "#f9f5d7",
          light0 = "#fbf1c7",
          light0_soft = "#f2e5bc",
          light1 = "#ebdbb2",
          light2 = "#d5c4a1",
          light3 = "#bdae93",
          light4 = "#a89984",
          bright_red = "#fb4934",
          bright_green = "#b8bb26",
          bright_yellow = "#fabd2f",
          bright_blue = "#83a598",
          bright_purple = "#d3869b",
          bright_aqua = "#8ec07c",
          bright_orange = "#fe8019",
          neutral_red = "#cc241d",
          neutral_green = "#98971a",
          neutral_yellow = "#d79921",
          neutral_blue = "#458588",
          neutral_purple = "#b16286",
          neutral_aqua = "#689d6a",
          neutral_orange = "#d65d0e",
          faded_red = "#9d0006",
          faded_green = "#79740e",
          faded_yellow = "#b57614",
          faded_blue = "#076678",
          faded_purple = "#8f3f71",
          faded_aqua = "#427b58",
          faded_orange = "#af3a03",
          gray = "#928374",
        },
      })

      -- We remove the Vim builtin colorschemes so they don't show in Telescope.
      vim.cmd("silent !rm $VIMRUNTIME/colors/*.vim &> /dev/null")

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("FixGruvboxForNoice", { clear = true }),
        pattern = "*",
        callback = function()
          if vim.g.colors_name == "gruvbox" then
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCmdline", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderFilter", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderHelp", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderInput", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderLua", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = "#fabd2f", bg = "NONE" })

            vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlineIconFilter", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlineIconHelp", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlineIconInput", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlineIconLua", { fg = "#83a598", bg = "NONE" })
            vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = "#fabd2f", bg = "NONE" })

            vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { fg = "#000000", bg = "#fabd2f" })
          end
        end
      })

      vim.cmd("colorscheme gruvbox")

      -- EXAMPLE:
      -- ExtendHL('Comment', { italic = true })
      function ExtendHL(name, def)
        local current_def = vim.api.nvim_get_hl_by_name(name, true)
        local new_def = vim.tbl_extend("force", {}, current_def, def)
        vim.api.nvim_set_hl(0, name, new_def)
      end

      -- NOTE: If you want to quickly change the background colour of a theme, and
      -- also the default text colour (e.g. the Ex command line color) then the
      -- following highlight group will affect that.
      --
      -- :hi Normal guifg=#e0def4 guibg=#232136
      --
      -- :lua TweakTheme("white", "pink")
      -- :lua TweakTheme("#ffffff", "#000000")
      function TweakTheme(fg, bg)
        vim.cmd("hi Normal guifg=" .. fg .. " guibg=" .. bg)
      end
    end
  }
  use "fenetikm/falcon"
  use "vito-c/jq.vim" -- not a colourscheme but syntax highlighting
end
