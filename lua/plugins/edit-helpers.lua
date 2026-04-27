local keys = require("layout")

return {
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		lazy = true,
		opts = {
			width = 150,
			autocmds = {
				skipEnteringNoNeckPainBuffer = true,
			},
			buffers = {
				colors = {
					blend = -0.2,
				},
			},
		},
		cmd = { "NoNeckPain" },
		keys = {
			{
				"<leader><leader>n",
				function()
					require("no-neck-pain").toggle()
				end,
			},
		},
	},
	{
		"kwkarlwang/bufjump.nvim",
		lazy = true,
		keys = {
			{ "<C-S-o>" },
			{ "<C-S-i>" },
		},
		opts = {
			forward_key = "<C-S-i>",
			backward_key = "<C-S-o>",
		},
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
			vim.g.no_plugin_maps = true

			-- Or, disable per filetype (add as you like)
			-- vim.g.no_python_maps = true
			-- vim.g.no_ruby_maps = true
			-- vim.g.no_rust_maps = true
			-- vim.g.no_go_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = true,
					selection_modes = {
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local mappings = {
				{ "aa", "@parameter.outer", "textobjects" },
				{ "ia", "@parameter.inner", "textobjects" },
				{ "af", "@function.outer", "textobjects" },
				{ "if", "@function.inner", "textobjects" },
				{ "ac", "@class.outer", "textobjects" },
				{ "ic", "@class.inner", "textobjects", "Select inner part of a class region" },
				{ "as", "@local.scope", "locals", "Select language scope" },
			}
			for _, m in ipairs(mappings) do
				local lhs, query, group, desc = m[1], m[2], m[3], m[4]
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, group)
				end, { desc = desc })
			end
		end,
	},
	{
		"gbprod/substitute.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>" .. keys.substitute, require("substitute").operator, { noremap = true })
			vim.keymap.set(
				"n",
				"<leader>" .. keys.substitute .. keys.substitute,
				require("substitute").line,
				{ noremap = true }
			)
			vim.keymap.set("n", "<leader>" .. keys.substitute:upper(), require("substitute").eol, { noremap = true })
			vim.keymap.set("x", "<leader>" .. keys.substitute, require("substitute").visual, { noremap = true })
		end,
	},
	{
		"svermeulen/vim-cutlass",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "x", "d", { noremap = true })
			vim.keymap.set("x", "x", "d", { noremap = true })
			vim.keymap.set("n", "xx", "dd", { noremap = true })
			vim.keymap.set("n", "X", "D", { noremap = true })
			vim.keymap.set("v", "p", '"_p', { noremap = true })
		end,
	},
	-- {
	-- 	"unblevable/quick-scope",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		vim.cmd([[highlight QuickScopePrimary guifg='#af00ff' gui=underline ctermfg=155 cterm=underline]])
	-- 		vim.cmd([[highlight QuickScopeSecondary guifg='#af0000' gui=underline ctermfg=81 cterm=underline]])
	-- 	end,
	-- },
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			fastwarp = {
				map = "<C-e>",
				rmap = "<C-S-e>",
				cmap = "<C-e>",
				rcmap = "<C-S-e>",
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
