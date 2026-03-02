return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		-- Actual dependencies
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- Plugins
		"olimorris/neotest-phpunit",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
		"giggio/neo-neotest-rust",
	},
	keys = {
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
		},
		{
			"<leader>tc",
			function()
				require("neotest").run.run()
			end,
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
		},
	},
	config = function()
		local dap = require("dap")

		local adapters = {
			require("neotest-phpunit")({
				phpunit_cmd = function()
					if vim.fn.filereadable(vim.fn.getcwd() .. "/app/vendor/bin/phpunit") == 1 then
						return { "app/vendor/bin/phpunit", "-c", "app/phpunit.xml" }
					elseif vim.fn.filereadable(vim.fn.getcwd() .. "/app/tools/phpunit") == 1 then
						return { "app/tools/phpunit", "-c", "app/phpunit.xml" }
					elseif vim.fn.filereadable(vim.fn.getcwd() .. "/vendor/bin/phpunit") == 1 then
						return "vendor/bin/phpunit"
					elseif vim.fn.filereadable(vim.fn.getcwd() .. "/tools/phpunit") == 1 then
						return "tools/phpunit"
					end
					return "/Users/andrey.kutlin/.local/scripts/iserv3phpunit"
				end,
				env = {
					XDEBUG_CONFIG = "idekey=neotest",
				},
				filter_dirs = { "vendor", "app/vendor" },
				dap = dap.configurations.php[1],
			}),
			require("neotest-jest")({
				jestConfigFile = "jest.config.js",
				cwd = function(path)
					-- TODO: check project folder
					return vim.fn.getcwd() .. "/app/"
				end,
			}),
			require("neotest-vitest")({
				cwd = function(path)
					return require("lspconfig").util.root_pattern({ "vite.config.ts", "vitest.config.ts" })(path)
				end,
				filter_dir = function(name, rel_path, root)
					return name ~= "node_modules" and name ~= "deps"
				end,
			}),
			require("neo-neotest-rust"),
			require("rustaceanvim.neotest")({
				env = { RUSTFLAGS = "-Awarnings" },
			}),
		}
		require("neotest").setup({
			-- log_level = 0,
			summary = {
				mappings = {
					target = "<leader>t",
				},
			},
			icons = {
				running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
				passed = "✅",
				running = "⏩",
				failed = "❌",
				skipped = "💤",
				unknown = "🔹",
				non_collapsible = "─",
				collapsed = "─",
				expanded = "╮",
				child_prefix = "├",
				final_child_prefix = "╰",
				child_indent = "│",
				final_child_indent = " ",
				watching = "🔁",
				notify = "",
			},
			highlights = {
				running = "NeoTreeGitModified",
				test = "NeoTreeGitModified",
				focused = "NeoTreeFileNameOpened",
				file = "NeoTreeGitUntracked",
				dir = "NeoTreeDirectoryName",
			},
			adapters = adapters,
		})
	end,
}
