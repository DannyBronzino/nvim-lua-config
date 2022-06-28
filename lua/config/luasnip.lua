local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my_snippets" } })
require("luasnip.loaders.from_lua").lazy_load()

luasnip.filetype_extend("bib", { "tex" })

luasnip.config.set_config({ enable_autosnippets = true })
