local ls = require("luasnip")
local s = ls.snippet
local c = ls.choice_node
local i = ls.intert_node
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("todo", {
		c(1, {
			t("TODO"),
			t("FIXME"),
			t("HACK"),
		}),
		t(": "),
		i(0),
	}),
}
