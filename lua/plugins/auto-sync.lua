return {
    {
        -- iserv sync
        "kenn7/vim-arsync",
        -- Cannot be lazy because it uses VimEnter autocommand
        lazy = false,
        dependencies = {
            "prabirshrestha/async.vim"
        },
    },
    {
        "pocco81/auto-save.nvim",
        event = "VeryLazy",
    },
}
