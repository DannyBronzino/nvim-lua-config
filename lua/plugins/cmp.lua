local map = require("utils").map

return {
  -- snippet engine
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my_snippets" } })
      require("luasnip.loaders.from_lua").lazy_load()

      luasnip.filetype_extend("bibtex", { "latex" })

      luasnip.config.set_config({ enable_autosnippets = true })

      -- for changing choices in choiceNodes (not strictly necessary for a basic setup).
      map({ "i", "s" }, "<c-l>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-l>'", { expr = true })
    end,
  },

  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    init = function()
      vim.g.coq_settings = { auto_start = true }
    end,
  },

  {
    "ms-jpq/coq.artifacts",
    branch = "artifacts",
  },

  {
    "ms-jpq/coq.thirdparty",
    branch = "3p",
  },
}
