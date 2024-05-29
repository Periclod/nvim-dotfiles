local iserv_group = vim.api.nvim_create_augroup("IServRsync", {
	clear = true,
})

--[[ 
BufFilePost			After changing the name of the current buffer
with the ":file" or ":saveas" command.

FileWritePost		After writing to a file, when not writing the
whole buffer.

FileChangedShell		When Vim notices that the modification time of
a file has changed since editing started.
Also when the file attributes of the file
change or when the size of the file changes.
]]

vim.api.nvim_create_autocmd({ "BufWritePost", "BufFilePost", "FileWritePost", "FileChangedShell" }, {
	-- pattern = { vim.fn.expand("~") .. "/Developer/iserv/**",  vim.fn.expand("~") .. "/Developer/poweb/**"  },
	pattern = "*",
	group = iserv_group,
	callback = function(ev)
		local data = string.format("event fired: %s", vim.inspect(ev))
		error(data)
		error(jobstart("/Users/andrey.kutlin/.scripts/idev"))
	end,
})
