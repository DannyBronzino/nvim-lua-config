vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.bib",
  callback = function()
    vim.opt.filetype = "bibtex"
  end,
  desc = "set *.bib files to ft = bibtex",
})
