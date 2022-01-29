local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require("lspkind")

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
		{ name = "nvim_lsp" }, -- For nvim-lsp
		{ name = "nvim_lua" }, -- for nvim lua function
		{ name = "latex_symbols" },
		{ name = "luasnip" }, -- For luasnips user.
		{ name = "buffer" }, -- for buffer word completion
		{ name = "spell" }, -- for spelling
		{ name = "path" }, -- for path completion
	},
	completion = {
		keyword_length = 1,
		completeopt = "menu,noselect",
	},
	experimental = {
		ghost_text = true, -- adds ghost text that completes the word in buffer
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				latex_symbols = "[LaTeX]",
				luasnip = "[Snip]",
				path = "[Path]",
				buffer = "[Buffer]",
				spell = "[Spell]",
			},
		}),
	},
})

require("cmp").setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
		{ name = "path" },
	},
})

require("cmp").setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

require("cmp").setup.cmdline("?", {
	sources = {
		{ name = "buffer" },
	},
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

vim.cmd("hi link CmpItemMenu Comment")
