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
  ErrorMsg = { fg = colors.peachRed, undercurl = false },
  SpellBad = { fg = colors.peachRed, undercurl = false },
  SpellCap = { fg = colors.peachRed, undercurl = false },
  SpellRare = { fg = colors.peachRed, undercurl = false },
  SpellLocal = { fg = colors.peachRed, undercurl = false },
  String = { fg = colors.lightBlue },
  TelescopePreviewLine = { link = "Cursorline" },
  BufferTabPageFill = { bg = "none" },
  DiagnosticUnderlineError = { fg = colors.peachRed, undercurl = false },
  DiagnosticUnderlineWarn = { fg = colors.roninYellow, undercurl = false },
  DiagnosticUnderlineInfo = { fg = colors.roninYellow, undercurl = false },
  DiagnosticUnderlineHint = { fg = colors.roninYellow, undercurl = false },
  NavicIconsModule = { fg = colors.oniViolet },
  NavicText = { fg = colors.crystalBlue },
  MiniJump2dSpot = { fg = colors.roninYellow, bold = true },
  YankyYanked = { link = "IncSearch" },
  YankyPut = { link = "IncSearch" },
}

require("kanagawa").setup({
  overrides = overrides,
  undercurl = false,
  transparent = true,
  diminactive = true,
  globalstatus = true,
})

vim.cmd([[colorscheme kanagawa]])
