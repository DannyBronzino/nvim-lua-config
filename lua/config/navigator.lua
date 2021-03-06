require("nvim-lsp-installer").setup({
  ensure_installed = { "texlab", "ltex" },
})

require("navigator").setup({
  debug = false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
  width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
  height = 0.3, -- max list window height, 0.3 by default
  preview_height = 0.35, -- max height of preview windows
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, can be one of 'none', 'single', 'double',
  -- 'shadow', or a list of chars which defines the border
  on_attach = function(client, bufnr)
    require("nvim-navic").attach(client, bufnr)

    local map = require("utils").map

    if client.server_capabilities.workspaceSymbolProvider then
      map("n", "<leader>ft", function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols(require("telescope.themes").get_dropdown({
          layout_config = {
            width = 0.5,
          },
        }))
      end, { desc = "displays workspace symbols using telescope" })
    end

    -- send notification on server start
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, "info")
  end,
  -- put a on_attach of your own here, e.g
  -- function(client, bufnr)
  --   -- the on_attach will be called at end of navigator on_attach
  -- end,
  -- The attach code will apply to all LSP clients

  default_mapping = false, -- set to false if you will remap every key or if you using old version of nvim-
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
  treesitter_analysis = true, -- treesitter variable context
  treesitter_analysis_max_num = 100, -- how many items to run treesitter analysis
  -- this value prevent slow in large projects, e.g. found 100000 reference in a project
  transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it

  lsp_signature_help = false, -- if you would like to hook ray-x/lsp_signature plugin in navigator
  -- setup here. if it is nil, navigator will not init signature help
  signature_help_cfg = nil, -- if you would like to init ray-x/lsp_signature plugin in navigator, and pass in your own config to signature help
  icons = {
    -- Code action
    code_action_icon = "🏏", -- note: need terminal support, for those not support unicode, might crash
    -- Diagnostics
    diagnostic_head = "🐛",
    diagnostic_head_severity_1 = "🈲",
    -- refer to lua/navigator.lua for more icons setups
  },
  lsp_installer = true, -- set to true if you would like use the lsp installed by williamboman/nvim-lsp-installer
  lsp = {
    enable = true, -- skip lsp setup if disabled make sure add require('navigator.lspclient.mapping').setup() in you
    -- own on_attach
    code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = false },
    code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = false },
    format_on_save = false, -- set to false to disable lsp code format on save (if you are using prettier/efm/formater etc)
    disable_format_cap = {}, -- a list of lsp disable format capacity (e.g. if you using efm or vim-codeformat etc), empty {} by default
    disable_lsp = { "ltex" }, -- a list of lsp server disabled for your project, e.g. denols and tsserver you may
    -- only want to enable one lsp server
    -- to disable all default config and use your own lsp setup set
    -- disable_lsp = 'all'
    -- Default {}
    diagnostic = {
      underline = false,
      virtual_text = false, -- show virtual for diagnostic message
      update_in_insert = false, -- update diagnostic message in insert mode
    },
    diagnostic_scrollbar_sign = { "▃", "▆", "█" }, -- experimental:  diagnostic status in scroll bar area; set to false to disable the diagnostic sign,
    -- for other style, set to {'╍', 'ﮆ'} or {'-', '='}
    diagnostic_virtual_text = false, -- show virtual for diagnostic message
    diagnostic_update_in_insert = false, -- update diagnostic message in insert mode
    disply_diagnostic_qf = false, -- always show quickfix if there are diagnostic errors, set to false if you  want to ignore it
    servers = {}, -- by default empty, and it should load all LSP clients avalible based on filetype
    -- but if you whant navigator load  e.g. `cmake` and `ltex` for you , you
    -- can put them in the `servers` list and navigator will auto load them.
    -- you could still specify the custom config  like this
    -- cmake = {filetypes = {'cmake', 'makefile'}, single_file_support = false},
    ctags = {
      cmd = "ctags",
      tagfile = "tags",
      options = "-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number",
    },
  },
})

require("ltex-ls").setup({
  on_attach = function(client, bufnr)
    require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr })
    -- send notification on server start
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, "info")
  end,
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
