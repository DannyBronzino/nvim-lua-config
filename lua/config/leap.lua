require("leap").setup({
  max_aot_targets = nil,
  highlight_unlabeled = false,
  case_sensitive = false,
  -- Sets of characters that should match each other.
  -- Obvious candidates are braces and quotes ('([{', ')]}', '`"\'').
  equivalence_classes = { " \t\r\n" },
  special_keys = {
    repeat_search = "<enter>",
    next_aot_match = "<enter>",
    next_match = { ";", "<enter>" },
    prev_match = { ",", "<tab>" },
    next_group = "<space>",
    prev_group = "<tab>",
  },
})

local map = require("utils").map

map("n", "gs", function()
  require("leap").leap({
    target_windows = vim.tbl_filter(function(win)
      return vim.api.nvim_win_get_config(win).focusable
    end, vim.api.nvim_tabpage_list_wins(0)),
  })
end, { desc = "search in all windows (including the current one) on the tab page." })

require("leap").set_default_keymaps()
