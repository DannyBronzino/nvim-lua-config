-- LSP mappings found in config.lspconfig

local fzf = require("fzf-lua")

local files_git_or_cwd = function()
  -- version 2: uses `git ls-files` for git dirs
  -- change to `false` if you'd like to see a message when not in a git repo
  local opts = { winopts = { height = 0.66, width = 0.5 } }

  if fzf.path.is_git_repo(vim.loop.cwd(), true) then
    fzf.git_files(opts)
  else
    fzf.files(opts)
  end
end

local map = require("utils").map

map("n", "<leader>ff", function()
  files_git_or_cwd()
end, { desc = "find files with fzf" })

map("n", "<leader><space>", function()
  fzf.buffers({ winopts = { height = 0.66, width = 0.5 } })
end, { desc = "show buffers with fzf" })

map("n", "gw", function()
  fzf.grep_cword({ fzf_cli_args = "--with-nth 1.." })
end, { desc = "grep for word under cursor with fzf" })

map("n", "gW", function()
  fzf.grep_cWORD({ fzf_cli_args = "--with-nth 1.." })
end, { desc = "grep for word under cursor with fzf" })

map("n", "<leader>gp", function()
  fzf.grep_project({ fzf_cli_args = "--with-nth 1.." })
end, { desc = "live grep current project with fzf" })

map("n", "<leader>gb", function()
  fzf.grep_curbuf()
end, { desc = "live grep current buffer with fzf" })

map("n", '<space>"', function()
  fzf.registers()
end, { desc = "show registers with fzf" })

map("n", "<space>'", function()
  fzf.marks()
end, { desc = "show marks with fzf" })

map("n", "<space>h", function()
  fzf.help_tags()
end, { desc = "show help tags with fzf" })
