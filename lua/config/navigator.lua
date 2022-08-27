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
      require("navigator.reference").async_ref()
    end, { desc = "async reference" })
  end

  if providers.documentSymbolProvider then
    buf_map("n", "g0", function()
      require("navigator.symbols").document_symbols()
    end, { desc = "document symbols" })
  end

  if providers.workspaceSymbolProvider then
    buf_map("n", "gw", function()
      require("navigator.workspace").workspace_symbol_live()
    end, { desc = "workspace symbol live" })
  end

  if providers.definitionProvider then
    buf_map("n", "gd", function()
      require("navigator.definition").definition_preview()
    end, { desc = "definition preview" })
  end

  if providers.hoverProvider then
    buf_map("n", "K", function()
      vim.lsp.buf.hover()
    end, { desc = "hover" })
  end

  if providers.codeActionProvider then
    buf_map("n", "ga", function()
      require("navigator.codeAction").code_action()
    end, { desc = "code action" })
  end

  if providers.codeActionProvider then
    buf_map("v", "ga", function()
      require("navigator.codeAction").range_code_action()
    end, { desc = "range code action" })
  end

  if providers.renameProvider then
    buf_map("n", "<F2>", function()
      require("navigator.rename").rename()
    end, { desc = "rename" })
  end

  buf_map("n", "go", function()
    require("navigator.diagnostics").show_diagnostics()
  end, { desc = "show line diagnostics" })

  buf_map("n", "<space>d", function()
    require("navigator.diagnostics").show_buf_diagnostics()
  end, { desc = "show buffer diagnostics" })

  buf_map("n", "gj", function()
    vim.diagnostic.goto_next()
  end, { desc = "next diagnostic" })

  buf_map("n", "gk", function()
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

require("navigator").setup({
  debug = false,
  width = 0.75,
  height = 0.3,
  preview_height = 0.35, -- max height of preview windows
  border = "rounded",
  on_attach = on_attach,
  ts_fold = false,
  default_mapping = false,
  keymaps = {},
  treesitter_analysis = true,
  treesitter_analysis_max_num = 100,
  transparency = 50,
  lsp_signature_help = false, -- if you would like to hook ray-x/lsp_signature plugin in navigator
  -- setup here. if it is nil, navigator will not init signature help
  signature_help_cfg = nil, -- if you would like to init ray-x/lsp_signature plugin in navigator, and pass in your own config to signature help
  icons = {
    icons = true,
    code_action_icon = "",
    diagnostic_head = "🐯",
    diagnostic_err = "😿",
    diagnostic_warn = "🙀",
    diagnostic_info = [[🐱]],
    diagnostic_hint = [[😻]],
  },
  mason = true,
  lsp = {
    enable = true,
    code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = false },
    code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = false },
    format_on_save = false,
    disable_format_cap = {}, -- a list of lsp disable format capacity (e.g. if you using efm or vim-codeformat etc), empty {} by default
    disable_lsp = { "ltex" }, -- custom setup below
    diagnostic = {
      underline = true,
      virtual_text = false,
      update_in_insert = false,
    },
    diagnostic_scrollbar_sign = { "▃", "▆", "█" },
    diagnostic_virtual_text = false,
    diagnostic_update_in_insert = false,
    disply_diagnostic_qf = false,
    ctags = {
      cmd = "ctags",
      tagfile = "tags",
      options = "-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number",
    },
    texlab = {
      settings = {
        texlab = {
          chktex = {
            onEdit = true,
            onOpenAndSave = true,
          },
        },
      },
    },
  },
})

require("lspconfig").ltex.setup({
  on_attach = on_attach,
  filetypes = { "tex", "bib" },
  settings = {
    ltex = {
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-US",
      },
    },
  },
})
