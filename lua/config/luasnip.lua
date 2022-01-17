require("luasnip.loaders.from_vscode").lazy_load()

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

ls.config.set_config({ enable_autosnippets = true })

ls.autosnippets = {
	tex = {
		s({ trig = "...", name = "Ellipsis", dscr = "\\ldots{}" }, t("\\ldots{}")),

		-- use csquotes package
		s({ trig = "\\tq{", name = "Text Quote", dscr = "\\textquote" }, t("\\textquote{"), i(1), i(0), t("}")),

		-- add this to preamble: \newcommand{\chinesequote}[1]{$\lceil${#1}$\rfloor$}
		s({ trig = "\\cq{", name = "Chinese Quote", dscr = "\\chinesequote" }, t("\\chinesequote{"), i(1), i(0), t("}")),
	},
}
