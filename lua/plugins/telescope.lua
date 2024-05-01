return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        lazy = true,
        dependencies = { 
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            },
        },
        keys = {
            { '<D-o>', function() require('telescope.builtin').find_files() end },
            { '<C-f>', function() require('telescope.builtin').live_grep() end },
            { '<leader>b', function() require('telescope.builtin').buffers() end },
            { '<leader>fh', function() require('telescope.builtin').help_tags() end },
            { '<leader>ws', function() require('telescope.builtin').lsp_workspace_symbols() end },
            { '<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end },
            { '<leader>gc', function() require('telescope.builtin').lsp_incoming_calls() end },
            { '<leader>qf', function() require('telescope.builtin').quickfix() end },
        },
    }
}
