local map = require("utils").map

map("n", "<c-t>", function()
  require("fzf-lua").files()
end, { desc = "search files with fzf" })

map("n", "<leader>b", function()
  require("fzf-lua").buffers()
end, { desc = "show buffers with fzf" })

map("n", "<leader>fp", function()
  require("fzf-lua").lsp_workspace_symbols({ fzf_cli_args = "--with-nth 2.." })
end, { desc = "show workspace symbols with fzf" })

map("n", "<leader>fd", function()
  require("fzf-lua").lsp_document_symbols({ fzf_cli_args = "--with-nth 2.." })
end, { desc = "show document symbols with fzf" })

map("n", "<leader>gw", function()
  require("fzf-lua").grep_cword()
end, { desc = "grep for current word with fzf" })

map("n", "<leader>gp", function()
  require("fzf-lua").grep_project()
end, { desc = "Live grep current project with fzf" })

map("n", "<leader>gb", function()
  require("fzf-lua").grep_curbuf()
end, { desc = "Live grep current buffer with fzf" })

map("n", "<leader><space>", function()
  require("fzf-lua").oldfiles()
end, { desc = "show list of old files with fzf" })
