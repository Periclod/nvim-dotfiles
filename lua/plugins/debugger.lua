return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            local dap = require('dap')

            -- https://github.com/xdebug/vscode-php-debug?tab=readme-ov-file#supported-launchjson-settings
            dap.adapters.php = {
                type = 'executable',
                command = 'node',
                args = { '~/.local/debugger/vscode-php-debug/out/phpDebug.js' }
            }
            dap.configurations.php = {
                {
                    log = true,
                    type = "php",
                    request = "launch",
                    name = "Listen for XDebug",
                    port = 9003,
                    stopOnEntry = false,
                    xdebugSettings = {
                        max_children = 512,
                        max_data = 1024,
                        max_depth = 4,
                    },
                    pathMappings = {
                        ['/root/git/mail'] = '~/Developer/iserv/mail',
                    },
                    breakpoints = {
                        exception = {
                            Notice = false,
                            Warning = false,
                            Error = false,
                            Exception = false,
                            ["*"] = false,
                        },
                    }
                },
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        lazy = true
    },
}
