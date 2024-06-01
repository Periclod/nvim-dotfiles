-- Global Filetype Marks
vim.cmd([[
augroup VIMRC
  autocmd!

  autocmd BufLeave *.css  normal! mC
  autocmd BufLeave *.html normal! mH
  autocmd BufLeave *.js   normal! mJ
  autocmd BufLeave *.ts   normal! mT
  autocmd BufLeave *.vue   normal! mV
  autocmd BufLeave *.php  normal! mP

  autocmd BufLeave *  normal! mL
augroup END
]])

vim.keymap.set("n", "<leader><leader>t", ":source %<CR>")

--- Set a mark in the middle of the first element matched by the query
--- @param letter string
--- @param query string
--- @param root TSNode
--- @param bufnr number
local function set_mark(letter, query, root, bufnr)
	local template_query = vim.treesitter.query.parse("vue", query)
	local _, captures, metadata = template_query:iter_captures(root, bufnr)()
	if not metadata then
		return
	end

	local start = captures:start()
	local end_ = captures:end_()
	local middle = math.floor((start + end_) / 2)

	vim.api.nvim_call_function("setpos", { "'" .. letter, { bufnr, middle, 1, 0 } })
end

vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
	pattern = "*.vue",
	group = "VIMRC",
	callback = function(event)
		local bufnr = event.bufnr
		local root = vim.treesitter.get_parser(bufnr, "vue"):parse()[1]:root()

		set_mark("h", "(template_element) @element", root, bufnr)
		set_mark("t", "(script_element) @element", root, bufnr)
		set_mark("s", "(style_element) @element", root, bufnr)
	end,
})
