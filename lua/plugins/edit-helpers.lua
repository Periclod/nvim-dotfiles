return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
    },
    -- ia/aa for argument motion
    -- {
    --     "vim-scripts/argtextobj.vim",
    --     event = "VeryLazy",
    -- },
    -- Lots of motions like css selectors and intend groups
    {
        -- https://github.com/chrisgrieser/nvim-various-textobjs
        "chrisgrieser/nvim-various-textobjs",
        event = "VeryLazy",
        opts = { useDefaultKeymaps = true },
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = "VeryLazy",
        config = function()
            require'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.outer",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = 'V', -- blockwise
                        },
                    },
                },
            }
        end
    },
    {
        "gbprod/substitute.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            vim.keymap.set("n", 'j', require('substitute').operator, { noremap = true })
            vim.keymap.set("n", 'jj', require('substitute').line, { noremap = true })
            vim.keymap.set("n", 'J', require('substitute').eol, { noremap = true })
            vim.keymap.set("x", 'j', require('substitute').visual, { noremap = true })
        end
    },
    {
        "svermeulen/vim-cutlass",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "x", "d", { noremap = true })
            vim.keymap.set("x", "x", "d", { noremap = true })
            vim.keymap.set("n", "xx", "dd", { noremap = true })
            vim.keymap.set("n", "X", "D", { noremap = true })
        end
    },
    {
        'unblevable/quick-scope',
        event = "VeryLazy",
    },
}
