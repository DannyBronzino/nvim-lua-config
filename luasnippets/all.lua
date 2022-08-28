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
local utils = require("utils")

ls.add_snippets("all", {
  s({ trig = "Qing", name = "Qīng", dscr = "Qīng", wordTrig = false }, t("Qīng")),

  s({ trig = "Therese", name = "Thérèse", dscr = "Thérèse", wordTrig = false }, t("Thérèse")),

  -- for when you fat finger the shift key
  s(
    { trig = "(%u)(%u+%l)", regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. string.lower(snip.captures[2])
    end, {})
  ),
}, { type = "autosnippets" })
