set formatoptions+=t
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set foldlevel=999
set colorcolumn=0

let b:delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_quotes = "$"

inoremap zt <esc>zta

" Expansions for book I'm writing
iabbrev tq \tq{
iabbrev Qing \Qing{}
iabbrev Therese \Therese{}
iabbrev Lakshmi \Lakshmi{}