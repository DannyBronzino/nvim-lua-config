return {
  -- colorscheme based on hokusai
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    name = "kanagawa",
    config = function()
      local colors = require("kanagawa.colors").setup()
      local overrides = {
        -- overide existing highlights
        WhichKeyValue = { fg = colors.crystalBlue },
        LineNr = { fg = colors.dragonBlue },
        Comment = { fg = colors.springBlue },
        Visual = { bg = colors.waveBlue2 },
        IncSearch = { bg = colors.oniViolet },
        MatchParen = { fg = colors.sakuraPink }, -- for vim-matchup
        Error = { fg = colors.peachRed },
        ErrorMsg = { fg = colors.peachRed },
        SpellBad = { fg = colors.peachRed },
        SpellCap = { fg = colors.peachRed },
        SpellRare = { fg = colors.peachRed },
        SpellLocal = { fg = colors.peachRed },
        String = { fg = colors.lightBlue },
        TelescopePreviewLine = { link = "Cursorline" },
        BufferTabPageFill = { bg = "none" },
        DiagnosticUnderlineError = { fg = colors.peachRed },
        DiagnosticUnderlineWarn = { fg = colors.roninYellow },
        DiagnosticUnderlineInfo = { fg = colors.roninYellow },
        DiagnosticUnderlineHint = { fg = colors.roninYellow },
        -- NavicIconsModule = { fg = colors.oniViolet },
        -- NavicText = { fg = colors.crystalBlue },
        MiniJump2dSpot = { fg = colors.surimiOrange, undercurl = true },
        YankyYanked = { link = "IncSearch" },
        YankyPut = { link = "IncSearch" },
        LeapLabelPrimary = { fg = colors.sumiInk1, bg = colors.surimiOrange },
        LeapMatch = { fg = colors.surimiOrange },
      }

      require("kanagawa").setup({
        overrides = overrides,
        undercurl = true,
        transparent = true,
        globalstatus = true,
      })
    end,
  },

  {
    "rmehri01/onenord.nvim",
    lazy = true,
    name = "onenord",
    config = function()
      local colors = require("onenord.colors").load()

      require("onenord").setup({
        theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
        borders = true, -- Split window borders
        fade_nc = false, -- Fade non-current windows, making them more distinguishable
        -- Style that is applied to various groups: see `highlight-args` for options
        styles = {
          comments = "italic",
          strings = "NONE",
          keywords = "NONE",
          functions = "NONE",
          variables = "NONE",
          diagnostics = "underline",
        },
        disable = {
          background = true, -- Disable setting the background color
          cursorline = false, -- Disable the cursorline
          eob_lines = true, -- Hide the end-of-buffer lines
        },
        -- Inverse highlight for different groups
        inverse = {
          match_paren = false,
        },
        custom_highlights = {
          -- Normal = { fg = colors.fg_light },
          WhichKeyValue = { fg = colors.fg },
          WhichKeyDesc = { fg = colors.yellow },
          BufferTabPageFill = {},
          Visual = { fg = colors.bg, bg = colors.light_purple },
          Comment = { fg = colors.orange },
          MiniJump2dSpot = { fg = colors.light_green },
          YankyYanked = { fg = colors.bg, bg = colors.light_purple },
          YankyPut = { link = "YankyYanked" },
          LeapLabelPrimary = { fg = colors.bg, bg = colors.light_green },
          LeapMatch = { fg = colors.light_green },
        }, -- Overwrite default highlight groups
        custom_colors = {}, -- Overwrite default colors
      })
    end,
  },

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
        term_colors = false,
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
          cmp = true,
          gitsigns = true,
          leap = true,
          barbar = true,
          markdown = true,
          notify = true,
          which_key = true,
        },
        color_overrides = {},
        custom_highlights = {
          -- WhichKeyValue = { fg = Palette.rosewater },
          -- WhichKeyDesc = { fg = Palette.flamingo },
          -- Visual = { fg = colors.surface0, bg = colors.maroon },
          Comment = { fg = Palette.subtext0 },
          -- LeapLabelPrimary = { bg = "none", fg = Palette.pink, bold = true },
          -- LeapMatch = { fg = Palette.teal, bg = "none", bold = true },
          LineNr = { fg = Palette.overlay2 },
          DiagnosticUnderlineError = { fg = Palette.rosewater, italic = true, bold = true },
          DiagnosticUnderlineHint = { fg = Palette.rosewater, italic = true, bold = true },
          DiagnosticUnderlineWarn = { fg = Palette.rosewater, italic = true, bold = true },
          DiagnosticUnderlineInfo = { fg = Palette.rosewater, italic = true, bold = true },
          MiniTrailspace = { bg = Palette.red },
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
          icons_enabled = false,
          theme = "catppuccin",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            { "b:gitsigns_head", icon = "" },
            { "diff", source = diff_source },
          },
          lualine_c = { "filename" },
          lualine_x = {
            { get_words },
            "filetype",
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
        tabline = {},
        winbar = {},
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
      local map = require("utils").map

      -- Move to previous/next
      map("n", "<A-,>", ":BufferPrevious<CR>")
      map("n", "<A-.>", ":BufferNext<CR>")
      -- nostalgic combo
      map("n", "gB", ":BufferPrevious<CR>")
      map("n", "gb", ":BufferNext<CR>")
      -- Re-order to previous/next
      map("n", "<A-<>", ":BufferMovePrevious<CR>")
      map("n", "<A->>", " :BufferMoveNext<CR>")
      -- Goto buffer in position...
      map("n", "<A-1>", ":BufferGoto 1<CR>")
      map("n", "<A-2>", ":BufferGoto 2<CR>")
      map("n", "<A-3>", ":BufferGoto 3<CR>")
      map("n", "<A-4>", ":BufferGoto 4<CR>")
      map("n", "<A-5>", ":BufferGoto 5<CR>")
      map("n", "<A-6>", ":BufferGoto 6<CR>")
      map("n", "<A-7>", ":BufferGoto 7<CR>")
      map("n", "<A-8>", ":BufferGoto 8<CR>")
      map("n", "<A-9>", ":BufferGoto 9<CR>")
      map("n", "<A-0>", ":BufferLast<CR>")
      -- Close buffer
      map("n", "<A-c>", ":BufferClose<CR>")
      -- Wipeout buffer
      --                 :BufferWipeout<CR>
      -- Close commands
      --                 :BufferCloseAllButCurrent<CR>
      --                 :BufferCloseBuffersLeft<CR>
      --                 :BufferCloseBuffersRight<CR>
      -- Magic buffer-picking mode
      -- map("n", "<C-p>", ":BufferPick<CR>")
      -- Sort automatically by...
      map("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>")
      map("n", "<Space>bd", ":BufferOrderByDirectory<CR>")
      map("n", "<Space>bl", ":BufferOrderByLanguage<CR>")

      -- Set barbar's options
      require("bufferline").setup({
        -- Enable/disable animations
        animation = true,

        -- Enable/disable auto-hiding the tab bar when there is a single buffer
        auto_hide = false,

        -- Enable/disable current/total tabpages indicator (top right corner)
        tabpages = true,

        -- Enable/disable close button
        closable = false,

        -- Enables/disable clickable tabs
        --  - left-click: go to buffer
        --  - middle-click: delete buffer
        clickable = true,

        -- Excludes buffers from the tabline
        exclude_ft = { "qf", "NvimTree", "gitcommit", "Packer" },
        exclude_name = { "package.json" },

        -- Enable/disable icons
        -- if set to 'numbers', will show buffer index in the tabline
        -- if set to 'both', will show buffer index and icons in the tabline
        icons = true,

        -- If set, the icon color will follow its corresponding buffer
        -- highlight group. By default, the Buffer*Icon group is linked to the
        -- Buffer* group (see Highlighting below). Otherwise, it will take its
        -- default value as defined by devicons.
        icon_custom_colors = true,

        -- Configure icons on the bufferline.
        icon_separator_active = "▎",
        icon_separator_inactive = "▎",
        icon_close_tab = "",
        icon_close_tab_modified = "●",
        icon_pinned = "車",

        -- If true, new buffers will be inserted at the start/end of the list.
        -- Default is to insert after current buffer.
        insert_at_end = false,
        insert_at_start = false,

        -- Sets the maximum padding width with which to surround each tab
        maximum_padding = 1,

        -- Sets the maximum buffer name length.
        maximum_length = 30,

        -- If set, the letters for each buffer in buffer-pick mode will be
        -- assigned based on their name. Otherwise or in case all letters are
        -- already assigned, the behavior is to assign letters in order of
        -- usability (see order below)
        semantic_letters = true,

        -- New buffer letters are assigned in this order. This order is
        -- optimal for the qwerty keyboard layout but might need adjustement
        -- for other layouts.
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

        -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
        -- where X is the buffer number. But only a static string is accepted here.
        no_name_title = nil,
      })

      vim.api.nvim_set_hl(0, "BufferTabPageFill", {})
    end,
  },
}
