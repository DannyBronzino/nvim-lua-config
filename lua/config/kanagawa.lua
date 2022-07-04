local colors = require("kanagawa.colors").setup()
local overrides = {
  -- overide existing highlights
  WhichKeyValue = { fg = colors.crystalBlue },
  LineNr = { fg = colors.dragonBlue },
  Comment = { fg = colors.springBlue },
  Visual = { bg = colors.waveBlue2 },
  IncSearch = { bg = colors.oniViolet },
  MatchParen = { fg = colors.sakuraPink, bold = true }, -- for vim-matchup
  Error = { fg = colors.peachRed, bold = true },
  ErrorMsg = { fg = colors.peachRed, bold = true },
  SpellBad = { fg = colors.peachRed, bold = true },
  SpellCap = { fg = colors.peachRed, bold = true },
  SpellRare = { fg = colors.peachRed, bold = true },
  SpellLocal = { fg = colors.peachRed, bold = true },
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

vim.cmd([[colorscheme kanagawa]])
