local function get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.trim(vim.fn.system("git branch --show-current"))
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end

return {
	{
		"stevearc/resession.nvim",
		opts = {
			autosave = {
				enabled = true,
				interval = 60,
				notify = false,
			},
		},
		lazy = false,
		config = function()
			require("resession").setup()
		end,
		keys = {
			{
				"<leader>ss",
				function()
					require("resession").save(get_session_name(), { dir = "dirsession", notify = false })
				end,
			},
			{
				"<leader>sl",
				function()
					require("resession").load(get_session_name(), { dir = "dirsession" })
				end,
			},
			{
				"<leader>sd",
				function()
					require("resession").delete(get_session_name(), { dir = "dirsession" })
				end,
			},
		},
	},
}
