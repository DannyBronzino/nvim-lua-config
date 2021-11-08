set termguicolors
syntax enable

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

let g:everforest_enable_italic = 1
let g:everforest_better_performance = 1

let g:gruvbox_italics=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_plugin_hi_groups = 1

let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_better_performance = 1

let g:sonokai_enable_italic = 1
let g:sonokai_better_performance = 1

let g:edge_enable_italic = 1
let g:edge_better_performance = 1

lua<<EOF
-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)
EOF

colorscheme doom-one

" enable transpareency
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE
