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
		{ name = "nvim_lsp", keyword_length = 2, priority = 99 }, -- For nvim-lsp
		{ name = "nvim_lua", keyword_length = 2, priority = 100 }, -- for nvim lua function
		{ name = "latex_symbols", keyword_length = 2, max_item_count = 3, priority = 10 }, -- easy enter latex symbols
		{ name = "digraphs", keyword_length = 2, priority = 80 },
		{ name = "luasnip", keyword_length = 2, priority = 90 }, -- For luasnips user.
		{ name = "rg", keyword_length = 2, max_item_count = 5, priority = 80 }, -- ripgrep completion
		-- { name = "buffer" }, -- for buffer word completion (try rg instead)
		{ name = "spell", keyword_length = 3 }, -- for spelling
		{ name = "path", keyword_length = 1 }, -- for path completion
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
			with_text = false,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				latex_symbols = "[LaTeX]",
				digraphs = "[Digraph]",
				luasnip = "[Snip]",
				path = "[Path]",
				rg = "[RG]",
				buffer = "[Buffer]",
				spell = "[Spell]",
			},
		}),
	},
})

-- cmdline completion like wilder
require("cmp").setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
		{ name = "path" },
	},
	-- view = {
	-- entries = "wildmenu",
	-- },
})

-- search completion
require("cmp").setup.cmdline("/", {
	sources = {
		{ name = "buffer", keyword_length = 3 },
	},
	view = {
		entries = "wildmenu",
	},
})

-- reverse search completion
require("cmp").setup.cmdline("?", {
	sources = {
		{ name = "buffer", keyword_length = 3 },
	},
	view = {
		entries = "wildmenu",
	},
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

vim.cmd("hi link CmpItemMenu Comment")
