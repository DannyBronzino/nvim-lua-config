vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 0
vim.opt_local.foldlevel = 99

-- vim.opt_local.foldmethod = "syntax"
require("nvim-surround").buffer_setup({
  surrounds = {
    ["c"] = {
      add = function()
        local cmd = require("nvim-surround.config").get_input("Command: ")
        return { { "\\" .. cmd .. "{" }, { "}" } }
      end,
    },
    ["e"] = {
      add = function()
        local env = require("nvim-surround.config").get_input("Environment: ")
        return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
      end,
    },
  },
})
