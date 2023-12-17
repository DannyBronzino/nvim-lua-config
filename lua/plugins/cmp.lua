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

  -- completion engine
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = {
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<c-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<c-o>"] = cmp.mapping.confirm({ select = true }),
          ["<c-e>"] = cmp.mapping.abort(),
          ["<c-f>"] = cmp.mapping.scroll_docs(3),
          ["<c-d>"] = cmp.mapping.scroll_docs(-3),
        }),
        sources = cmp.config.sources({
          { name = "async_path" }, -- for path completion
          -- { name = "buffer", keyword_length = 2 },
          -- { name = "luasnip" }, -- for luasnip
          {
            name = "latex_symbols",
            option = {
              strategy = 0, -- mixed
            },
          },
        }),
        completion = {
          completeopt = "menu,noselect",
        },
        experimental = {
          ghost_text = { hl_group = "String" }, -- adds ghost text that completes the word in buffer
          -- for some reason this needs to be a table right now
        },
        formatting = {
          format = lspkind.cmp_format({
            -- with_text = true,
            mode = "symbol",
            menu = {
              omni = "[Omni]",
              luasnip = "[Snip]",
              nvim_lsp = "[LSP]",
              async_path = "[Path]",
              buffer = "[Buffer]",
              latex_symbols = "[Symbol]",
              -- digraphs = "[Digraphs]",
            },
          }),
        },
      })

      cmp.setup.filetype({ "latex", "bibtex" }, {
        sources = {
          { name = "nvim_lsp" },
          -- { name = "omni" },
          { name = "luasnip" }, -- for luasnip
          -- { name = "buffer", keyword_length = 2 },
          { name = "async_path" }, -- for path completion
          {
            name = "latex_symbols",
            option = {
              strategy = 0, -- mixed
            },
          },
          -- { name = "digraphs" }, -- accented characters and the like that are inputed with <c-k>
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "async_path" },
          { name = "cmdline" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, { -- search completion
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
    end,
  },

  { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },

  { "dmitmel/cmp-digraphs", event = "InsertEnter", enabled = false },

  { "kdheepak/cmp-latex-symbols", event = "InsertEnter" },

  { "FelipeLema/cmp-async-path", event = { "InsertEnter", "CmdLineEnter" } },

  { "hrsh7th/cmp-cmdline", event = "CmdLineEnter" },

  { "hrsh7th/cmp-buffer", event = { "InsertEnter", "CmdLineEnter" } },

  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
}
