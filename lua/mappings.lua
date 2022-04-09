map = require("utils").map

-- set leader to comma
map("", "<Space>", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- use control to turn backspace into delete
-- use <C-v> followed by <c-BS> to enter keycode
map("i", "", "<Del>")

-- allows for use of "j" and "k" over wrapped lines
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true })

-- move to beginning of wrapped line
map("n", "H", "g^")
map("x", "H", "g^")

-- move to beginning of wrapped line
map("n", "L", "g$")
map("x", "L", "g$")

map("n", "Y", "y$") -- yank until end of line

map("n", "<F12>", "<cmd>Git add % <bar> Git commit %<cr>") -- commit current file

-- Paste non-linewise text above or below current cursor
map("n", "<leader>p", "m`o<ESC>p``")
map("n", "<leader>P", "m`O<ESC>p``")

-- use <tab> to indent or dedent in normal mode
map("n", "<tab>", ">>" )
map("n", "<s-tab>", "<<" )

-- continuous visual shifting (does not exit Visual mode), `gv` means to reselect previous visual area
map("x", "<tab>", ">gv" )
map("x", "<s-tab>", "<gv" )

-- Decrease indent level in insert mode with shift+tab
map("i", "<s-tab>", "<ESC><<i" )

-- do not move cursor when joining lines
map("n", "J", "mzJ`z" )

-- change text without putting it in the register
map("n", "c", '"_c' )
map("n", "C", '"_C' )
map("n", "cc", '"_cc' )
map("x", "c", '"_c' )

-- copy entire buffer
map("n", "<leader>y", ":<C-U>%y<CR>" )

-- move line up and down
map("n", "<m-j>", [[<cmd>lua require("utils").move_line("down")<cr>]] )
map("n", "<m-k>", [[<cmd>lua require("utils").move_line("up")<cr>]] )

-- insert blank line above or below
map("n", "<space>O", [[<cmd>lua require("utils").insert_blank_line("above")<cr>]] )
map("n", "<space>o", [[<cmd>lua require("utils").insert_blank_line("below")<cr>]] )

-- Navigation in the location and quickfix list
map("n", "<m-up>", ":<C-U>lprevious<CR>zv" )
map("n", "<m-down>", ":<C-U>lnext<CR>zv" )
map("n", "<m-left>", ":<C-U>lfirst<CR>zv" )
map("n", "<m-right>", ":<C-U>llast<CR>zv" )
map("n", "<c-up>", ":<C-U>cprevious<CR>zv" )
map("n", "<c-down>", ":<C-U>cnext<CR>zv" )
map("n", "<c-left>", ":<C-U>cfirst<CR>zv" )
map("n", "<c-right>", ":<C-U>clast<CR>zv" )

vim.cmd([[
" Break inserted text into smaller undo units.
for ch in [',', '.', '!', '?', ';', ':']
  execute printf('inoremap %s %s<C-g>u', ch, ch)
endfor

" Move current visual-line selection up and down
xnoremap <silent> <A-k> :<C-U>call utils#MoveSelection('up')<CR>
xnoremap <silent> <A-j> :<C-U>call utils#MoveSelection('down')<CR>
]])
