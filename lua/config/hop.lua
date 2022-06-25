require("hop").setup({
  case_insensitive = true,
  char2_fallback_key = "<CR>",
  quit_key = "<esc>",
  multi_windows = true,
  jump_on_sole_occurrence = true,
})

vim.opt.virtualedit = { "onemore" } -- enables operations to end of line

local map = require("utils").map

-- replace "t"
map({ "n", "o", "v" }, "t", function()
  require("hop").hint_char1({ inclusive_jump = false, hint_offset = -1 })
end, { desc = "replaces t with one character hop" })

-- replace "f"
map({ "n", "o", "v" }, "f", function()
  require("hop").hint_char1({ inclusive_jump = true })
end, { desc = "replaces f with one character hop" })

-- two character search
map({ "n", "o", "v" }, "s", function()
  require("hop").hint_char2()
end)
