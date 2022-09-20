vim.g.catppuccin_flavour = "mocha"
local colors = require("catppuccin.palettes").get_palette() -- return vim.g.catppuccin_flavour palette

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
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "reverse" },
        hints = { "reverse" },
        warnings = { "reverse" },
        information = { "reverse" },
      },
    },
    coc_nvim = false,
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    leap = false,
    telescope = false,
    nvimtree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    neotree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = true,
    bufferline = false,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = true,
    notify = true,
    telekasten = false,
    symbols_outline = false,
    mini = false,
    aerial = false,
    vimwiki = false,
    beacon = false,
    navic = false,
    overseer = false,
  },
  color_overrides = {},
  custom_highlights = {
    WhichKeyValue = { fg = colors.rosewater },
    WhichKeyDesc = { fg = colors.flamingo },
    -- Visual = { fg = colors.surface0, bg = colors.maroon },
    Comment = { fg = colors.subtext0 },
    -- LeapLabelPrimary = { fg = colors.surface0, bg = colors.pink },
    -- LeapMatch = { fg = colors.pink, bg = colors.surface0 },
  },
})

vim.cmd([[colorscheme catppuccin]])

vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
  },
})
