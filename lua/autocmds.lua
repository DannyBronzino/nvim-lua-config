local api = vim.api
local au = vim.api.nvim_create_autocmd

-- set numbers to relative when in Normal mode, absolute when in Insert
local number_toggle = api.nvim_create_augroup("number_toggle", { clear = true })

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

-- local cursorline_toggle = api.nvim_create_augroup("numbertoggle", { clear = true })

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
local highlight_group = api.nvim_create_augroup("YankHighlight", { clear = true })

au("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
  desc = "highlights on yank",
})

local resume_edit = function()
  local api = vim.api
  -- this only works in the current buffer
  local set_cursor = function(position)
    return api.nvim_win_set_cursor(0, position)
  end

  -- get the mark
  local last_insert_mark = api.nvim_buf_get_mark(0, "^")
  -- get the total lines
  local total_buf_lines = api.nvim_buf_line_count(0)

  -- test to see if mark is outside of range
  -- if not, move to mark
  if pcall(set_cursor, last_insert_mark) then
    set_cursor(last_insert_mark)

    -- if mark is beyond last line, move cursor to last existing line
  elseif last_insert_mark[1] > total_buf_lines then
    set_cursor({ total_buf_lines, 0 })

    -- if mark is past end of an existing line, then move cursor  to end of line
  elseif pcall(set_cursor, { last_insert_mark[1], -1 }) then
    set_cursor({ last_insert_mark[1], -1 })

    -- if mark simply doesn't exist, e.g. first time opening file, place cursor on first character in buffer
  else
    set_cursor({ 1, 0 })
  end

  -- position line two rows from the top of the screen
  -- see similar mapping in mappings.lua
  -- if api.nvim_win_get_cursor(0)[1] > 3 then
  -- api.nvim_feedkeys("zt2k2j", "n", true)
  -- end
end

-- resume last insert position
au("Filetype", {
  callback = function()
    local is_in_table = require("utils").is_in_table
    local blacklist =
      { "guihua", "guihua_rust", "clap_input", "gitcommit", "gitrebase", "fzf", "notify", "packer", "help" }
    local ft = vim.opt.filetype:get()

    if is_in_table(blacklist, ft) then
      return false
    else
      resume_edit()
    end
  end,
  desc = "places cursor at last insert position",
})

vim.api.nvim_create_autocmd("Colorscheme", {
  callback = function()
    -- change lualine colorscheme
    require("config.lualine")
  end,
  pattern = "*",
  desc = "changes lualine colorscheme when nvim colorscheme changes",
})
