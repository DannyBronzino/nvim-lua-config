vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tex",
  callback = function()
    vim.opt.filetype = "tex"
  end,
  desc = "set *.tex files to ft = latex",
})
