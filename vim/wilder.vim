" wilder settings from https://github.com/jdhao/nvim-config/blob/683008dac073e2255260772aaaf69f33751699e7/core/plugins.vim
augroup wilder_init
  autocmd!
  " CursorHold is suggested here: https: //github.com/gelguy/wilder.nvim/issues/89#issuecomment-934465957.
  autocmd CursorHold * ++once call s:wilder_init() " hold time determined by :set updatetime
augroup END

function! s:wilder_init() abort
  try
    call wilder#enable_cmdline_enter()
    set wildcharm=<Tab>
    cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
    cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

    " only / and ? are enabled by default
    call wilder#set_option('modes', ['/', '?', ':'])

    call wilder#set_option('pipeline', [
          \   wilder#branch(
          \     wilder#cmdline_pipeline({
          \       'language': 'python',
          \       'fuzzy': 1,
          \       'sorter': wilder#python_difflib_sorter(),
          \       'debounce': 30,
          \     }),
          \     wilder#python_search_pipeline({
          \       'pattern': wilder#python_fuzzy_pattern(),
          \       'sorter': wilder#python_difflib_sorter(),
          \       'engine': 're',
          \       'debounce': 30,
          \     }),
          \   ),
          \ ])

    let l:hl = wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}])

    call wilder#set_option('renderer', wilder#popupmenu_renderer({
          \ 'highlighter': wilder#basic_highlighter(),
          \ 'left': [
          \   ' ', wilder#popupmenu_devicons(),
          \ ],
          \ 'right': [
          \   ' ', wilder#popupmenu_scrollbar(),
          \ ],
          \ 'pumblend': 50,
          \ 'min_width': 100,
          \ 'min_height': 2,
          \ 'max_height': 7,
          \ 'highlights': {
          \   'accent': l:hl,
          \ },
          \ 'apply_incsearch_fix': 0,
          \ }))
  catch /^Vim\%((\a\+)\)\=:E117/
    echohl Error |echomsg "Wilder.nvim missing: run :PackerSync to fix."|echohl None
  endtry
endfunction
