-- Engramm remappings
local function full_keymap(key, action)
    vim.keymap.set({'n', 'v', 'o'}, key, action, { noremap = true })
    vim.keymap.set({'n', 'v', 'o'}, key:upper(), action:upper(), { noremap = true })
end

full_keymap('h', 'j')
full_keymap('t', 'k')
full_keymap('s', 'h')
full_keymap('n', 'l')

full_keymap('j', 't')
full_keymap('k', 'n')
full_keymap('l', 't')

vim.keymap.set('n', '<C-w>h', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-w>t', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-w>s', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-w>n', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-w>V', '<C-w>s', { noremap = true })

-- LSP mappings
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        vim.keymap.set('n', 'T', vim.lsp.buf.hover, opts)

        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        vim.keymap.set('n', '<C-t>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>iv', vim.lsp.buf.execute_command, opts)
        vim.keymap.set({ 'i', 'n', 'v' }, '<C-a>', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>fmt', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })
vim.keymap.set('n', '<Leader>ds', vim.diagnostic.open_float)
vim.keymap.set('n', '<D-]>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<D-[>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Close current window
vim.keymap.set("n", "Q", "q", { noremap = true })
vim.keymap.set("n", "q", ":q<CR>")

-- resizing window
vim.keymap.set("n", "<C-n>", ":vert res +10<CR>")
vim.keymap.set("n", "<C-s>", ":vert res -10<CR>")
vim.keymap.set("n", "<C-h>", ":res +10<CR>")

-- tab navigation
vim.keymap.set("n", "<C-t>o", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<C-t>n", "<CMD>tabnext<CR>")
vim.keymap.set("n", "<C-t>p", "<CMD>tabprev<CR>")
vim.keymap.set("n", "<C-t>q", "<CMD>tabclose<CR>")

-- clear search highlighting using Ctrl-C
vim.keymap.set("n", "<C-c>", ":nohl<CR>")
