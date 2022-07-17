local luasnip = require("luasnip")
local map = require("utils").map
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my_snippets" } })
require("luasnip.loaders.from_lua").lazy_load()

luasnip.filetype_extend("bib", { "tex" })

luasnip.config.set_config({ enable_autosnippets = true })

map("i", "<c-n>", function()
  require("luasnip").jump(1)
end)

map("i", "<c-p>", function()
  require("luasnip").jump(-1)
end)

map("s", "<c-n>", function()
  require("luasnip").jump(1)
end)

map("s", "<c-p>", function()
  require("luasnip").jump(-1)
end)

-- for changing choices in choiceNodes (not strictly necessary for a basic setup).
map({ "i", "s" }, "<c-l>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-l>'", { expr = true })
