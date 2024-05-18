local format_all = function()
	local all_buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(all_buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			require("conform").format({ async = true, bufnr = buf, lsp_fallback = true })
		end
	end
end

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

				go = { "gofmt" },
			},
		},
		keys = {
			{
				"<leader>fmt",
				function()
					format_all()
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd({ "BufHidden", "BufUnload", "BufDelete" }, {
				pattern = "*",
				callback = function(args)
					require("conform").format({ async = true, bufnr = args.buf, lsp_fallback = true })
				end,
			})
			vim.api.nvim_create_autocmd({ "FocusLost" }, {
				pattern = "*",
				callback = function(args)
					format_all()
				end,
			})
		end,
	},
}
