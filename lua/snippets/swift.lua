local ls = require("luasnip")
-- some shorthands...
local events = require("luasnip.util.events")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

require("luasnip.session.snippet_collection").clear_snippets("swift")

return {
	s(
		"if",
		fmt(
			[[
            if {} {
                {}
            }
            {}
            ]],
			{ i(1, "condition"), i(2), i(0) }
		)
	),
	s(
		"ifl",
		fmt(
			[[
            if let {} = {} {
                {}
            }
            {}
            ]],
			{ i(1, "value"), i(2, "option"), i(3), i(0) }
		)
	),
	s(
		"ifcl",
		fmt(
			[[
            if case let {} = {} {
                {}
            }
            {}
            ]],
			{ i(1, "value"), i(2, "value"), i(3), i(0) }
		)
	),
	s(
		"guard",
		fmt(
			[[
            guard {} else {
                {}
            }
            {}
            ]],
			{ i(1, "condition"), i(2, "return"), i(0) }
		)
	),
	s(
		"guardl",
		fmt(
			[[
            guard let {} = {} else {
                {}
            }
            {}
            ]],
			{ i(1, "value"), i(2, "option"), i(3, "return"), i(0) }
		)
	),
}
