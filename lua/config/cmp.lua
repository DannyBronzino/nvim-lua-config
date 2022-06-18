local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my_snippets" } })
require("luasnip.loaders.from_lua").lazy_load()

luasnip.filetype_extend("bib", { "tex" })

luasnip.config.set_config({ enable_autosnippets = true })

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
    ["<Tab>"] = cmp.mapping(function(fallback)
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

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Esc>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<c-p>"] = cmp.mapping.scroll_docs(-3),
    ["<c-n>"] = cmp.mapping.scroll_docs(3),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" }, -- for luasnip
    -- { name = "nvim_lsp" }, -- for nvim-lsp
    { -- ripgrep completion
      name = "rg",
      max_item_count = 3,
      option = {
        additional_arguments = "--smart-case",
        context_before = 3,
        context_after = 3,
      },
    },
    { name = "path" }, -- for path completion
    { name = "latex_symbols", max_item_count = 3 },
    -- { name = "digraphs" }, -- accented characters and the like that are inputed with <c-k>
    { name = "spell" }, -- for spelling
  }),
  completion = {
    keyword_length = 1,
  },
  experimental = {
    ghost_text = true, -- adds ghost text that completes the word in buffer
  },
  formatting = {
    format = lspkind.cmp_format({
      -- with_text = true,
      mode = "symbol",
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lsp_signature_help = "[Help]",
        luasnip = "[Snip]",
        rg = "[RG]",
        path = "[Path]",
        latex_symbols = "[Symbols]",
        -- digraphs = "[Digraphs]",
        spell = "[Spell]",
      },
    }),
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.cmdline("/", { -- search completion
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

cmp.setup.cmdline("?", { -- reverse search completion
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
vim.cmd([[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
