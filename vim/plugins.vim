scriptencoding utf-8

" Plugin installation
" lua require('plugins')

" Neomake
let g:neomake_open_list=2

" semshi settings
" Do not highlight for all occurrences of variable under cursor
let g:semshi#mark_selected_nodes=0

" Do not show error sign since linting plugin is specialized for that
let g:semshi#error_sign=v:false
let g:better_escape_interval = 300

" use jj to escape insert mode.
let g:better_escape_shortcut = 'jj'

" Change highlight color of matching bracket for better visual effects
" augroup matchup_matchparen_highlight
  " autocmd!
  " autocmd ColorScheme * highlight MatchParen cterm=underline gui=underline
" augroup END

" Show matching keyword as underlined text to reduce color clutter
" augroup matchup_matchword_highlight
  " autocmd!
  " autocmd ColorScheme * hi MatchWord cterm=underline gui=underline
" augroup END

" Automatically open quickfix window of 6 line tall after asyncrun starts
let g:asyncrun_open = 6

" " Visual Multi Cursor
" let g:VM_maps = {}
" let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
" let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n

" TOC settings
let g:vimtex_toc_config = {
      \ 'name' : 'TOC',
      \ 'layers' : ['content', 'todo', 'include'],
      \ 'resize' : 0,
      \ 'split_pos' : 'vert rightbelow',
      \ 'split_width' : 20,
      \ 'todo_sorted' : 0,
      \ 'show_help' : 1,
      \ 'show_numbers' : 1,
      \ 'mode' : 2,
      \ }
      
"vim-matchup settings
" Improve performance
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 100
let g:matchup_matchparen_insert_timeout = 30

" Enhanced matching with matchup plugin
let g:matchup_override_vimtex = 1

" Whether to enable matching inside comment or string
let g:matchup_delim_noskips = 0

" Show offscreen match pair in popup window
let g:matchup_matchparen_offscreen = {'method': 'popup'}

"neoformat settings
let g:neoformat_enabled_python = ['black', 'yapf']