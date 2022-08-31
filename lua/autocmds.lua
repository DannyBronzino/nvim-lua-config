local api = vim.api
local autocmd = vim.api.nvim_create_autocmd

-- set numbers to relative when in Normal mode, absolute when in Insert
local number_toggle = api.nvim_create_augroup("number_toggle", { clear = true })

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
  group = api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  desc = "highlights on yank",
})

-- resume last insert position
autocmd("BufWinEnter", {
  group = api.nvim_create_augroup("ResumeEdit", { clear = true }),
  callback = function()
    -- this only works in the current buffer
    local set_cursor = function(position)
      return api.nvim_win_set_cursor(0, position)
    end

    -- get the total lines
    local total_buf_lines = api.nvim_buf_line_count(0)

    -- get the mark
    local last_insert_mark = api.nvim_buf_get_mark(0, "^")
    if last_insert_mark == { 0, 0 } then
      return
    end

    -- test to see if mark is outside of range
    -- if not, move to mark
    if pcall(set_cursor, last_insert_mark) then
      return set_cursor(last_insert_mark)
    end

    -- if mark is beyond last line, move cursor to last existing line
    if last_insert_mark[1] > total_buf_lines then
      return set_cursor({ total_buf_lines, 0 })
    end

    -- if mark is past end of an existing line, then move cursor  to end of line
    if pcall(set_cursor, { last_insert_mark[1], -1 }) then
      return set_cursor({ last_insert_mark[1], -1 })
    end
  end,
  desc = "places cursor at last insert position",
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
  desc = "creates missing directories in save path",
})
