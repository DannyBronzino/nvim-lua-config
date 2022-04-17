local map = require("utils").map

-- set leader to comma
map("", "<Space>", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- use control to turn backspace into delete
-- use <C-v> followed by <c-BS> to enter keycode
map("i", "", "<Del>")

-- allows for use of "j" and "k" over wrapped lines
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- move to beginning of wrapped line
map({ "n", "x" }, "H", "g^")

-- move to beginning of wrapped line
map({ "n", "x" }, "L", "g$")

map("n", "Y", "y$") -- yank until end of line

-- Paste non-linewise text above or below current cursor
map("n", "<leader>p", "m`o<ESC>p``")
map("n", "<leader>P", "m`O<ESC>p``")

-- use <tab> to indent or dedent in normal mode
map("n", "<tab>", ">>")
map("n", "<s-tab>", "<<")

-- continuous visual shifting (does not exit Visual mode), `gv` means to reselect previous visual area
map("x", "<tab>", ">gv")
map("x", "<s-tab>", "<gv")

-- Decrease indent level in insert mode with shift+tab
map("i", "<s-tab>", "<ESC><<i")

-- do not move cursor when joining lines
map("n", "J", "mzJ`z")

-- change text without putting it in the register
map("n", "c", '"_c')
map("n", "C", '"_C')
map("n", "cc", '"_cc')
map("x", "c", '"_c')

-- copy entire buffer
map("n", "<leader>y", ":<C-U>%y<CR>")

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
map("n", "<space>O", function()
	insert_blank_line(true)
end)

map("n", "<space>o", function()
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
map("n", "<m-j>", function()
	move_line(false)
end)
map("n", "<m-k>", function()
	move_line(true)
end)

-- Navigation in the location and quickfix list
map("n", "<m-up>", ":<C-U>lprevious<CR>zv")
map("n", "<m-down>", ":<C-U>lnext<CR>zv")
map("n", "<m-left>", ":<C-U>lfirst<CR>zv")
map("n", "<m-right>", ":<C-U>llast<CR>zv")
map("n", "<c-up>", ":<C-U>cprevious<CR>zv")
map("n", "<c-down>", ":<C-U>cnext<CR>zv")
map("n", "<c-left>", ":<C-U>cfirst<CR>zv")
map("n", "<c-right>", ":<C-U>clast<CR>zv")

map("n", "zt", "zt2k2j") -- place line close to top
map("i", "kj", "<esc>zt2k2ja") -- like zt, but works in insert

vim.cmd([[
" Break inserted text into smaller undo units.
for ch in [',', '.', '!', '?', ';', ':']
  execute printf('inoremap %s %s<C-g>u', ch, ch)
endfor

" Move current visual-line selection up and down
xnoremap <silent> <A-k> :<C-U>call utils#MoveSelection('up')<CR>
xnoremap <silent> <A-j> :<C-U>call utils#MoveSelection('down')<CR>
]])
