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
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						selection_modes = {
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "V", -- blockwise
						},
					},
				},
			})
		end,
	},
	{
		"gbprod/substitute.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			vim.keymap.set("n", keys.substitute, require("substitute").operator, { noremap = true })
			vim.keymap.set("n", keys.substitute .. keys.substitute, require("substitute").line, { noremap = true })
			vim.keymap.set("n", keys.substitute:upper(), require("substitute").eol, { noremap = true })
			vim.keymap.set("x", keys.substitute, require("substitute").visual, { noremap = true })
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
		end,
	},
	{
		"unblevable/quick-scope",
		event = "VeryLazy",
		config = function()
			vim.cmd([[highlight QuickScopePrimary guifg='#af00ff' gui=underline ctermfg=155 cterm=underline]])
			vim.cmd([[highlight QuickScopeSecondary guifg='#af0000' gui=underline ctermfg=81 cterm=underline]])
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			--Config goes here
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
