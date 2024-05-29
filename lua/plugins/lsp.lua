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
		lazy = true,
		opts = {},
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUpdate",
			"MasonUninstall",
			"MasonList",
			"MasonSearch",
			"MasonInstallAll",
			"MasonUpdateAll",
			"MasonUninstallAll",
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		-- event = "VeryLazy",
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"volar",
				"phpactor",
				"tsserver",
				"psalm",
				"twiggy",
				"biome",
			},
		},
		config = function()
			require("neodev").setup()
			local lspconfig = require("lspconfig")
			lspconfig.phpactor.setup({
				root_dir = lspconfig.util.root_pattern("composer.json"),
			})

			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"

			lspconfig.tsserver.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				settings = {
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					typescript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			})

			lspconfig.volar.setup({})
            lspconfig.stylelint_lsp.setup({})

			lspconfig.lua_ls.setup({})
			lspconfig.twiggy_language_server.setup({})
			lspconfig.gopls.setup({
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
			})
		end,
	},
}
