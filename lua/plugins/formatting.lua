return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		lazy = true,
		cmd = { "ConformInfo" },
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
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
				scss = { "prettierd" },
				html = { "prettierd" },

				php = { "php_cs_fixer" },

				go = { "gofmt" },
				templ = { "templ" },

				swift = { "swiftlint" },
			},
			formatters = {
				php_cs_fixer = {
					stdin = false,
					append_args = function(self, ctx)
						local cwd = require("conform.util").root_file({ "composer.json", "README.md" })(self, ctx)
						if cwd == nil then
							return {}
						end
						local app_config = cwd .. "/app/.php-cs-fixer.php"
						if vim.fn.filereadable(app_config) == 1 then
							return { "--config=" .. app_config }
						end
						local v3_config = cwd .. "/.php-cs-fixer.php"
						if vim.fn.filereadable(v3_config) == 1 then
							return { "--config=" .. v3_config }
						end
						return {}
					end,
					async = false,
					env = {
						PHP_CS_FIXER_IGNORE_ENV = "1",
					},
				},
			},
		},
		keys = {
			{
				"<leader>fmt",
				function()
					local path = vim.api.nvim_buf_get_name(0)
					if path:sub(-4) == ".php" then
						-- php_cs_fixer has problems with async and temp files I think
						require("conform").format({ async = false, lsp_fallback = true })
					elseif path:sub(-5) ~= ".twig" then
						require("conform").format({ async = true, lsp_fallback = true })
					end
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					print("Formatting " .. args.file)
					if args.file:sub(-4) == ".php" then
						-- php_cs_fixer has problems with async and temp files I think
						require("conform").format({ bufnr = args.buf, lsp_fallback = true })
					elseif args.file:sub(-5) ~= ".twig" then
						require("conform").format({ bufnr = args.buf, lsp_fallback = true })
					end
				end,
			})
		end,
	},
}
