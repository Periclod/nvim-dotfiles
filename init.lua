vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.wo.relativenumber = true
vim.wo.number = true
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.smartcase = true
vim.o.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10

vim.o.switchbuf = "useopen"

vim.o.spell = true
vim.bo.spelllang = "en_us,de_de"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true

require("keymap")

-- Highlight yank using native nvim only api
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Highlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")
require("lazy").setup(plugins)

-- require('iserv-autosync')
