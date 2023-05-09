local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- set numbers to relative when in Normal mode, absolute when in Insert
local number_toggle = augroup("number_toggle", { clear = true })

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.opt.number:get() == true then
      vim.opt.relativenumber = true
    end
  end,
  group = number_toggle,
  desc = "set numbers to relative when entering Normal mode",
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.opt.number:get() == true then
      vim.opt.relativenumber = false
    end
  end,
  group = number_toggle,
  desc = "set numbers to absolute when entering Insert mode",
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  -- you can create the group here instead
  group = augroup("YankHighlight", { clear = true }),
  pattern = "*",
  desc = "highlights on yank",
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
  desc = "creates missing directories in save path",
})
