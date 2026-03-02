return {
	{
		"aznhe21/actions-preview.nvim",
		lazy = true,
		opts = {
			telescope = {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					width = 0.8,
					height = 0.9,
					prompt_position = "top",
					preview_cutoff = 20,
					preview_height = function(_, _, max_lines)
						return max_lines - 15
					end,
				},
			},
		},
	},
	{
		"williamboman/mason.nvim",
		-- Can't be lazy because it sets the $MASON variable I need for volar + ts to work
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"vue_ls",
				"phpactor",
				"ts_ls",
				"psalm",
				"twiggy",
				"biome",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"vue_ls",
				"phpactor",
				"ts_ls",
				"psalm",
				"twiggy",
				"biome",
			},
		},
		config = function()
			local lsps = {
				-- Everywhere utilities
				{ "typos_lsp" },
				{ "twiggy_language_server" },
				{
					"intelephense",
					require("plugins.lsp.intelephense"),
				},
				{
					"ts_ls",
					require("plugins.lsp.ts_ls"),
				},
				{ "vue_ls" },
				{ "html", {
					filetypes = { "html", "vue", "twig" },
				} },
				-- { "cssls", {
				-- 	filetypes = { "css", "less", "scss", "vue" },
				-- } },
				{ "somesass_ls" },
				{ "eslint" },
				{
					"custom_elements_ls",
					{

						cmd = {
							"node",
							"/Users/andrey.kutlin/Developer/misc/custom-elements-language-server/lib/server/dist/server.js",
							"--stdio",
						},
						filetypes = { "html", "vue", "typescript", "twig" },
					},
				},
				-- Configured with 'mrcjkb/rustaceanvim',
				-- {
				-- 	"rust_analyzer",
				-- 	{
				--
				-- 		settings = {
				-- 			["rust-analyzer"] = {
				-- 				checkOnSave = true,
				-- 			},
				-- 		},
				-- 	},
				-- },
				{ "lua_ls" },
				{ "bashls" },
				{ "templ", {
					cmd_env = {
						TEMPL_EXPERIMENT = "rawgo",
					},
				} },
				{
					"gopls",
					{

						filetypes = { "go", "gomod", "templ" },
						settings = {
							gopls = {
								staticcheck = true,
								analyses = {
									fieldalignment = true,
									unusedvariable = true,
								},
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
							},
						},
					},
				},
				{
					"sourcekit",
					{

						capabilities = {
							workspace = {
								didChangeWatchedFiles = {
									dynamicRegistration = true,
								},
							},
						},
					},
				},
				{ "pyright", {
					cmd_env = {
						VIRTUAL_ENV = ".venv",
					},
				} },
				{ "ruff" },
				{ "docker_language_server" },
			}

			for _, lsp in pairs(lsps) do
				local name, config = lsp[1], lsp[2]
				vim.lsp.enable(name)
				if config then
					vim.lsp.config(name, config)
				else
					vim.lsp.config(name, {})
				end
			end
		end,
	},
}
