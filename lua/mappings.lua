-- set leader to comma
Map("", "<Space>", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- use control to turn backspace into delete
-- use <C-v> followed by <c-BS> to enter keycode
Map("i", "<c-BS>", "<Del>")

-- allows for use of "j" and "k" over wrapped lines
Map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
Map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- move to beginning of wrapped line
Map({ "n", "x" }, "H", "g^")

-- move to beginning of wrapped line
Map({ "n", "x" }, "L", "g$")

Map("n", "Y", "y$") -- yank until end of line

-- Paste non-linewise text above or below current cursor
Map("n", "<leader>p", "m`o<ESC>p``")
Map("n", "<leader>P", "m`O<ESC>p``")

-- use <tab> to indent or dedent in normal mode
Map("n", "<tab>", ">>")
Map("n", "<s-tab>", "<<")

-- continuous visual shifting (does not exit Visual mode), `gv` means to reselect previous visual area
Map("x", "<tab>", ">gv")
Map("x", "<s-tab>", "<gv")

-- Decrease indent level in insert mode with shift+tab
Map("i", "<s-tab>", "<ESC><<i")

-- do not move cursor when joining lines
Map("n", "J", "mzJ`z")

-- change text without putting it in the register
Map("n", "c", '"_c')
Map("n", "C", '"_C')
Map("n", "cc", '"_cc')
Map("x", "c", '"_c')

-- copy entire buffer
Map("n", "<leader>y", ":<C-U>%y<CR>")

-- insert blank line above or below
local function insert_blank_line(above)
  local current_row = vim.api.nvim_win_get_cursor(0)[1]
  local current_column = vim.api.nvim_win_get_cursor(0)[2]
  local offset = 0

  if above == true then
    current_row = current_row - 1
    offset = 2 -- to make sure cursor stays on original line after insertion
  end

  vim.api.nvim_buf_set_lines(0, current_row, current_row, false, { "" })
  vim.api.nvim_win_set_cursor(0, { current_row + offset, current_column })
end

-- insert blank line above or below
Map("n", "<space>O", function()
  insert_blank_line(true)
end)

Map("n", "<space>o", function()
  insert_blank_line(false)
end)

-- move current line up or down
local function move_line(up)
  local current_line = vim.api.nvim_get_current_line()
  local current_row = vim.api.nvim_win_get_cursor(0)[1]
  local current_column = vim.api.nvim_win_get_cursor(0)[2]

  if up == true then
    current_row = current_row - 2
  elseif current_row == vim.api.nvim_buf_line_count(0) then -- prevents error if you are on the last line
    do
      return
    end
  end

  -- prevents crash if you try to move the top line up
  if current_row < 0 then
    do
      return
    end
  end

  vim.api.nvim_del_current_line()
  vim.api.nvim_buf_set_lines(0, current_row, current_row, false, { current_line })
  vim.api.nvim_win_set_cursor(0, { current_row + 1, current_column })
end

-- move line up and down
Map("n", "<m-j>", function()
  move_line(false)
end)
Map("n", "<m-k>", function()
  move_line(true)
end)

-- Navigation in the location and quickfix list
Map("n", "<m-up>", ":<C-U>lprevious<CR>zv")
Map("n", "<m-down>", ":<C-U>lnext<CR>zv")
Map("n", "<m-left>", ":<C-U>lfirst<CR>zv")
Map("n", "<m-right>", ":<C-U>llast<CR>zv")
Map("n", "<c-up>", ":<C-U>cprevious<CR>zv")
Map("n", "<c-down>", ":<C-U>cnext<CR>zv")
Map("n", "<c-left>", ":<C-U>cfirst<CR>zv")
Map("n", "<c-right>", ":<C-U>clast<CR>zv")

-- place current line 2 down from the top
Map("n", "zt", function()
  if vim.api.nvim_win_get_cursor(0)[1] <= 3 then
    return ""
  else
    vim.api.nvim_feedkeys("zt2k2j", "n", true)
  end
end)

-- like above, but works in insert
Map("i", "kj", function()
  if vim.api.nvim_win_get_cursor(0)[1] <= 3 then
    return ""
  else
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true) -- <ESC>" will pass as the individual characters otherwise
    vim.api.nvim_feedkeys(esc .. "zt2k2ja", "n", true)
  end
end)

vim.cmd([[
" Break inserted text into smaller undo units.
for ch in [',', '.', '!', '?', ';', ':']
  execute printf('inoremap %s %s<C-g>u', ch, ch)
endfor

" Move current visual-line selection up and down
xnoremap <silent> <A-k> :<C-U>call utils#MoveSelection('up')<CR>
xnoremap <silent> <A-j> :<C-U>call utils#MoveSelection('down')<CR>
]])
