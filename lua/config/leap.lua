local map = require("utils").map

map("n", "gs", function()
  require("leap").leap({
    target_windows = vim.tbl_filter(function(win)
      return vim.api.nvim_win_get_config(win).focusable
    end, vim.api.nvim_tabpage_list_wins(0)),
  })
end, { desc = "search in all windows (including the current one) on the tab page." })

require("leap").set_default_keymaps()
