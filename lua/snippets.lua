local ls = require("luasnip")

ls.cleanup()

ls.add_snippets("yaml", require("snippets.yaml"))

local snip_dir = vim.api.nvim_get_runtime_file("lua/snippets", true)

require("luasnip.loaders.from_lua").load({ paths = snip_dir })
