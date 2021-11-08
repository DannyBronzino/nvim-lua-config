vim.cmd([[
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

call wilder#set_option("modes", ["/", "?", ":"])

call wilder#set_option("pipeline", [ wilder#branch( wilder#cmdline_pipeline({ "language": "python", "fuzzy": 1, "sorter": wilder#python_difflib_sorter() }), wilder#python_search_pipeline({ "pattern": wilder#python_fuzzy_pattern(), "sorter": wilder#python_difflib_sorter(), "engine": "re", }),), ])

call wilder#set_option("renderer", wilder#wildmenu_renderer( wilder#wildmenu_airline_theme({ "highlighter": wilder#basic_highlighter(), "separator": "  ", })))
]])
