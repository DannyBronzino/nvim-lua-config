local custom_attach = function(client, bufnr)
	-- easier syntax for mapping
	local function map(mode, lhs, rhs, opts)
		vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr })
	end

	-- mappings.
	map("n", "gh", "<cmd>Lspsaga signature_help<cr>")
	map("n", "gr", "<cmd>Lspsaga rename<cr>")
	map("n", "gx", "<cmd>Lspsaga code_action<cr>")
	map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>")
	map("n", "K", "<cmd>Lspsaga hover_doc<cr>")
	map("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>")
	map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>")
	map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
	map("n", "<c-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>")
	map("n", "<c-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>")
	-- Set some key bindings conditional on server capabilities
	if client.server_capabilities.document_formatting then
		map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
	else
		map("n", "<space>f", "<cmd>Neoformat<CR>")
	end
	if client.server_capabilities.document_range_formatting then
		map("x", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>")
	end

	-- The blow command will highlight the current variable and its usages in the buffer.
	if client.server_capabilities.document_highlight then
		vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
	end

	local msg = string.format("Language server %s started!", client.name)
	vim.notify(msg, "info", { title = "Nvim-config" })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require("lspconfig")

-- set up texlab for latex
lspconfig.texlab.setup({
	on_attach = custom_attach,
	capabilities = capabilities,
	settings = {
		texlab = {
			auxDirectory = ".",
			bibtexFormatter = "texlab",
			build = {
				args = { "%f", "-lualatex" },
				executable = "latexmk",
				forwardSearchAfter = false,
				onSave = false,
			},
			chktex = {
				onEdit = true,
				onOpenAndSave = true,
			},
			diagnosticsDelay = 500,
			formatterLineLength = 80,
			forwardSearch = {
				args = {},
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false,
			},
		},
	},
})

-- set up vim-language-server
lspconfig.vimls.setup({
	on_attach = custom_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 500,
	},
})

local luadev = require("lua-dev").setup({
	lspconfig = {
		on_attach = custom_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 500,
		},
	},
})

lspconfig.sumneko_lua.setup(luadev)

-- Sumneko Lua LSP
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- require("lspconfig").sumneko_lua.setup({
-- on_attach = custom_attach,
-- capabilities = capabilities,
-- flags = {
-- debounce_text_changes = 500,
-- },
-- settings = {
-- Lua = {
-- runtime = {
-- -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- version = "LuaJIT",
-- -- Setup your lua path
-- path = runtime_path,
-- },
-- diagnostics = {
-- -- Get the language server to recognize the `vim` global
-- globals = { "vim" },
-- },
-- workspace = {
-- -- Make the server aware of Neovim runtime files
-- library = vim.api.nvim_get_runtime_file("", true),
-- },
-- -- Do not send telemetry data containing a randomized but unique identifier
-- telemetry = {
-- enable = false,
-- },
-- },
-- },
-- })
