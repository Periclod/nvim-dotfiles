return {
	{
		"julienvincent/hunk.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.api.nvim_set_hl(0, "DiffDelete", {
				bg = "#5A424D",
				fg = "none",
			})
			require("hunk").setup()
		end,
	},
}
