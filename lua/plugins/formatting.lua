local format_all = function()
	local all_buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(all_buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			require("conform").format({ async = true, bufnr = buf, lsp_fallback = false })
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

				javascript = { "prettierd" },
				typescript = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				vue = { "prettierd" },
				less = { "prettierd" },
				css = { "prettierd" },
				-- css_ls breaks HARD so this is VERY important (since we don't want to disable css_ls or lsp_fallback)
				scss = { "prettierd" },
				html = { "prettierd" },

				php = { "php_cs_fixer" },
				-- twig = { "twig_cs_fixer" },

				go = { "gofmt" },
				templ = { "templ" },

				swift = { "swiftlint" },
			},
			-- formatters = {
			-- 	php_cs_fixer = {
			-- 		append_args = function()
			-- 			local cwd = require("conform.util").root_file({ "composer.json", "README.md" })
			-- 			local app_config = cwd .. "app/.php-cs-fixer.php"
			-- 			if vim.fn.filereadable(app_config) then
			-- 				return { "--config=" .. app_config }
			-- 			end
			-- 			return {}
			-- 		end,
			-- 	},
			-- },
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
			require("conform.formatters.php_cs_fixer").env = {
				PHP_CS_FIXER_IGNORE_ENV = "1",
			}
			vim.api.nvim_create_autocmd({ "BufLeave", "BufHidden", "BufUnload", "BufDelete" }, {
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
