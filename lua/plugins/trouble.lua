return {
	{
		"folke/trouble.nvim",
		opts = {
			focus = true,
			preview = {
				type = "float",
				relative = "editor",
				-- title = "Preview",
				-- title_pos = "center",
				position = { 0.2, 0.4 },
				-- position = { -1, -1 },
				size = { width = 0.6, height = 0.6 },
				zindex = 200,
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>dw",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Workspace Diagnostics (Trouble)",
			},
			{
				"<leader>dd",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Document/Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>tl",
				"<cmd>lclose<cr><cmd>Trouble loclist toggle<cr>",
				desc = "Replace Location List with (Trouble)",
			},
			{
				"<leader>tq",
				"<cmd>cclose<cr><cmd>Trouble qflist toggle<cr>",
				desc = "Relpace Quickfix List with (Trouble)",
			},
			{
				"<leader>ct",
				function()
					require("trouble").close()
				end,
				desc = "Close Trouble",
			},
		},
	},
}
