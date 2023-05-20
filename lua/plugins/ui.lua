local map = require("utils").map

vim.api.nvim_create_autocmd("Colorscheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "BufferTabPageFill", {})
  end,
})

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      Palette = require("catppuccin.palettes").get_palette() -- return vim.g.catppuccin_flavour palette

      require("catppuccin").setup({
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        transparent_background = true,
        term_colors = true,
        compile = {
          enabled = true,
          path = vim.fn.stdpath("cache") .. "/catppuccin",
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = false,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "bold" },
              hints = { "bold" },
              warnings = { "bold" },
              information = { "bold" },
            },
          },
          cmp = false,
          gitsigns = true,
          leap = true,
          barbar = true,
          markdown = true,
          notify = true,
          which_key = true,
          mason = true,
          noice = true,
          mini = true,
          barbecue = {
            dim_dirname = true,
            bold_basename = true,
            dim_context = false,
          },
        },
        color_overrides = {},
        custom_highlights = {
          Comment = { fg = Palette.subtext0 },
          LineNr = { fg = Palette.overlay2 },
          DiagnosticUnderlineError = { fg = Palette.rosewater, italic = true, bold = true },
          DiagnosticUnderlineHint = { fg = Palette.rosewater, italic = true, bold = true },
          DiagnosticUnderlineWarn = { fg = Palette.rosewater, italic = true, bold = true },
          DiagnosticUnderlineInfo = { fg = Palette.rosewater, italic = true, bold = true },
          String = { fg = Palette.rosewater },
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      -- show word count
      local function get_words()
        return tostring(vim.fn.wordcount().words .. " words")
      end

      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              "mode",
              -- fmt = function(str)
              -- return str:sub(1, 1)
              -- end,
            },
          },
          lualine_b = {
            { "b:gitsigns_head", icon = "" },
            { "diff", source = diff_source },
          },
          lualine_c = {},
          lualine_x = {
            { get_words },
            {
              "filetype",
              icon_only = true,
            },
          },
          lualine_y = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
            },
            "location",
            "progress",
          },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {
          "quickfix",
          "fzf",
        },
      })
    end,
  },

  -- tab bar and buffer switching
  {
    "romgrk/barbar.nvim",
    lazy = false,
    config = function()
      -- Move to previous/next
      map("n", "<A-,>", "<cmd>BufferPrevious<CR>")
      map("n", "<A-.>", "<cmd>BufferNext<CR>")
      -- nostalgic combo
      map("n", "gB", "<cmd>BufferPrevious<CR>")
      map("n", "gb", "<cmd>BufferNext<CR>")
      -- Re-order to previous/next
      map("n", "<A-<>", "<cmd>BufferMovePrevious<CR>")
      map("n", "<A->>", " <cmd>BufferMoveNext<CR>")
      -- Pin/unpin buffer
      map("n", "<A-p>", "<Cmd>BufferPin<CR>")
      -- buffer picker
      map("n", "<C-p>", "<Cmd>BufferPick<CR>")
      -- Goto buffer in position...
      map("n", "<A-1>", "<cmd>BufferGoto 1<CR>")
      map("n", "<A-2>", "<cmd>BufferGoto 2<CR>")
      map("n", "<A-3>", "<cmd>BufferGoto 3<CR>")
      map("n", "<A-4>", "<cmd>BufferGoto 4<CR>")
      map("n", "<A-5>", "<cmd>BufferGoto 5<CR>")
      map("n", "<A-6>", "<cmd>BufferGoto 6<CR>")
      map("n", "<A-7>", "<cmd>BufferGoto 7<CR>")
      map("n", "<A-8>", "<cmd>BufferGoto 8<CR>")
      map("n", "<A-9>", "<cmd>BufferGoto 9<CR>")
      map("n", "<A-0>", "<cmd>BufferLast<CR>")
      -- Close buffer
      map("n", "<A-c>", "<cmd>BufferClose<CR>")

      vim.api.nvim_set_hl(0, "BufferTabPageFill", {})
      -- Set barbar's options
      require("bufferline").setup({
        icons = {
          button = "",
        },
      })
    end,
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {
      theme = "catppuccin",
      show_dirname = false,
      show_basename = false,
    },
  },

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
        cmdline = {
          enabled = false,
        },
        popupmenu = {
          backend = "nui",
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
            ["cmp.entry.get_documentation"] = false,
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

      map("c", "<c-o>", function()
        require("noice").redirect(vim.fn.getcmdline())
        local key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
        vim.api.nvim_feedkeys(key, "n", true)
      end, { desc = "Redirect Cmdline" })
    end,
  },

  {
    "gelguy/wilder.nvim",
    dependencies = "romgrk/fzy-lua-native",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
      -- Disable Python remote plugin
      wilder.set_option("use_python_remote_plugin", 0)

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
          highlighter = wilder.lua_fzy_highlighter(),
          highlights = {
            accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = Palette.red } }),
          },
          left = {
            " ",
            wilder.popupmenu_devicons(),
          },
          right = {
            " ",
            wilder.popupmenu_scrollbar(),
          },
          -- 'single', 'double', 'rounded' or 'solid'
          -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
          border = "rounded",
          max_height = "75%", -- max height of the palette
          min_height = 0, -- set to the same as 'max_height' for a fixed height window
          prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
          reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
        }))
      )
    end,
  },
}
