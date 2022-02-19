local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

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
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<Esc>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-p>"] = cmp.mapping.scroll_docs(-3),
		["<C-n>"] = cmp.mapping.scroll_docs(3),
	},
	sources = {
		{ name = "luasnip" }, -- for luasnip
		{ name = "nvim_lua" }, -- for nvim lua function
		{ name = "nvim_lsp" }, -- for nvim-lsp
		{ name = "rg" }, -- ripgrep completion
		{ name = "digraphs" },
		-- { name = "buffer" }, -- for buffer word completion (try rg instead)
		{ name = "path" }, -- for path completion
		-- { name = "latex_symbols", keyword_length = 4, max_item_count = 3 }, -- easy enter latex symbols
		{ name = "spell" }, -- for spelling
	},
	completion = {
		-- keyword_length = 2,
		completeopt = "menu,noselect",
	},
	experimental = {
		ghost_text = true, -- adds ghost text that completes the word in buffer
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				-- latex_symbols = "[LaTeX]",
				digraphs = "[Digraph]",
				luasnip = "[Snip]",
				path = "[Path]",
				rg = "[RG]",
				-- buffer = "[Buffer]",
				spell = "[Spell]",
			},
		}),
	},
})

-- cmdline completion like wilder
cmp.setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
		{ name = "path" },
	},
	-- view = {
	-- entries = "wildmenu",
	-- },
})

-- search completion
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
	-- view = {
	-- entries = "wildmenu",
	-- },
})

cmp.setup.cmdline("?", {
	sources = {
		{ name = "buffer" },
	},
	-- view = {
	-- entries = "wildmenu",
	-- },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

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
