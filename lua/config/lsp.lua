require("nvim-lsp-installer").setup({
  automatic_installation = true, -- based on which servers are set up via lspconfig
  ensure_installed = { "texlab", "ltex" },
})

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  require("lspsaga").init_lsp_saga({
    -- "single" | "double" | "rounded" | "bold" | "plus"
    border_style = "single",
    -- Error, Warn, Info, Hint
    diagnostic_header = { "🙀", "😿", "😾", "😺" },
    -- use emoji lightbulb in default
    code_action_icon = "",
    symbol_in_winbar = {
      in_custom = false,
      enable = true,
      separator = " ",
      show_file = true,
    },
  })

  -- Change diagnostic signs.
  vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "ﴞ", texthl = "DiagnosticSignHint" })

  -- global config for diagnostic
  vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    signs = true,
    severity_sort = true,
  })

  -- mapping function
  local map = function(mode, left_hand_side, right_hand_side, opts)
    opts = opts or { silent = true }
    if opts.silent == nil then
      opts.silent = true
    end
    opts.buffer = bufnr
    return vim.keymap.set(mode, left_hand_side, right_hand_side, opts)
  end

  -- show definition
  if client.server_capabilities.definitionProvider then
    map("n", "gd", "<cmd>Lspsaga preview_definition<cr>")
  end

  -- rename
  if client.server_capabilities.renameProvider then
    map("n", "<F2>", "<cmd>Lspsaga rename<cr>")
  end

  -- code actions
  if client.server_capabilities.codeActionProvider then
    map("n", "ga", "<cmd>Lspsaga code_action<cr>")
    map("x", "ga", ":<c-u>Lspsaga range_code_action<cr>")
  end

  -- show hover docs
  if client.server_capabilities.hoverProvider then
    map("n", "K", "<cmd>Lspsaga hover_doc<cr>")
  end

  -- show signature help
  if client.server_capabilities.signatureHelpProvider then
    map("n", "<c-k>", "<cmd>Lspsaga signature_help<cr>")
  end

  -- show diagnostic
  map("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>")

  -- jump to next diagnostic and show
  map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>")

  -- jump to previous diagnostic and show
  map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>")

  -- use telescope to show workspace symbols
  if client.server_capabilities.workspaceSymbolProvider then
    map("n", "<leader>ft", function()
      require("telescope.builtin").lsp_dynamic_workspace_symbols(require("telescope.themes").get_dropdown({
        layout_config = {
          width = 0.5,
        },
      }))
    end, { desc = "displays workspace symbols using telescope" })
  end

  -- The below command will highlight the current variable and its usages in the buffer.
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

  -- send notification on server start
  local msg = string.format("Language server %s started!", client.name)
  vim.notify(msg, "info")
end

-- add additional completion capabilities from nvim-cmp
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

-- set up ltex for prose
require("ltex-ls").setup({
  on_attach = on_attach,
  capabilities = capabilities,
  use_spellfile = false,
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib" },
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
