local map = require("utils").map

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = true,
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {
            "texlab",
            "ltex-ls-plus",
            "bibtex-tidy",
            "latexindent",
          },
          auto_update = true,
          run_on_start = true,
          start_delay = 0,
        },
      },
      "barreiroleo/ltex_extra.nvim",
      {

        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
      },
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        float = {
          border = "rounded",
        },
      })

      local on_attach = function(client, bufnr)
        local abilities = client.server_capabilities

        local buf_map = function(mode, left_hand_side, right_hand_side, opts)
          opts.buffer = bufnr

          return require("utils").map(mode, left_hand_side, right_hand_side, opts)
        end

        -- local fzf = require("fzf-lua")

        -- if abilities.referencesProvider then
        -- buf_map("n", "gr", function()
        -- fzf.lsp_references({ winopts = { preview = { hidden = "nohidden" } } })
        -- end, { desc = "async reference" })
        -- end

        -- if abilities.documentSymbolProvider then
        -- buf_map("n", "g0", function()
        -- fzf.lsp_document_symbols()
        -- end, { desc = "document symbols" })
        -- end

        -- if abilities.workspaceSymbolProvider then
        -- buf_map("n", "<leader>g0", function()
        -- fzf.lsp_workspace_symbols()
        -- end, { desc = "workspace symbol live" })
        -- end

        -- if abilities.definitionProvider then
        -- buf_map("n", "gd", function()
        -- fzf.lsp_definitions({ winopts = { preview = { hidden = "nohidden" } } })
        -- end, { desc = "definition preview" })
        -- end

        if abilities.hoverProvider then
          buf_map("n", "K", function()
            vim.lsp.buf.hover()
          end, { desc = "hover" })
        end

        if abilities.codeActionProvider then
          buf_map("n", "ga", function()
            vim.lsp.buf.code_action()
            -- fzf.lsp_code_actions({ winopts = { height = 0.33, width = 0.4 } })
          end, { desc = "show code action" })
        end

        buf_map("n", "go", function()
          vim.diagnostic.open_float({ scope = "cursor" })
        end, { desc = "show cursor diagnostics" })

        buf_map("n", "gO", function()
          vim.diagnostic.open_float({ scope = "line" })
        end, { desc = "show cursor diagnostics" })

        buf_map(
          "n",
          "<space>d",
          "<cmd>Trouble diagnostics toggle focus = false<cr>",
          { desc = "show buffer diagnostics" }
        )

        if abilities.documentFormattingProvider then
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

      local capabilities = require("blink.cmp").get_lsp_capabilities({
        textDocument = { completion = { completionItem = { snippetSupport = true } } },
      })

      vim.lsp.enable("texlab")

      vim.lsp.config("texlab", {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "tex", "bibtex" },
        settings = {
          texlab = {
            chktex = {
              onEdit = false,
              onOpenAndSave = false,
            },
          },
        },
      })

      require("ltex_extra").setup({
        load_langs = { "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
        init_check = true, -- boolean : whether to load dictionaries on startup
        path = ".ltex", -- string : path to store dictionaries. Relative path uses current working directory
        server_opts = {
          cmd = { "ltex-ls-plus" },
          on_attach = on_attach,
          capabilities = capabilities,
          filetypes = { "tex", "bibtex" },
          settings = {
            ltex = {
              additionalRules = {
                enablePickyRules = true,
                motherTongue = "en-US",
              },
            },
          },
        },
      })
    end,
  },
}
