require("hlslens").setup({
	calm_down = true,
	nearest_only = true,
})

map = require("utils").map

map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>")

map(
	"n",
	"N",
	"<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>",
	{ remap = true }
)

map("n", "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", { remap = true })

map("n", "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", { remap = true })
