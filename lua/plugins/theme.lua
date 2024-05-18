return {
	-- {
	-- 	"uloco/bluloco.nvim",
	-- 	lazy = true,
	-- 	priority = 1000,
	-- 	dependencies = { "rktjmp/lush.nvim" },
	-- 	config = function()
	-- 		require("bluloco").setup({
	-- 			style = "light", -- "auto" | "dark" | "light"
	-- 			transparent = false,
	-- 			italics = false,
	-- 			terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
	-- 			guicursor = true,
	-- 		})
	--
	-- 		vim.opt.termguicolors = true
	-- 		vim.cmd("colorscheme bluloco")
	-- 		vim.cmd([[highlight QuickScopePrimary guifg='#af00ff' gui=underline ctermfg=155 cterm=underline]])
	-- 		vim.cmd([[highlight QuickScopeSecondary guifg='#af0000' gui=underline ctermfg=81 cterm=underline]])
	--
	-- 		vim.keymap.set("n", "<Leader>dark", function()
	-- 			vim.cmd.colorscheme("bluloco-dark")
	-- 		end)
	-- 		vim.keymap.set("n", "<Leader>light", function()
	-- 			vim.cmd.colorscheme("bluloco-light")
	-- 		end)
	-- 	end,
	-- },
	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"projekt0n/github-nvim-theme",
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					hide_end_of_buffer = false, -- Hide the '~' character at the end of the buffer for a cleaner look
					hide_nc_statusline = false, -- Override the underline style for non-active statuslines
					transparent = false, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = false, -- Non focused panes set to alternative background
					darken = {
						floats = true,
						sidebars = {
							enabled = true,
							list = {},
						},
					},
				},
				groups = {
					all = {
						-- Because for some reason delimiters are hardly visible by default
						-- Should probably check every now and then if it's fixed
						Delimiter = { fg = "#6e6e6e" },
					},
				},
			})
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		lazy = false, -- Don't lazy load because it sets the colorscheme
		priority = 1000, -- Load first to set the colorscheme for the rest of the plugins
		config = {
			-- update_interval = 60000,
			set_dark_mode = function()
				vim.o.background = "dark"
				vim.cmd("colorscheme github_dark")
			end,
			set_light_mode = function()
				vim.o.background = "light"
				vim.cmd("colorscheme github_light")
			end,
		},
	},
}
