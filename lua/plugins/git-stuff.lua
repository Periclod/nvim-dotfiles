return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 250,
				ignore_whitespace = false,
			},
		},
		keys = {
			{
				"<leader>sb",
				function()
					require("gitsigns").stage_buffer()
				end,
			},
			{
				"<leader>rb",
				function()
					require("gitsigns").reset_buffer()
				end,
			},
			{
				"<leader>sh",
				function()
					require("gitsigns").stage_hunk()
				end,
			},
			{
				"<leader>rh",
				function()
					require("gitsigns").reset_hunk()
				end,
			},
			{
				"<leader>uh",
				function()
					require("gitsigns").undo_stage_hunk()
				end,
			},

			{
				"<leader>sh",
				function()
					require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = { "v" },
			},
			{
				"<leader>rh",
				function()
					require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = { "v" },
			},
			{
				"<leader>uh",
				function()
					require("gitsigns").undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				mode = { "v" },
			},
		},
	},
	{
		-- TODO while working on my tool
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = true,
		cmd = {
			"Neogit",
		},
	},
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
			"shumphrey/fugitive-gitlab.vim",
		},
		lazy = true,
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gvdiffsplit",
			"Gwrite",
			"Gread",

			"GDelete",

			"GMove",
			"GRename",

			"Ggrep",
			"Glgrep",

			"Gedit",
			"Gsplit",
			"Gvsplit",
			"Gtabedit",

			"GBrowse",
		},
	},
}
