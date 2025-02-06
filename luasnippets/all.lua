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

  s({ trig = "Grainne", name = "Gráinne", dscr = "Gráinne", wordTrig = false }, t("Gráinne")),

  -- for when you fat finger the shift key
  s(
    { trig = [[(%u)(%u+%l)]], regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. string.lower(snip.captures[2])
    end, {})
  ),
  -- for when you don't take your finger off the shift key on [[I'm]] fast enough
  s(
    { trig = [[(%w+)"(%w)]], regTrig = true },
    f(function(_, snip)
      return snip.captures[1] .. "'" .. snip.captures[2]
    end, {})
  ),
}, { type = "autosnippets" })

ls.add_snippets("all", {
  s({ trig = "loremSent", name = "Lorem Ipsum Sentence" }, {
    t("Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat."),
  }),
  s({ trig = "loremPara", name = "Lorem Ipsum Paragraph" }, {
    t(
      "Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis."
    ),
  }),
})
