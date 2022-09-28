local npairs = require("nvim-autopairs")
local cond = require("nvim-autopairs.conds")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
  check_ts = true,
  disable_filetype = { "guihua", "guihua_rust", "clap_input" },
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
