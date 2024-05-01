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

local function visibility(index)
    return c(index, {
        t("public"),
        t("protected"),
        t("private"),
    })
end

local function static(index)
    return c(index, {
        t(""),
        t("static "),
    })
end

local function php_class_types(index)
    return c(index, {
        t("class"),
        t("interface"),
        t("enum"),
    })
end


local function fix_php_namespace()
    local plenary = require("plenary")

    local filename = vim.fn.expand('%:p')
    local filedir = vim.fs.dirname(vim.fn.expand('%:p'))

    local root_dir = require("lspconfig").util.root_pattern("composer.json", "README.md")(filename)

    local relative_path = plenary.path:new(filedir):make_relative(root_dir)

    local composer_exists = vim.fn.filereadable(root_dir .. "/composer.json")
    if composer_exists == 1 then
        local composer = vim.fn.json_decode(vim.fn.readfile(root_dir .. "/composer.json"))
        if composer == nil then
            return "IServ\\Foo"
        end

        if composer["autoload"] ~= nil and composer["autoload"]["psr-4"] ~= nil then
            local namespaces = composer["autoload"]["psr-4"]
            for namespace, path in pairs(namespaces) do
                if string.sub(relative_path, 1, string.len(path)) == path then
                    local composer_relative = string.sub(relative_path, string.len(path) + 1)
                    local local_namespace = string.gsub(composer_relative, '/', '\\')
                    return namespace .. local_namespace
                end
            end
        end

        if composer["autoload-dev"] ~= nil and composer["autoload-dev"]["psr-4"] ~= nil then
            local namespaces = composer["autoload-dev"]["psr-4"]
            for namespace, path in pairs(namespaces) do
                if string.sub(relative_path, 1, string.len(path)) == path then
                    local composer_relative = string.sub(relative_path, string.len(path) + 1)
                    local local_namespace = string.gsub(composer_relative, '/', '\\')
                    return namespace .. local_namespace
                end
            end
        end

        return "Foo\\Bar"
    else
        return "TODO" .. root_dir
    end
end

local function php_class_name()
    local filename = vim.fn.expand("%:r")

    return vim.fs.basename(filename)
end

ls.cleanup()

ls.add_snippets(nil, {
    all = {
    },

    php = {
        -- functions
        s('fn', fmt([[
            {} {}function {}({}): {}
            {{
                {}
            }}
            ]],
            { visibility(1), static(2), i(3, 'doStuff'), i(4), i(5, 'void'), i(0) }
        )),
        s('pvfn', fmt([[
            private function {}({}): void
            {{
                {}
            }}
            ]],
            { i(1, 'doStuff'), i(2), i(0) }
        )),
        s('tfn', fmt([[
            public function test{}(): void
            {{
                {}
            }}
            ]],
            { i(1, 'SomeUsecase'), i(0) }
        )),
        -- classes/file headers
        s('phpfile', fmt([[
            <?php

            declare(strict_types=1);

            namespace {};

            {} {}
            {{
                {}
            }}
            ]],
                { f(fix_php_namespace), php_class_types(1), f(php_class_name), i(0), }
            )
        ),
    },

    vue = {
        s('vue', fmt([[
            <template>

            </template>

            <script lang="ts" setup>

            </script>

            <style lang="less" scoped>

            </style>
            ]],
            {}
        )),
    }

})
