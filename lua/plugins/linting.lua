return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		config = function()
			require("lint").linters_by_ft = {
				php = { "phpstan" },
			}
			local phpstan = require("lint").linters.phpstan
            phpstan.args = {
                'analyze',
                '--error-format=json',
                '--no-progress',
                '-cphpstan.local.neon',
                '--memory-limit=2G',
            }
		end,
		keys = {
			{
				"<leader>l",
				function()
					require("lint").try_lint()
				end,
			},
		},
	},
}
