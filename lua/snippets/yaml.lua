local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

require("luasnip.session.snippet_collection").clear_snippets("yaml")

print("yaml")

return {
	s(
		"changelog",
		fmt(
			[[
            text: '{}'
            audience: '{}'
            type: '{}'
            urgency: 'medium'
            closes:
            - {}
            highlight: false
            ]],
			{
				i(0),
				c(1, {
					t("users"),
					t("teachers"),
					t("admins"),
					t("technical"),
				}),
				c(2, {
					t("added"),
					t("fixed"),
					t("changed"),
					t("deprecated"),
					t("removed"),
					t("other"),
				}),
				i(3),
			}
		)
	),
}
