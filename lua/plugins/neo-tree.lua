local keys = require("layout")

return {
	{
		"stevearc/oil.nvim",
		lazy = true,
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = {
			"Oil",
		},
	},
	{
		"echasnovski/mini.files",
		version = "*",
		lazy = true,
		opts = {
			mappings = {
				close = "q",
				go_in = keys.l,
				go_in_plus = keys.l:upper(),
				go_out = keys.h,
				go_out_plus = keys.h:upper(),
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
		},
		init = function()
			vim.api.nvim_create_user_command("Files", function()
				require("mini.files").open()
			end, {})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			close_if_last_window = true,
			window = {
				mappings = {
					["h"] = "none",
					["t"] = "none",
					["s"] = "none",
					["n"] = "none",
					["O"] = "open_vsplit",
					["T"] = "none",
				},
			},
		},
		keys = {
			{ "<leader>T", "<cmd>Neotree toggle<CR>" },
			{ "<leader>F", "<cmd>Neotree focus reveal=true<CR>" },
		},
		cmd = {
			"Neotree",
		},
	},
}
