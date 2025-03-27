local layout

if vim.fn.filereadable(vim.fn.expand("~/.config/qwerty")) == 1 then
	-- Qwerty
	layout = {
		h = "h",
		j = "j",
		k = "k",
		l = "l",

		n = "n",
		substitute = "s",
		t = "t",
		T = "T",
		leapf = "-",
		leapb = "_",
	}
else
	-- Engramm
	layout = {
		h = "s",
		j = "h",
		k = "t",
		l = "n",

		n = "k",
		substitute = "j",
		t = "-",
		T = "_",
		leapf = "l",
		leapb = "L",
	}
end

return layout
