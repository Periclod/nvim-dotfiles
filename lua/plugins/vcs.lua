local keys = require("layout")

return {
	{
		"julienvincent/hunk.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.api.nvim_set_hl(0, "DiffDelete", {
				bg = "#5A424D",
				fg = "none",
			})
			require("hunk").setup({
				keys = {
					global = {
						quit = { "q" },
						accept = { "<leader><Cr>" },
						focus_tree = { "<leader>e" },
					},

					tree = {
						expand_node = { keys.l, "<Right>" },
						collapse_node = { keys.h, "<Left>" },

						open_file = { "<Cr>" },

						toggle_file = { "a" },
					},

					diff = {
						toggle_line = { "A" },
						toggle_hunk = { "a" },

						toggle_file = { "<leader>a" },
					},
				},
			})
		end,
	},
}
