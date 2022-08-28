-- lua sources
require("plugins")
require("options")
require("globals")
require("mappings")
require("autocmds")

-- global functions

---pretty print table or function result
---@param item function|table
function Inspect(item)
  vim.pretty_print(item)
end

-- join all non-blank lines
function Join_lines()
  vim.cmd([[%!fmt -999]])
end
