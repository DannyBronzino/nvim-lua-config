-- lua sources
require("plugins")
require("options")
require("globals")
require("mappings")
require("autocmds")

-- global functions

-- join all non-blank lines
function Join_lines()
  vim.cmd([[%!fmt -999]])
end
