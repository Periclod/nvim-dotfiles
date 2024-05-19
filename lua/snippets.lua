local ls = require("luasnip")

ls.cleanup()

local snip_dir = vim.api.nvim_get_runtime_file("lua/snippets", false)

require("luasnip.loaders.from_lua").load({ paths = snip_dir })
