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

ls.add_snippets("tex", {
  s({
    trig = "autocite",
    name = "Full Autocite",
  }, {
    t("\\autocite["),
    i(1, "prenote"),
    t("]["),
    i(2, "postnote"),
    t("]{"),
    i(3, "citemark"),
    t("}"),
    i(0),
  }),
  s({ -- requires verse or memoir package
    trig = "verse",
    name = "Verse Formatting",
  }, {
    t("\\settowidth{\\versewidth}["),
    d(2, function(args)
      Results = utils.rtrim(utils.ltrim(string.gsub(args[1][1], [[\\]], [[]]))) -- backslashes and trim whitespace

      for count = 2, #args[1] do
        local old_line = Results
        local new_line = utils.rtrim(utils.ltrim(string.gsub(args[1][count], [[\\]], [[]])))

        -- measures length and passes longer string
        if #old_line < #new_line then
          old_line = new_line
        end
        Results = old_line -- the winner
      end

      -- snippet to return
      local snip = sn(nil, { t(Results) })
      return snip
    end, { 1 }),
    t({
      "]",
      "",
      "\\begin{verse}{\\versewidth}",
      "",
      "\t\\begin{altverse}",
      "",
      "\t\t",
    }),
    i(1, "VERSES"),
    t({ "", "", "\t\\end{altverse}", "", "", "\\end{verse}", "", "\\citedpoemauthorright{" }),
    i(3, "author"),
    t("}{"),
    i(4, "citemark"),
    t("}"),
    i(0),
  }),
})

ls.add_snippets("tex", {
  -- s({ trig = "...", name = "Ellipsis", dscr = "\\ldots{}", wordTrig = false }, t("\\ldots{}")),

  s(
    { trig = [[(%w*)%.%.%.]], regTrig = true },
    f(function(_, snip)
      local ellipsis = [[\ldots{}]]
      if string.match(snip.captures[1], [[%w+]]) then
        return snip.captures[1] .. " " .. ellipsis
      else
        return ellipsis
      end
    end, {})
  ),
  -- use csquotes package
  s({ trig = "\\tq", name = "Text Quote", dscr = "\\textquote" }, { t("\\textquote{"), i(1), t("}"), i(2) }),

  -- add this to preampble: \newcommand{\mentalquote}[1]{«{#1}»}
  s({ trig = "\\mq", name = "Mental Quote", dscr = "\\mentalquote" }, { t("\\mentalquote{"), i(1), t("}", i(0)) }),
}, { type = "autosnippets" })
