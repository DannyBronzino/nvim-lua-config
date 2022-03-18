-- Easier syntax
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- set leader to comma
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- allows for use of "j" and "k" over wrapped lines
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- move to beginning of wrapped line
map("n", "H", "g^", opts)
map("x", "H", "g^", opts)

-- move to beginning of wrapped line
map("n", "L", "g$", opts)
map("x", "L", "g$", opts)

map("n", "Y", "y$", opts) -- yank until end of line

map("n", "<F12>", "<cmd>Git add % <bar> Git commit %<cr>", opts) -- commit current file

-- Paste non-linewise text above or below current cursor
map("n", "<leader>p", "m`o<ESC>p``", opts)
map("n", "<leader>P", "m`O<ESC>p``", opts)

-- use <tab> to indent or dedent in normal mode
map("n", "<tab>", ">>", opts)
map("n", "<s-tab>", "<<", opts)

-- continuous visual shifting (does not exit Visual mode), `gv` means to reselect previous visual area
map("x", "<tab>", ">gv", opts)
map("x", "<s-tab>", "<gv", opts)

-- Insert a blank line below or above current line (do not move the cursor),
map("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", { noremap = true, expr = true, silent = true })
map("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", { noremap = true, expr = true, silent = true })

-- Decrease indent level in insert mode with shift+tab
map("i", "<S-Tab>", "<ESC><<i", opts)

-- do not move cursor when joining lines
map("n", "J", "mzJ`z", opts)

-- change text without putting it in the register
map("n", "c", '"_c', opts)
map("n", "C", '"_C', opts)
map("n", "cc", '"_cc', opts)
map("x", "c", '"_c', opts)

-- copy entire buffer
map("n", "<leader>y", ":<C-U>%y<CR>", opts)

-- move line up and down
map("n", "<m-j>", [[<cmd>lua require("utils")move_line(false)<cr>]], opts)
map("n", "<m-k>", [[<cmd>lua require("utils")move_line(true)<cr>]], opts)

-- Navigation in the location and quickfix list
map("n", "<m-up>", ":<C-U>lprevious<CR>zv", opts)
map("n", "<m-down>", ":<C-U>lnext<CR>zv", opts)
map("n", "<m-left>", ":<C-U>lfirst<CR>zv", opts)
map("n", "<m-right>", ":<C-U>llast<CR>zv", opts)
map("n", "<c-up>", ":<C-U>cprevious<CR>zv", opts)
map("n", "<c-down>", ":<C-U>cnext<CR>zv", opts)
map("n", "<c-left>", ":<C-U>cfirst<CR>zv", opts)
map("n", "<c-right>", ":<C-U>clast<CR>zv", opts)

vim.cmd([[
" Break inserted text into smaller undo units.
for ch in [',', '.', '!', '?', ';', ':']
  execute printf('inoremap %s %s<C-g>u', ch, ch)
endfor

" Move current visual-line selection up and down
xnoremap <silent> <A-k> :<C-U>call utils#MoveSelection('up')<CR>
xnoremap <silent> <A-j> :<C-U>call utils#MoveSelection('down')<CR>
]])