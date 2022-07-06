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
  ErrorMsg = { fg = colors.peachRed, undercurl = true },
  SpellBad = { fg = colors.peachRed, undercurl = true },
  SpellCap = { fg = colors.peachRed, undercurl = true },
  SpellRare = { fg = colors.peachRed, undercurl = true },
  SpellLocal = { fg = colors.peachRed, undercurl = true },
  String = { fg = colors.lightBlue },
  TelescopePreviewLine = { link = "Cursorline" },
  BufferTabPageFill = { bg = "none" },
  DiagnosticUnderlineError = { fg = colors.peachRed, undercurl = true },
  DiagnosticUnderlineWarn = { fg = colors.roninYellow, undercurl = true },
  DiagnosticUnderlineInfo = { fg = colors.roninYellow, undercurl = true },
  DiagnosticUnderlineHint = { fg = colors.roninYellow, undercurl = true },
}

require("kanagawa").setup({
  overrides = overrides,
  undercurl = true,
  transparent = true,
  diminactive = true,
  globalstatus = true,
})

vim.cmd([[colorscheme kanagawa]])
