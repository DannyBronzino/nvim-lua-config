return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my_snippets" } })
      require("luasnip.loaders.from_lua").lazy_load()

      require("luasnip").filetype_extend("bibtex", { "latex" })

      require("luasnip").config.set_config({ enable_autosnippets = true })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      snippets = { preset = "luasnip" },
    },
  },
}
