-- set leader to comma
Map("", "<Space>", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","

Map("i", "<c-BS>", "<Del>", { desc = "use <c-BS> for <DEL>" })

Map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "allows for use of 'k' over wrapped lines" })

Map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "allows for use of 'j' over wrapped lines" })

Map({ "n", "x" }, "H", "g^", { desc = "move to beginning of wrapped line" })

Map({ "n", "x" }, "L", "g$", { desc = "move to beginning of wrapped line" })

Map("n", "Y", "y$", { desc = "yank until end of line" })

Map("n", "<tab>", ">>", { desc = "use <tab> to indent in normal mode" })
Map("n", "<s-tab>", "<<", { desc = "use <s-tab> to dedent in normal mode" })

Map("x", "<tab>", ">gv", { desc = "continuous visual shifting (does not exit Visual mode)" })
Map("x", "<s-tab>", "<gv", { desc = "continuous visual shifting (does not exit Visual mode)" })

Map("i", "<s-tab>", "<ESC><<i", { desc = "Decrease indent level in insert mode with shift+tab" })

Map("n", "J", "mzJ`z", { desc = "do not move cursor when joining lines" })

Map("n", "c", '"_c', { desc = "change text without putting it in the register" })
Map("n", "C", '"_C', { desc = "change text without putting it in the register" })
Map("n", "cc", '"_cc', { desc = "change text without putting it in the register" })
Map("x", "c", '"_c', { desc = "change text without putting it in the register" })

Map("n", "<leader>y", ":<C-U>%y<CR>", { desc = "copy entire buffer" })

---insert blank line above or below
---@param above boolean
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

Map("n", "<space>O", function()
	insert_blank_line(true)
end, { desc = "insert blank line above" })

Map("n", "<space>o", function()
	insert_blank_line(false)
end, { desc = "insert blank line below" })

---move current line up or down
---@param up boolean
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

Map("n", "<m-j>", function()
	move_line(false)
end, { desc = "move line down" })
Map("n", "<m-k>", function()
	move_line(true)
end, { desc = "move line up" })

Map("n", "zt", function()
	if vim.api.nvim_win_get_cursor(0)[1] <= 3 then
		return ""
	else
		vim.api.nvim_feedkeys("zt2k2j", "n", true)
	end
end, { desc = "place current line 2 down from the top" })

Map("i", "kj", function()
	if vim.api.nvim_win_get_cursor(0)[1] <= 3 then
		return ""
	else
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true) -- <ESC>" will pass as the individual characters otherwise
		vim.api.nvim_feedkeys(esc .. "zt2k2ja", "n", true)
	end
end, { desc = "place current line 2 down from the top" })

vim.cmd([[
" Break inserted text into smaller undo units.
for ch in [',', '.', '!', '?', ';', ':']
  execute printf('inoremap %s %s<C-g>u', ch, ch)
endfor

" Move current visual-line selection up and down
xnoremap <silent> <A-k> :<C-U>call utils#MoveSelection('up')<CR>
xnoremap <silent> <A-j> :<C-U>call utils#MoveSelection('down')<CR>
]])
