-- refer to https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("bib", {
  s({
    trig = "misc",
    name = "Miscellaneous Reference",
  }, {
    t("@misc{"),
    i(1, "citekey"),
    t({ "", "" }),
    t("\tauthor={"),
    i(2, "author"),
    t({ "},", "" }),
    t("\ttitle={"),
    i(3, "title"),
    t({ "},", "" }),
    t("\thowpublished={"),
    i(4, "how published"),
    t({ "},", "" }),
    t("\tdate={"),
    i(4, "date"),
    t({ "},", "" }),
    t("\tnote={"),
    i(5, "note"),
    t({ "},", "" }),
    t("\tannote={"),
    i(6, "annote"),
    t({ "},", "" }),
    t("\turl={"),
    i(7, "url"),
    t({ "},", "" }),
    i(0),
  }),
})
