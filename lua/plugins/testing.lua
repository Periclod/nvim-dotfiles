return {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
        -- Actual dependencies
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Plugins
        "olimorris/neotest-phpunit",
    },
    keys = {
        { '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end },
        { '<leader>tc', function() require("neotest").run.run() end },
        { '<leader>to', function() require("neotest").output.open({ enter = true }) end },
        { '<leader>ts', function() require("neotest").summary.toggle() end },
    },
    config = function()
        local dap = require('dap')

        require("neotest").setup({
            summary = {
                mappings = {
                    target = '<leader>t',
                },
            },
            adapters = {
                require("neotest-phpunit")({
                    phpunit_cmd = function()
                        -- TODO: iserv4 vs iserv3 check
                        return "/Users/andrey.kutlin/.local/scripts/iserv3phpunit"
                    end,
                    root_files = { "README.md" },
                    env = {
                        XDEBUG_CONFIG = "idekey=neotest",
                    },
                    dap = dap.configurations.php[1],
                }),
            },
        })
    end,
}
