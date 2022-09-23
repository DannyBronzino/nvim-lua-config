require("hop").setup({
  keys = "etovxqpdygfblzhckisuran",
  create_hl_autocmd = false,
  multi_windows = true,
})

local map = require("utils").map

map("", "s", function()
  require("hop").hint_char2()
end, { desc = "2-char hop" })

-- place this in one of your configuration file(s)
map("", "f", function()
  require("hop").hint_char1({
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
  })
end, { desc = "1-char 'f' hop" })

map("", "F", function()
  require("hop").hint_char1({
    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
  })
end, { desc = "1-char 'F' hop" })

map("", "t", function()
  require("hop").hint_char1({
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
    hint_offset = -1,
  })
end, { desc = "1-char 't' hop" })

map("", "T", function()
  require("hop").hint_char1({
    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
    hint_offset = 1,
  })
end, { desc = "1-char 'T' hop" })
