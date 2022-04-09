local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")
local kind = cmp.lsp.CompletionItemKind

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
	mapping = {
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
		["<CR>"] = cmp.mapping(function(fallback)
			if not cmp.confirm({ select = false }) then
				require("pairs.enter").type()
			end
		end),
		["<c-p>"] = cmp.mapping.scroll_docs(-3),
		["<c-n>"] = cmp.mapping.scroll_docs(3),
	},
	sources = {
		{ name = "luasnip" }, -- for luasnip
		{ name = "nvim_lsp_signature_help" }, -- for lsp signature help
		{ name = "nvim_lsp" }, -- for nvim-lsp
		{ name = "nvim_lua" }, -- for nvim lua function
		{ -- ripgrep completion
			name = "rg",
			max_item_count = 6,
			option = {
				additional_arguments = "--smart-case",
				context_before = 2,
				context_after = 4,
			},
		},
		{ name = "digraphs" }, -- accented characters and the like that are inputed with <c-k>
		{ name = "path" }, -- for path completion
		{ name = "spell" }, -- for spelling
	},
	completion = {
		keyword_length = 1,
	},
	experimental = {
		ghost_text = true, -- adds ghost text that completes the word in buffer
	},
	formatting = {
		format = lspkind.cmp_format({
			-- with_text = true,
			mode = "symbol_text",
			menu = {
				luasnip = "[Snip]",
				nvim_lua = "[Lua]",
				nvim_lsp_signature_help = "[Help]",
				nvim_lsp = "[LSP]",
				rg = "[RG]",
				digraphs = "[Digraphs]",
				path = "[Path]",
				spell = "[Spell]",
			},
		}),
	},
})
cmp.event:on("confirm_done", function(event)
	local item = event.entry:get_completion_item()
	local parensDisabled = item.data and item.data.funcParensDisabled or false
	if not parensDisabled and (item.kind == kind.Method or item.kind == kind.Function) then
		require("pairs.bracket").type_left("(")
	end
end)

cmp.setup.cmdline(":", { -- cmdline completion like wilder
	sources = {
		{ name = "cmdline" },
		-- { name = "nvim_lua" },
		{ name = "path" },
	},
})

cmp.setup.cmdline("/", { -- search completion
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline("?", { -- reverse search completion
	sources = {
		{ name = "buffer" },
	},
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
