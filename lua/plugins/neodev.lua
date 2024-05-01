return {
    "folke/neodev.nvim",
    lazy = true,
    opts = {
        library = {
            plugins = { "neotest", "nvim-treesitter", "plenary.nvim" },
            types = true,
        },
    },
}
