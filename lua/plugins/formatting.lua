return {
	{
		"stevearc/conform.nvim",
        event = "FocusLost",
        lazy = true,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },

				javascript = { "biome" },
				typescript = { "biome" },
				vue = { "biome" },
				less = { "biome" },
				css = { "biome" },

				php = { "php_cs_fixer" },
			},
		},
		keys = {
			{
				"<leader>fmt",
				function()
					require("conform").format()
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("FocusLost", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},
}
