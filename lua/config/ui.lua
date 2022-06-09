local colors = require("kanagawa.colors").setup()
local overrides = {
  -- overide existing highlights
  WhichKeyValue = { fg = colors.crystalBlue },
  LineNr = { fg = colors.dragonBlue },
  Comment = { fg = colors.springBlue },
  Visual = { bg = colors.waveBlue2 },
  IncSearch = { bg = colors.oniViolet },
  MatchParen = { fg = colors.sakuraPink, style = "bold" }, -- for vim-matchup
  Error = { fg = colors.peachRed, style = "bold" },
  ErrorMsg = { fg = colors.peachRed, style = "bold" },
  SpellBad = { fg = colors.peachRed, style = "bold" },
  SpellCap = { fg = colors.peachRed, style = "bold" },
  SpellRare = { fg = colors.peachRed, style = "bold" },
  SpellLocal = { fg = colors.peachRed, style = "bold" },
  String = { fg = colors.lightBlue },
  TelescopePreviewLine = { link = "Cursorline" },
  BufferTabPageFill = { bg = "none" },
}

require("kanagawa").setup({
  overrides = overrides,
  transparent = true,
  diminactive = true,
  globalstatus = true,
})

vim.g.sonokai_style = "andromeda"
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_better_performance = 1

require("github-theme").setup({
  dark_float = true,
})

vim.cmd([[colorscheme github_dimmed]])

vim.api.nvim_create_autocmd("Colorscheme", {
  callback = function()
    -- change lualine colorscheme
    require("lualine").setup({
      options = {
        theme = "auto",
      },
    })
    vim.cmd([[hi BufferTabPageFill ctermbg=none guibg=none]])
  end,
  desc = "changes lualine colorscheme when nvim colorscheme changes",
})

-- displays spell indicator
local function spell()
  if vim.o.spell then
    return string.format("SPELL")
  end

  return ""
end

-- show word count
local function get_words()
  return tostring(vim.fn.wordcount().words .. " words")
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "kanagawa",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      "diff",
    },
    lualine_c = { "filename" },
    lualine_x = {
      { spell, color = "WarningMsg" },
      { get_words },
      "filetype",
    },
    lualine_y = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
      },
      "location",
    },
    lualine_z = { "progress" },
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
  extensions = {
    "quickfix",
    "fugitive",
    -- "nvim-tree",
  },
})
