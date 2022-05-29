require("pairs"):setup({
  pairs = {
    markdown = {
      -- { "'", "'", { ignore_pre = "\\w", ignore = "\\w'\\w" } },
      { "'", "'", { ignore_pre = "\\v(\\\\|\\S)" } }, -- use apostrophe without triggering double
    },
  },
  enter = {
    enable_mapping = false, -- for cmp
  },
  autojump_strategy = {
    unbalanced = "all", -- in ( { | } ), hitting ) will jump all the way out
  },
})
