local keys = require("layout")

return {
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		opts = {
			case_sensitive = false,
		},
		config = function()
			vim.keymap.set({ "n", "x", "o" }, keys.leapf, "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, keys.leapb, "<Plug>(leap-backward)")

			require("leap").opts.special_keys.prev_target = "<backspace>"
			require("leap").opts.special_keys.prev_group = "<backspace>"
		end,
	},
	{
		"ggandor/leap-spooky.nvim",
		lazy = false,
		dependencies = {
			"ggandor/leap.nvim",
		},
		opts = {
			paste_on_remote_yank = true,
		},
	},
}
