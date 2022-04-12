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
local utils = require("utils")

ls.add_snippets("tex", {
	s("trig", {
		i(1),
		f(function(args, snip, user_arg_1)
			return args[1][1] .. user_arg_1
		end, { 1 }, { user_args = { "Will be appended to text from i(0)" } }),
		i(0),
	}),
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
			results = utils.rtrim(utils.ltrim(string.gsub(args[1][1], [[\\]], [[]]))) -- backslashes and trim whitespace

			for count = 2, #args[1] do
				local old_line = results
				local new_line = utils.rtrim(utils.ltrim(string.gsub(args[1][count], [[\\]], [[]])))

				-- measures length and passes longer string
				if #old_line < #new_line then
					old_line = new_line
				end
				results = old_line -- the winner
			end

			-- snippet to return
			local snip = sn(nil, { t(results) })
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
	s({ trig = "...", name = "Ellipsis", dscr = "\\ldots{}", wordTrig = false }, t("\\ldots{}")),

	-- use csquotes package
	s({ trig = "\\tq", name = "Text Quote", dscr = "\\textquote" }, { t("\\textquote{"), i(1), i(0), t("}") }),

	-- add this to preampble: \newcommand{\mentalquote}[1]{«{#1}»}
	s({ trig = "\\mq", name = "Mental Quote", dscr = "\\mentalquote" }, { t("\\mentalquote{"), i(1), i(0), t("}") }),

	s({ trig = "Qing", name = "Qīng", dscr = "Qīng", wordTrig = false }, t("Qīng")),

	s({ trig = "Therese", name = "Thérèse", dscr = "Thérèse", wordTrig = false }, t("Thérèse")),
}, { type = "autosnippets" })
