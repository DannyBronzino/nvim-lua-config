" Break inserted text into smaller undo units.
for ch in [',', '.', '!', '?', ';', ':']
  execute printf('inoremap %s %s<C-g>u', ch, ch)
endfor

" Move current visual-line selection up and down
xnoremap <silent> <A-k> :<C-U>call utils#MoveSelection('up')<CR>
xnoremap <silent> <A-j> :<C-U>call utils#MoveSelection('down')<CR>

" Navigation in the location and quickfix list
nnoremap <silent> <m-up> :<C-U>lprevious<CR>zv
nnoremap <silent> <m-down> :<C-U>lnext<CR>zv
nnoremap <silent> <m-left> :<C-U>lfirst<CR>zv
nnoremap <silent> <m-right> :<C-U>llast<CR>zv
nnoremap <silent> <c-up> :<C-U>cprevious<CR>zv
nnoremap <silent> <c-down> :<C-U>cnext<CR>zv
nnoremap <silent> <c-left> :<C-U>cfirst<CR>zv
nnoremap <silent> <c-right> :<C-U>clast<CR>zv

" Close location list or quickfix list if they are present,
" see https://superuser.com/q/355325/736190
nnoremap<silent> \x :<C-U>windo lclose <bar> cclose<CR>

" Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
" nnoremap <expr> <leader>v printf('`[%s`]', getregtype()[0])

" Search in selected region
" xnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>

" Find and replace (like Sublime Text 3)
" nnoremap <C-H> :%s/
" xnoremap <C-H> :s/

" Change current working directory locally and print cwd after that,
" see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" nnoremap <silent> <leader>cd :<C-U>lcd %:p:h<CR>:pwd<CR>

" Change text without putting it into the vim register,
" see https://stackoverflow.com/q/54255/6064933
" nnoremap c "_c
" nnoremap C "_C
" nnoremap cc "_cc
" xnoremap c "_c

" check the syntax group of current cursor position
" nnoremap <silent> <leader>st :<C-U>call utils#SynGroup()<CR>

" Clear highlighting
" if maparg('<C-L>', 'n') ==# ''
  " nnoremap <silent> <C-L> :<C-U>nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" endif

" Copy entire buffer.
" nnoremap <silent> <leader>y :<C-U>%y<CR>

" Toggle cursor column
" nnoremap <silent> <leader>cl :<C-U>call utils#ToggleCursorCol()<CR>

" Move current line up and down
" nnoremap <silent> <A-k> <Cmd>call utils#SwitchLine(line('.'), 'up')<CR>
" nnoremap <silent> <A-j> <Cmd>call utils#SwitchLine(line('.'), 'down')<CR>

" Replace visual selection with text in register, but not contaminate the
" register, see also https://stackoverflow.com/q/10723700/6064933.
xnoremap p "_c<ESC>p

" Go to next/previous buffer
" nnoremap <silent> gb :<C-U>call buf_utils#GoToBuffer(v:count, 'forward')<CR>
" nnoremap <silent> gB :<C-U>call buf_utils#GoToBuffer(v:count, 'backward')<CR>

" Splits
" nnoremap <c-h> <C-w>h
" nnoremap <c-j> <C-w>j
" nnoremap <c-k> <C-w>k
" nnoremap <c-l> <C-w>l

" Do not move my cursor when joining lines.
" nnoremap J mzJ`z
