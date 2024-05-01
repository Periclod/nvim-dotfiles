return {
    "ahmedkhalf/project.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    lazy = true,
    opts = {
        detection_methods = { "pattern" },
        patterns = { ".git", ".luarc.json" },
        silent_chdir = false,
        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = 'tab',
    },
    keys = {
        { '<leader>p', function() require('telescope').extensions.projects.projects() end},
    },
    config = function()
        require("project_nvim").setup()

        local telescope = require('telescope')
        telescope.load_extension('projects')
    end
}
