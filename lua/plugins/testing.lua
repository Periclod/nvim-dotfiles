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
        'nvim-neotest/neotest-jest',
        'marilari88/neotest-vitest',
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
            -- log_level = 0,
            summary = {
                mappings = {
                    target = '<leader>t',
                },
            },
            icons = {
                running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
                passed = "✅",
                running = "⏩",
                failed = "❌",
                skipped = "💤",
                unknown = "🔹",
                non_collapsible = "─",
                collapsed = "─",
                expanded = "╮",
                child_prefix = "├",
                final_child_prefix = "╰",
                child_indent = "│",
                final_child_indent = " ",
                watching = "🔁",
                notify = "",
            },
            highlights = {
                running = "NeoTreeGitModified",
                test = "NeoTreeGitModified",
                focused = "NeoTreeFileNameOpened",
                file = "NeoTreeGitUntracked",
                dir = "NeoTreeDirectoryName",
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
                require('neotest-jest')({
                    jestConfigFile = "jest.config.js",
                    cwd = function(path)
                        -- TODO: check project folder
                        return vim.fn.getcwd() .. '/app/'
                    end,
                }),
                require('neotest-vitest')({
                    cwd = function(path)
                        -- TODO: check project folder
                        return vim.fn.getcwd() .. '/app/'
                    end,
                }),
            },
        })
    end,
}
