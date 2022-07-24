-- use find_files if not in git project
local project_files = function(opts)
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

local map = require("utils").map

map("n", "<leader><space>", function()
  require("telescope.builtin").buffers()
end, { desc = "display open buffers with telescope" })

map("n", "<leader>ff", function()
  project_files(require("telescope.themes").get_dropdown({ layout_config = { width = 0.5 } }))
end, { desc = "display project files with telescope" })

map("n", "<leader>fb", function()
  require("telescope.builtin").current_buffer_fuzzy_find({ layout_strategy = "bottom_pane" })
end, { desc = "current buffer fuzzy find with telescope" })

map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags({ layout_strategy = "bottom_pane" })
end, { desc = "display help topics with telescope" })

map("n", "<leader>fd", function()
  require("telescope.builtin").grep_string({ layout_strategy = "bottom_pane" })
end, { desc = "grep string with telescope" })

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep({ layout_strategy = "bottom_pane" })
end, { desc = "live grep with telescope" })

map("n", "<leader>?", function()
  require("telescope.builtin").oldfiles({ layout_strategy = "bottom_pane" })
end, { desc = "display recent files with telescope" })
