return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		config = function()
			require("lint").linters_by_ft = {
				php = { "phpstan" },

				javascript = { "biomejs" },
				typescript = { "biomejs" },
				vue = { "biomejs" },
				less = { "biomejs" },
				css = { "biomejs" },
			}
			local phpstan = require("lint").linters.phpstan
			phpstan.args = {
				"analyze",
				"--error-format=json",
				"--no-progress",
				"-cphpstan.local.neon",
				"--memory-limit=2G",
			}
		end,
		keys = {
			{
				"<leader>l",
				function()
					local all_buffers = vim.api.nvim_list_bufs()
					for _, buf in ipairs(all_buffers) do
						if vim.api.nvim_buf_is_loaded(buf) then
							vim.api.nvim_buf_call(buf, function()
								require("lint").try_lint()
							end)
						end
					end
				end,
			},
		},
	},
}
