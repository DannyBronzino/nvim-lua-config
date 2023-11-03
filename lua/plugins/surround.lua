return {
  -- surround stuff
  {
    "kylechui/nvim-surround",
    enabled = false,
    config = function()
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

      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "yz",
          normal_cur = "yzz",
          normal_line = "yZ",
          normal_cur_line = "yZZ",
          visual = "Z",
          visual_line = "gZ",
          delete = "dz",
          change = "cz",
        },
      })
    end,
  },
}
