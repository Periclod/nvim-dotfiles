return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<D-a>",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"<D-e>",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"<D-i>",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"<D-c>",
			function()
				require("harpoon"):list():select(4)
			end,
		},

		{
			"<D-S-a>",
			function()
				require("harpoon"):list():replace_at(1)
			end,
		},
		{
			"<D-S-e>",
			function()
				require("harpoon"):list():replace_at(2)
			end,
		},
		{
			"<D-S-i>",
			function()
				require("harpoon"):list():replace_at(3)
			end,
		},
		{
			"<D-S-c>",
			function()
				require("harpoon"):list():replace_at(4)
			end,
		},
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
		},
	},
	config = function()
		require("harpoon"):setup()
	end,
}
