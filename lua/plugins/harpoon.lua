return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        { "<leader>1", function() require('harpoon'):list():select(1) end },
        { "<leader>2", function() require('harpoon'):list():select(2) end },
        { "<leader>3", function() require('harpoon'):list():select(3) end },
        { "<leader>4", function() require('harpoon'):list():select(4) end },
        { "<leader>5", function() require('harpoon'):list():select(5) end },
        { "<leader>6", function() require('harpoon'):list():select(6) end },
        { "<leader>7", function() require('harpoon'):list():select(7) end },
        { "<leader>8", function() require('harpoon'):list():select(8) end },
        { "<leader>9", function() require('harpoon'):list():select(9) end },

        { "<leader>a1", function() require('harpoon'):list():replace_at(1) end },
        { "<leader>a2", function() require('harpoon'):list():replace_at(2) end },
        { "<leader>a3", function() require('harpoon'):list():replace_at(3) end },
        { "<leader>a4", function() require('harpoon'):list():replace_at(4) end },
        { "<leader>a5", function() require('harpoon'):list():replace_at(5) end },
        { "<leader>a6", function() require('harpoon'):list():replace_at(6) end },
        { "<leader>a7", function() require('harpoon'):list():replace_at(7) end },
        { "<leader>a8", function() require('harpoon'):list():replace_at(8) end },
        { "<leader>a9", function() require('harpoon'):list():replace_at(9) end },

        { '<C-e>', function() require('telescope').extensions.harpoon.marks() end }
    },
    config = function()
        require('harpoon'):setup()
        local telescope = require('telescope')
        telescope.load_extension('harpoon')
    end,
}
