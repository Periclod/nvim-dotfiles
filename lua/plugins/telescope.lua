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
			local focus_preview = function(prompt_bufnr)
				local action_state = require("telescope.actions.state")
				local picker = action_state.get_current_picker(prompt_bufnr)
				local prompt_win = picker.prompt_win
				local previewer = picker.previewer
				local winid = previewer.state.winid
				local bufnr = previewer.state.bufnr
				vim.keymap.set("n", "<Tab>", function()
					vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
				end, { buffer = bufnr })
				vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
				-- api.nvim_set_current_win(winid)
			end

			require("telescope").load_extension("fzy_native")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-f>"] = function(...)
								require("trouble.sources.telescope").open(...)
							end,
							["<Tab>"] = focus_preview,
						},
						n = {
							["<C-f>"] = function(...)
								require("trouble.sources.telescope").open(...)
							end,
							["<Tab>"] = focus_preview,
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
