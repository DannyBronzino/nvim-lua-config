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
local color_palette = {
  rosewater = "#F5E0DC",
  flamingo = "#F2CDCD",
  pink = "#F5C2E7",
  mauve = "#CBA6F7",
  red = "#F38BA8",
  maroon = "#EBA0AC",
  peach = "#FAB387",
  yellow = "#F9E2AF",
  green = "#A6E3A1",
  teal = "#94E2D5",
  sky = "#89DCEB",
  sapphire = "#74C7EC",
  blue = "#89B4FA",
  lavender = "#B4BEFE",

  text = "#CDD6F4",
  subtext1 = "#BAC2DE",
  subtext0 = "#A6ADC8",
  overlay2 = "#9399B2",
  overlay1 = "#7F849C",
  overlay0 = "#6C7086",
  surface2 = "#585B70",
  surface1 = "#45475A",
  surface0 = "#313244",

  base = "#1E1E2E",
  mantle = "#181825",
  crust = "#11111B",
}
