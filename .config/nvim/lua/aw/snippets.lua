local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
--local f = ls.function_node
--local sn = ls.snippet_node
--local isn = ls.indent_snippet_node
--local c = ls.choice_node
--local d = ls.dynamic_node
--local events = require("luasnip.util.events")

local python_snippets = {
    s('__name', t { 'if __name__=="__main__":', '    pass' }),
}

local code_fence = s({
    trig = '```',
    name = 'code fence',
}, {
    t { '```{' },
    i(1),
    t('}', i(0)),
    t '```',
})

local markdown_or_vimwiki = {
    s('link', {
        t '[',
        i(1),
        t '](',
        i(2),
        t ')',
        i(0),
    }),
    code_fence,
}

-- union of two tables
local function union(a, b)
    local result = {}
    for k, v in pairs(a) do
        table.insert(result, v)
    end
    for k, v in pairs(b) do
        table.insert(result, v)
    end
    return result
end

-- merges two snippet tables (doesn't check any keys/values of the second layer, only first).
local function merge_snippet_tables(t1, t2)
    for k, v in pairs(t1) do
        if t2[k] ~= nil then
            t1[k] = union(t1[k], t2[k])
        end
    end
    for k, v in pairs(t2) do
        if t1[k] == nil then
            t1[k] = t2[k]
        end
    end
    return t1
end

local snippets_to_return = {
    python = python_snippets,
    markdown = markdown_or_vimwiki,
    vimwiki = markdown_or_vimwiki,
    quarto = markdown_or_vimwiki,
}

local function load_unversioned_snippets()
    require 'my-unversioned-snippets'
end

if pcall(load_unversioned_snippets) then
    return merge_snippet_tables(snippets_to_return, require 'my-unversioned-snippets')
else
    return snippets_to_return
end
