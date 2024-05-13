return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		event = "VeryLazy",
		lazy = true,
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
			})

			lspconfig.volar.setup({})

			lspconfig.lua_ls.setup({})
			lspconfig.twiggy_language_server.setup({})
		end,
	},
}
