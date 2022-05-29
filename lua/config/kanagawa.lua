local colors = require("kanagawa.colors").setup()

local overrides = {
  -- overide existing highlights
  WhichKeyValue = { fg = colors.crystalBlue },
  LineNr = { fg = colors.dragonBlue },
  Comment = { fg = colors.springBlue },
  Visual = { bg = colors.waveBlue2 },
  IncSearch = { bg = colors.oniViolet },
  MatchParen = { fg = colors.sakuraPink, style = "bold" }, -- for vim-matchup
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
