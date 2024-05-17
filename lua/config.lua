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
