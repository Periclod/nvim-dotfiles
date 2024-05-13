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
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
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
			})

			vim.cmd("colorscheme github_light")
		end,
	},
}
