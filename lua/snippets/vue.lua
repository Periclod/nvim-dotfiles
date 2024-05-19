local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt

require("luasnip.session.snippet_collection").clear_snippets("vue")

return {
	s(
		"vue",
		fmt(
			[[
            <template>

            </template>

            <script lang="ts" setup>

            </script>

            <style lang="less" scoped>

            </style>
            ]],
			{}
		)
	),
}
