return {
	{
		"famiu/bufdelete.nvim",
		lazy = true,
		keys = {
			{
				"<leader>db",
				function()
					require("bufdelete").bufdelete(0)
				end,
			},
		},
	},
}
