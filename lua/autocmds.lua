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

-- resume last insert position
au("BufReadPost", {
  callback = function()
    -- this only works in the current buffer
    local set_cursor = function(position)
      return vim.api.nvim_win_set_cursor(0, position)
    end

    -- get the mark
    local mark = vim.api.nvim_buf_get_mark(0, "^")
    -- get the total lines
    local total_lines = vim.api.nvim_buf_line_count(0)

    -- test to see if mark is outside of range
    if pcall(set_cursor, mark) then
      set_cursor(mark)
    elseif mark[1] > total_lines then
      -- if mark is beyond last line, move cursor to last existing line
      set_cursor({ total_lines, 0 })
    elseif pcall(set_cursor, { mark[1], -1 }) then
      -- if mark is within document, but beyond end of line, move cursor  to end of line
      set_cursor({ mark[1], -1 })
    else
      -- put the cursor at the beginning for all other cases, such as missing mark
      set_cursor({ 1, 0 })
    end

    -- position line two rows from the top of the screen
    -- see similar mapping in mappings.lua
    if vim.api.nvim_win_get_cursor(0)[1] > 3 then
      vim.api.nvim_feedkeys("zt2k2j", "n", true)
    end
  end,
  desc = "resumes last insert position",
})
