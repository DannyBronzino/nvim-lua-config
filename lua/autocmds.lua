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
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  -- you can create the group here instead
  group = api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  desc = "highlights on yank",
})

local resume_edit = function() end

-- resume last insert position
autocmd("FileType", {
  group = api.nvim_create_augroup("ResumeEdit", { clear = true }),
  callback = function(ctx)
    local blacklist = {
      "guihua",
      "guihua_rust",
      "clap_input",
      "gitcommit",
      "gitrebase",
      "fzf",
      "notify",
      "packer",
      "help",
      "cmp_menu",
    }
    local is_in_table = require("utils").is_in_table

    if is_in_table(blacklist, ctx.match) == false then
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
    end
  end,
  desc = "places cursor at last insert position",
})

autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
  desc = "creates missing directories in save path",
})
