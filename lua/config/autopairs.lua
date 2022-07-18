local map = require("utils").map
local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
})
