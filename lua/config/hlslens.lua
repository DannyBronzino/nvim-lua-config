require("hlslens").setup({
	calm_down = true,
	nearest_only = true,
})

-- easier syntax
local function map(mode, l, r, opts)
	opts = opts or {}
	opts.silent = true
	vim.keymap.set(mode, l, r, opts)
end

map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>")

map(
	"n",
	"N",
	"<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>",
	{ remap = true }
)

map("n", "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", { remap = true })

map("n", "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", { remap = true })
