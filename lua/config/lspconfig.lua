require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "texlab",
    "ltex-ls",
  },
  auto_update = true,
  run_on_start = true,
  start_delay = 0,
})

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local providers = client.server_capabilities

  if client.name == "ltex" then
    require("ltex_extra").setup({
      load_langs = { "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
      init_check = true, -- boolean : whether to load dictionaries on startup
      path = nil, -- string : path to store dictionaries. Relative path uses current working directory
      log_level = "none", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
    })
  end

  local buf_map = function(mode, left_hand_side, right_hand_side, opts)
    opts.buffer = bufnr

    return require("utils").map(mode, left_hand_side, right_hand_side, opts)
  end

  if providers.referencesProvider then
    buf_map("n", "gr", function()
      require("fzf-lua").lsp_references({ winopts = { preview = { hidden = "nohidden" } } })
    end, { desc = "async reference" })
  end

  if providers.documentSymbolProvider then
    buf_map("n", "g0", function()
      require("fzf-lua").lsp_document_symbols({ fzf_cli_args = "--with-nth 2.." })
    end, { desc = "document symbols" })
  end

  if providers.workspaceSymbolProvider then
    buf_map("n", "gp", function()
      require("fzf-lua").lsp_workspace_symbols({ fzf_cli_args = "--with-nth 2.." })
    end, { desc = "workspace symbol live" })
  end

  if providers.definitionProvider then
    buf_map("n", "gd", function()
      require("fzf-lua").lsp_definitions({ winopts = { preview = { hidden = "nohidden" } } })
    end, { desc = "definition preview" })
  end

  if providers.hoverProvider then
    buf_map("n", "K", function()
      vim.lsp.buf.hover()
    end, { desc = "hover" })
  end

  if providers.codeActionProvider then
    buf_map("n", "ga", function()
      vim.lsp.buf.code_action()
    end, { desc = "show code action" })
  end

  buf_map("n", "go", function()
    vim.diagnostic.open_float({ scope = "cursor" })
  end, { desc = "show cursor diagnostics" })

  buf_map("n", "gO", function()
    vim.diagnostic.open_float({ scope = "line" })
  end, { desc = "show cursor diagnostics" })

  buf_map("n", "<space>d", function()
    require("fzf-lua").diagnostics_document()
  end, { desc = "show buffer diagnostics" })

  buf_map("n", "<c-n>", function()
    vim.diagnostic.goto_next()
  end, { desc = "next diagnostic" })

  buf_map("n", "<c-p>", function()
    vim.diagnostic.goto_prev()
  end, { desc = "previous diagnostic" })

  if providers.documentFormattingProvider then
    buf_map("n", "<Space>f", function()
      vim.lsp.buf.format()
    end, { desc = "format" })
  end

  -- if providers.documentSymbolProvider then
  -- require("nvim-navic").attach(client, bufnr)
  -- end

  -- send notification on server start
  local msg = string.format("Language server %s started!", client.name)
  vim.notify(msg, "info")
end

lspconfig.texlab.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "tex", "bib" },
  settings = {
    texlab = {
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
    },
  },
})

lspconfig.ltex.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "tex", "bib" },
  settings = {
    ltex = {
      additionalRules = {
        enablePickyRules = false,
        motherTongue = "en-US",
      },
    },
  },
})
