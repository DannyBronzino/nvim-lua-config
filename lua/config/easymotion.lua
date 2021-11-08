vim.cmd([[
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1

map <space> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char}
map  f <Plug>(easymotion-bd-f)
nmap <Space>f <Plug>(easymotion-overwin-f)

" <Space>t{char} to move to right before {char}
map  t <Plug>(easymotion-bd-t)
nmap <Space>t <Plug>(easymotion-overwin-t)
 
" s{char}{char} to move to {char}{char}
nmap <Space>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Space>l <Plug>(easymotion-bd-jk)
nmap <Space>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Space>w <Plug>(easymotion-bd-w)
nmap <Space>w <Plug>(easymotion-overwin-w)
]])
