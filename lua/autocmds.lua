local au = vim.api.nvim_create_autocmd

-- set numbers to relative when in Normal mode, absolute when in Insert
local number_toggle = vim.api.nvim_create_augroup("number_toggle", { clear = true })

au({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  callback = function()
    if vim.opt.number:get() == true then
      vim.opt.relativenumber = true
    end
  end,
  group = number_toggle,
  desc = "set numbers to relative when entering Normal mode",
})

au({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  callback = function()
    if vim.opt.number:get() == true then
      vim.opt.relativenumber = false
    end
  end,
  group = number_toggle,
  desc = "set numbers to absolute when entering Insert mode",
})

-- local cursorline_toggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

-- au("InsertEnter", {
--   callback = function()
--     vim.opt.cursorline = true
--   end,
--   group = cursorline_toggle,
--   desc = "enable cursorline when entering Insert"
-- })

-- au("InsertLeave", {
--   callback = function()
--     vim.opt.cursorline = false
--   end,
--   group = cursorline_toggle,
--   desc = "disable cursorline when entering Normal"
-- })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
  desc = "highlights on yank",
})

au("BufReadPost", {
  callback = function()
    local set_cursor = vim.api.nvim_win_set_cursor
    local mark = vim.api.nvim_buf_get_mark(0, "^")
    local line_count = vim.api.nvim_buf_line_count(0)

    if pcall(set_cursor, 0, mark) then
      set_cursor(0, mark)
    else
      set_cursor(0, { line_count, 0 })
    end

    if vim.api.nvim_win_get_cursor(0)[1] > 3 then
      vim.api.nvim_feedkeys("zt2k2j", "n", true)
    end
  end,
})
