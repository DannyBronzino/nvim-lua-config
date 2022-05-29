require("lspsaga").setup({
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-n>",
    scroll_up = "<C-p>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
})

require("nvim-lsp-installer").setup({
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})

require("lsp-format").setup()

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  -- Mappings.
  Map("n", "gd", "<cmd>Lspsaga lsp_finder<cr>")
  Map("n", "gi", "<cmd>Lspsaga implement<cr>")
  Map("n", "gh", "<cmd>Lspsaga signature_help<cr>")
  Map("n", "<F2>", "<cmd>Lspsaga rename<cr>")
  Map("n", "gx", "<cmd>Lspsaga code_action<cr>")
  Map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>")
  Map("n", "K", "<cmd>Lspsaga hover_doc<cr>")
  Map("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>")
  Map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>")
  Map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
  Map("n", "<c-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>")
  Map("n", "<c-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>")
  Map("n", "<leader>ft", function()
    require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_dropdown({
      layout_config = {
        width = 0.5,
      },
    }))
  end)

  -- for lsp-format
  require("lsp-format").on_attach(client)
  vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]

  -- Set some key bindings conditional on server capabilities
  -- if client.server_capabilities.document_formatting then
  -- Map("n", "<space>f", function()
  -- vim.lsp.buf.format()
  -- end)
  -- else
  -- Map("n", "<space>f", "<cmd>Neoformat<CR>")
  -- end
  -- if client.server_capabilities.document_range_formatting then
  -- Map("x", "<space>f", function()
  -- vim.lsp.buf.range_formatting()
  -- end)
  -- end

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

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "single",
        source = "always", -- show source in diagnostic popup window
        prefix = " ",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })

  vim.diagnostic.config({ virtual_text = false }) -- turn off virtual annotation

  local msg = string.format("Language server %s started!", client.name)
  vim.notify(msg, "info", { title = "Nvim-config" })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- set up texlab for latex
lspconfig.texlab.setup({
  on_attach = on_attach,
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
      build = {
        executable = "tectonic",
        args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
      },
    },
  },
})

-- Sumneko Lua LSP
require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
        neededFileStatus = {
          ["codestyle-check"] = "Any",
        },
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
}
