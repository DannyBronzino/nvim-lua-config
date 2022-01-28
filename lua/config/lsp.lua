local custom_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gr", "<cmd>Lspsaga rename<cr>", opts)
	buf_set_keymap("n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
	buf_set_keymap("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
	buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
	buf_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
	buf_set_keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	buf_set_keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	buf_set_keymap("n", "<C-p>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
	buf_set_keymap("n", "<C-n>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)
	-- Set some key bindings conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	else
		buf_set_keymap("n", "<space>f", "<cmd>Neoformat<CR>", opts)
	end
	if client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("x", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>", opts)
	end

	-- The blow command will highlight the current variable and its usages in the buffer.
	if client.resolved_capabilities.document_highlight then
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

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

-- set up texlab for latex
lspconfig.texlab.setup({
	on_attach = custom_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 500,
	},
	settings = {
		texlab = {
			chktex = {
				onEdit = true,
				onOpenAndSave = true,
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

-- Sumneko Lua LSP
-- https://gitub.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)h
local sumneko_root_path = vim.fn.getenv("HOME") .. "/repos/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
-- end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
	on_attach = custom_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
