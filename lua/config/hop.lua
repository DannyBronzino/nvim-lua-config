require("hop").setup({
  case_insensitive = true,
  char2_fallback_key = "<CR>",
  quit_key = "<esc>",
  multi_windows = true,
})

local map = require("utils").map

-- place this in one of your configuration file(s)
map("", "f", function()
  require("hop").hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
end, { desc = "replace f with one character hop" })

map("", "F", function()
  require("hop").hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
end, { desc = "replace F with one character hop" })

map("", "t", function()
  require("hop").hint_char1({
    direction = require("hop.hint").HintDirection.AFTER_CURSOR,
    hint_offset = -1,
  })
end, { desc = "replace t with one character hop" })

map("", "T", function()
  require("hop").hint_char1({
    direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
    hint_offset = 1,
  })
end, { desc = "replace T with one character hop" })
