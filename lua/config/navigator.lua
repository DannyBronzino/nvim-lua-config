require("navigator").setup({
  debug = false,
  width = 0.75,
  height = 0.3,
  preview_height = 0.35, -- max height of preview windows
  border = "rounded",
  default_mapping = false,
  keymaps = {
    { key = "gr", func = require("navigator.reference").async_ref, desc = "async reference" },
    { key = "g0", func = require("navigator.symbols").document_symbols, desc = "document symbols" },
    { key = "gw", func = require("navigator.workspace").workspace_symbol_live, desc = "workspace symbol live" },
    { key = "gd", func = require("navigator.definition").definition_preview, desc = "definition preview" },
    { key = "K", func = vim.lsp.buf.hover, desc = "hover" },
    { key = "ga", mode = "n", func = require("navigator.codeAction").code_action, desc = "code action" },
    {
      key = "ga",
      mode = "v",
      func = require("navigator.codeAction").range_code_action,
      desc = "range code action",
    },
    { key = "<F2>", func = require("navigator.rename").rename, desc = "rename" },
    { key = "go", func = require("navigator.diagnostics").show_diagnostics, desc = "show line diagnostics" },
    {
      key = "<space>d",
      func = require("navigator.diagnostics").show_buf_diagnostics,
      desc = "show buffer diagnostics",
    },
    { key = "gj", func = vim.diagnostic.goto_next, desc = "next diagnostic" },
    { key = "gk", func = vim.diagnostic.goto_prev, desc = "previous diagnostic" },
    { key = "<Space>f", func = vim.lsp.buf.format, mode = "n", desc = "format" },
    { key = "<Space>f", func = vim.lsp.buf.range_formatting, mode = "v", desc = "range format" },
  },
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
  lsp_installer = true, -- set to true if you would like use the lsp installed by williamboman/nvim-lsp-installer
  lsp = {
    enable = true,
    code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = false },
    code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = false },
    format_on_save = false,
    disable_format_cap = {}, -- a list of lsp disable format capacity (e.g. if you using efm or vim-codeformat etc), empty {} by default
    disable_lsp = { "ltex", "texlab" },
    diagnostic = {
      underline = true,
      virtual_text = false,
      update_in_insert = false,
    },
    diagnostic_scrollbar_sign = { "▃", "▆", "█" },
    diagnostic_virtual_text = false,
    diagnostic_update_in_insert = false,
    disply_diagnostic_qf = true,
    ctags = {
      cmd = "ctags",
      tagfile = "tags",
      options = "-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number",
    },
  },
})

local on_attach = function(client, bufnr)
  require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr })
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  -- send notification on server start
  local msg = string.format("Language server %s started!", client.name)
  vim.notify(msg, "info")
end

-- manual setup for texlab
require("lspconfig").texlab.setup({
  on_attach = on_attach,
  settings = {
    texlab = {
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
    },
  },
})

-- manual setup for ltex
require("ltex-ls").setup({
  on_attach = on_attach,
  use_spellfile = false,
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib", "markdown" },
      language = "en-US",
      diagnosticSeverity = "information",
      sentenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en",
      },
      disabledRules = {},
      dictionary = (function()
        -- For dictionary, search for files in the runtime to have
        -- and include them as externals the format for them is
        -- dict/{LANG}.txt
        --
        -- Also add dict/default.txt to all of them
        local files = {}
        for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
          local lang = vim.fn.fnamemodify(file, ":t:r")
          local fullpath = vim.fs.normalize(file, ":p")
          files[lang] = { ":" .. fullpath }
        end

        if files.default then
          for lang, _ in pairs(files) do
            if lang ~= "default" then
              vim.list_extend(files[lang], files.default)
            end
          end
          files.default = nil
        end
        return files
      end)(),
    },
  },
})
