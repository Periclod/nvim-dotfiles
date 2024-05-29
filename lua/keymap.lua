vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Key replacements for custom/qwerty layout
local keys = require("layout")

-- Engramm remappings
local function full_keymap(key, action)
	if key == action then
		return
	end
	if type(key) == "table" then
		vim.keymap.set({ "n", "v", "o" }, key[1], action, { noremap = true })
		vim.keymap.set({ "n", "v", "o" }, key[2], action:upper(), { noremap = true })
	else
		vim.keymap.set({ "n", "v", "o" }, key, action, { noremap = true })
		vim.keymap.set({ "n", "v", "o" }, key:upper(), action:upper(), { noremap = true })
	end
end

full_keymap(keys.h, "h")
full_keymap(keys.j, "j")
full_keymap(keys.k, "k")
full_keymap(keys.l, "l")

full_keymap(keys.n, "n")
full_keymap({ keys.t, keys.T }, "t")

vim.keymap.set("n", "<C-w>" .. keys.h, "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-w>" .. keys.j, "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-w>" .. keys.k, "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-w>" .. keys.l, "<C-w>l", { noremap = true })
-- Probably fine with all (engram & qwerty) layouts
vim.keymap.set("n", "<C-w>V", "<C-w>s", { noremap = true })

-- Spell checking
vim.keymap.set("n", "<leader>ft", "z=", { desc = "Fix typo under cursor" })
vim.keymap.set("n", "<leader>st", "zg", { desc = "Add word under cursor to wordlist" })

-- system clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to system clipboard" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<PageUp>", "<C-u>")
vim.keymap.set("n", "<PageDown>", "<C-d>")

-- LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

		vim.keymap.set("n", "T", vim.lsp.buf.hover, opts)

		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		vim.keymap.set("n", "<C-t>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)

		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<space>iv", vim.lsp.buf.execute_command, opts)

		vim.keymap.set({ "i", "n", "v" }, "<C-a>", vim.lsp.buf.code_action, opts)
		vim.keymap.set({ "i", "n", "v" }, "<C-S-a>", function()
			require("actions-preview").code_actions()
		end, opts)

		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, vim.tbl_extend("error", opts, { desc = "Toggle inlay hints" }))

		vim.lsp.inlay_hint.enable()
		-- Enable inlay hints by default
		-- local client = vim.lsp.get_client_by_id(ev.data.client_id)
		-- if client ~= nil and client.server_capabilities.inlayHintProvider then
		-- 	vim.lsp.inlay_hint.enable()
		-- end
	end,
})

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })
vim.keymap.set("n", "<Leader>do", vim.diagnostic.open_float, { desc = "Open Diagnostic floating panel" })
vim.keymap.set("n", "<D-]>", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<D-[>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist)

-- Quickfixlist
vim.keymap.set("n", "<leader>cq", ":cclose<CR>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>cn", ":cn<CR>", { desc = "Next quickfix entry" })
vim.keymap.set("n", "<leader>cp", ":cp<CR>", { desc = "Previous quickfix entry" })

vim.keymap.set("n", "<leader>cl", ":lclose<CR>", { desc = "Close LocList list" })

-- Close current window
vim.keymap.set("n", "Q", "q", { noremap = true })
vim.keymap.set("n", "q", ":q<CR>")

-- resizing window
vim.keymap.set("n", "<C-n>", ":vert res +10<CR>")
vim.keymap.set("n", "<C-s>", ":vert res -10<CR>")
vim.keymap.set("n", "<C-h>", ":res +10<CR>")

-- tab navigation
vim.keymap.set("n", "<C-t>o", "<CMD>tabnew<CR>")
vim.keymap.set("n", "<C-t>e", "<CMD>tabe %<CR>")
vim.keymap.set("n", "<C-t>n", "<CMD>tabnext<CR>")
vim.keymap.set("n", "<C-t>s", "<CMD>tabprev<CR>")
vim.keymap.set("n", "<C-t>q", "<CMD>tabclose<CR>")

-- clear search highlighting using Ctrl-C
vim.keymap.set("n", "<C-c>", ":nohl<CR>")
