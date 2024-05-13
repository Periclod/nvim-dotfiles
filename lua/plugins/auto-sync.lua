return {
	{
		-- iserv sync
		"kenn7/vim-arsync",
		-- Cannot be lazy because it uses VimEnter autocommand
		lazy = false,
		dependencies = {
			"prabirshrestha/async.vim",
		},
	},
	{
		"pocco81/auto-save.nvim",
		event = "VeryLazy",
		opts = {
			condition = function(buf)
				local fn = vim.fn
				local utils = require("auto-save.utils.data")
				local disabled_types = {
					"oil",
				}

				if
					fn.getbufvar(buf, "&modifiable") == 1
					and utils.not_in(fn.getbufvar(buf, "&filetype"), disabled_types)
				then
					return true -- met condition(s), can save
				end
				return false -- can't save
			end,
		},
	},
}
