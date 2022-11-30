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

vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
  },
})

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  local capabilities = client.server_capabilities

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

  local fzf = require("fzf-lua")

  if capabilities.referencesProvider then
    buf_map("n", "gr", function()
      fzf.lsp_references({ winopts = { preview = { hidden = "nohidden" } } })
    end, { desc = "async reference" })
  end

  if capabilities.documentSymbolProvider then
    buf_map("n", "g0", function()
      fzf.lsp_document_symbols({ fzf_cli_args = "--with-nth 2.." })
    end, { desc = "document symbols" })
  end

  if capabilities.workspaceSymbolProvider then
    buf_map("n", "<leader>g0", function()
      fzf.lsp_workspace_symbols({ fzf_cli_args = "--with-nth 2.." })
    end, { desc = "workspace symbol live" })
  end

  if capabilities.definitionProvider then
    buf_map("n", "gd", function()
      fzf.lsp_definitions({ winopts = { preview = { hidden = "nohidden" } } })
    end, { desc = "definition preview" })
  end

  if capabilities.hoverProvider then
    buf_map("n", "K", function()
      vim.lsp.buf.hover()
    end, { desc = "hover" })
  end

  if capabilities.codeActionProvider then
    buf_map("n", "ga", function()
      -- vim.lsp.buf.code_action()
      fzf.lsp_code_actions({ winopts = { height = 0.33, width = 0.4 } })
    end, { desc = "show code action" })
  end

  buf_map("n", "go", function()
    vim.diagnostic.open_float({ scope = "cursor" })
  end, { desc = "show cursor diagnostics" })

  buf_map("n", "gO", function()
    vim.diagnostic.open_float({ scope = "line" })
  end, { desc = "show cursor diagnostics" })

  buf_map("n", "<space>d", function()
    fzf.diagnostics_document({ fzf_cli_args = "--delimiter=':' --with-nth='2..'" })
  end, { desc = "show buffer diagnostics" })

  buf_map("n", "gn", function()
    vim.diagnostic.goto_next()
  end, { desc = "next diagnostic" })

  buf_map("n", "gp", function()
    vim.diagnostic.goto_prev()
  end, { desc = "previous diagnostic" })

  if capabilities.documentFormattingProvider then
    buf_map("n", "<Space>f", function()
      vim.lsp.buf.format()
    end, { desc = "format" })
  end

  -- if capabilities.renameProvider then
  -- buf_map("n", "<F2>", function()
  -- vim.lsp.buf.rename()
  -- end, { desc = "rename" })
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
        onEdit = false,
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
      -- checkFrequency = "save",
    },
  },
})
