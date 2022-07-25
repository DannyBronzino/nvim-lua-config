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
  MiniJump2dSpot = { fg = colors.roninYellow, bold = true },
  YankyYanked = { link = "IncSearch" },
  YankyPut = { link = "IncSearch" },
}

require("kanagawa").setup({
  overrides = overrides,
  undercurl = true,
  transparent = true,
  globalstatus = true,
})

vim.cmd([[colorscheme kanagawa]])
