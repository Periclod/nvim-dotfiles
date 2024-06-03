return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- {
			-- 	"nvim-telescope/telescope-fzf-native.nvim",
			-- 	build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			-- },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		config = function()
			require("telescope").load_extension("fzy_native")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-Down>"] = require("telescope.actions").cycle_history_next,
							["<C-Up>"] = require("telescope.actions").cycle_history_prev,
						},
					},
				},
			})
		end,
		keys = {
			{
				"<D-f>",
				function()
					require("telescope.builtin").find_files()
				end,
			},
			{
				"<C-f>",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"<C-S-f>",
				function()
					require("telescope.builtin").live_grep({
						default_text = vim.fn.expand("<cword>"),
					})
				end,
			},
			{
				"<D-r>",
				function()
					require("telescope.builtin").resume()
				end,
			},
			{
				"<D-S-r>",
				function()
					require("telescope.builtin").pickers()
				end,
			},
			{
				"<D-b>",
				function()
					require("telescope.builtin").git_branches()
				end,
			},
			{
				"<leader>m",
				function()
					require("telescope.builtin").marks()
				end,
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
			},
			{
				"<leader>ws",
				function()
					require("telescope.builtin").lsp_workspace_symbols()
				end,
			},
			{
				"<leader>ds",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").lsp_incoming_calls()
				end,
			},
			{
				"<leader>qf",
				function()
					require("telescope.builtin").quickfix()
				end,
			},
		},
	},
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		lazy = true,
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			"kkharji/sqlite.lua",
		},
		keys = {
			{
				"<D-s>",
				function()
					require("telescope").extensions.smart_open.smart_open({
						cwd_only = true,
						filename_first = false,
					})
				end,
			},
		},
	},
}
