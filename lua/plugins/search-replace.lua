return {
	{
		"MagicDuck/grug-far.nvim",
		cmd = "GrugFar",
		keys = {
			{ "<leader>ff", ":GrugFar<CR>" },
		},
		config = function()
			require("grug-far").setup({})
		end,
	},
}
