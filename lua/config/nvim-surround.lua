local api = vim.api
local autocmd = vim.api.nvim_create_autocmd

-- nvim-surround tex commands
autocmd({ "BufEnter" }, {
  pattern = { "*.tex", "*.bib" },
  group = api.nvim_create_augroup("tex_file", { clear = true }),
  callback = function()
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
  end,
  desc = "loads latex only surrounds",
})
require("nvim-surround").setup()
