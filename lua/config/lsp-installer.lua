local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
	"texlab",
	"sumneko_lua",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found and not server:is_installed() then
		print("Installing " .. name)
		server:install()
	end
end

local on_attach = function(client, bufnr)
	-- easier syntax for mapping
	local map = require("utils").map

	-- Mappings.
	map("n", "gi", "<cmd>Lspsaga implement<cr>")
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

local enhance_server_opts = {
	-- Provide settings that should only apply to the "eslint" server
	["texlab"] = function(opts)
		opts.settings = {
			texlab = {
				chktex = {
					onEdit = true,
					onOpenAndSave = true,
				},
			},
		}
	end,
}

lsp_installer.on_server_ready(function(server)
	-- Specify the default options which we'll use to setup all servers
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if enhance_server_opts[server.name] then
		-- Enhance the default opts with the server-specific ones
		enhance_server_opts[server.name](opts)
	end

	server:setup(opts)
end)
