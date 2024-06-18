return {
	{
		"eandrju/cellular-automaton.nvim",
		lazy = true,
		cmd = { "CellularAutomaton" },
		keys = {
			{
				"<leader><leader>fml",
				"<cmd>CellularAutomaton make_it_rain<cr>",
			},
		},
	},
	{
		"NStefan002/screenkey.nvim",
		lazy = true,
		version = "*",
		cmd = {
			"Screenkey",
		},
	},
}
