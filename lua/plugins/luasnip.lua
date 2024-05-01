return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        event = 'InsertEnter',
        lazy = true,
        opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI",
        },
        config = function()
            local ls = require("luasnip")

            vim.keymap.set({ 'i', 's' }, '<C-n>', function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end)

            vim.keymap.set({ 'i', 's' }, '<C-h>', function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end)

            vim.keymap.set({ 'i', 's' }, '<C-l>', function()
                if ls.choice_active() then
                    ls.change_choice()
                end
            end)

            vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.config/nvim/lua/snippets.lua<CR>')

            require("snippets")
        end
    },
}
