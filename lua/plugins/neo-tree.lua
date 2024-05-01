return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            close_if_last_window = true,
            window = {
                mappings = {
                    ['h'] = 'none',
                    ['t'] = 'none',
                    ['s'] = 'none',
                    ['n'] = 'none',
                    ['O'] = "open_vsplit",
                    ['T'] = 'none',
                }
            },
        },
        keys = {
            { "<leader>T", "<cmd>Neotree toggle<CR>" },
            { "<leader>F", "<cmd>Neotree focus reveal=true<CR>" },
        },
        cmd = {
            "Neotree",
        },
    },
}
