return {
  {
    "folke/noice.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          -- Render style
          render = "compact",
          -- Animation style
          stages = "slide",
          -- Default timeout for notifications
          timeout = 300,
        },
      },
    },
    config = function()
      require("noice").setup({
        popupmenu = {
          backend = "cmp",
        },
        commands = {
          history = {
            -- options for the message history that you get with `:Noice`
            view = "popup",
            opts = { wrap = true, enter = true, format = "details" },
          },
        },
        lsp = {
          progress = {
            enabled = false,
          },
          override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = true,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = true,
          },
        },
        views = {
          cmdline_popup = {
            position = {
              row = 0,
              col = "100%",
            },
            size = {
              width = "auto",
              height = "auto",
            },
          },
          popup = {
            position = {
              row = "100%",
              col = 0,
            },
            size = {
              width = "99%",
              height = "50%",
            },
          },
          hover = {
            view = "popup",
            relative = "cursor",
            zindex = 45,
            enter = false,
            anchor = "auto",
            size = {
              width = "auto",
              height = "auto",
              max_width = 60,
              max_height = 20,
            },
            border = {
              style = "rounded",
              padding = { 0, 0 },
            },
            position = { row = 2, col = 2 },
            win_options = {
              wrap = true,
              linebreak = true,
            },
          },
          mini = {
            position = { row = 0, col = "100%" },
          },
        },
      })

      local map = require("utils").map

      map("c", "<c-o>", function()
        require("noice").redirect(vim.fn.getcmdline())
      end, { desc = "Redirect Cmdline" })
    end,
  },
}
