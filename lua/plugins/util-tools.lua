return {
	{
		"oysandvik94/curl.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("curl").setup({})
		end,
		cmd = {
			"CurlOpen",
			"CurlClose",
		},
	},
}
