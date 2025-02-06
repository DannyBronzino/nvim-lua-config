local map = require("utils").map

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
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
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
        },
        views = {
          cmdline_popup = {
            position = {
              row = 0,
              col = "100%",
            },
            size = {
              width = "66%",
              height = "auto",
            },
          },
          popup = {
            position = {
              row = "90%",
              col = "50%",
            },
            size = {
              width = "95%",
              height = "40%",
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
    end,
  },
}
