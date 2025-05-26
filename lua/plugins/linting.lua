local lint_all = function()
	local all_buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(all_buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_call(buf, function()
				require("lint").try_lint()
			end)
		end
	end
end

local lint_buf = function(buf)
	vim.api.nvim_buf_call(buf, function()
		require("lint").try_lint()
	end)
end

return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		config = function()
			require("lint").linters_by_ft = {
				php = { "phpstan" },
				python = { "mypy" },

				-- swift = { "swiftlint" },
				-- bash = { "shellcheck" },
				-- javascript = { "biomejs" },
				-- typescript = { "biomejs" },
				-- vue = { "biomejs" },
				-- less = { "biomejs" },
				-- css = { "biomejs" },
				-- json = { "biomejs" },
			}

			local phpstan = require("lint").linters.phpstan
			phpstan.cmd = vim.fn.expand("~/.local/scripts/iserv-phpstan")
			phpstan.args = {
				"analyze",
				"--error-format=json",
				"--no-progress",
				function()
					if vim.fn.filereadable(vim.fn.getcwd() .. "/phpstan.local.neon") == 1 then
						return "-cphpstan.local.neon"
					elseif vim.fn.filereadable(vim.fn.getcwd() .. "/app/phpstan.neon") == 1 then
						return "-capp/phpstan.neon"
					elseif vim.fn.filereadable(vim.fn.getcwd() .. "/phpstan.neon") == 1 then
						return "-cphpstan.neon"
					end
					return ""
				end,
				"--memory-limit=2G",
			}
		end,
		keys = {
			{
				"<leader>l",
				function()
					lint_all()
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd({ "BufWrite" }, {
				-- Only mypy and phpstan are linters, rest are lsps or formatters
				pattern = { "*.php", "*.py" },
				callback = function(args)
					lint_buf(args.buf)
				end,
			})
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		opts = {
			auto_open_qflist = true,
			use_trouble_qflist = true,
			use_diagnostics = true,
			-- todo: PR to make this a function for per project config
			bin_path = "./app/node_modules/.bin/vue-tsc",
		},
		cmd = {
			"TSC",
			"TSCOpen",
			"TSCClose",
		},
	},
}
