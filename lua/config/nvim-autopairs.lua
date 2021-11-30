require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt" },
	ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
	enable_moveright = true,
	enable_afterquote = true, -- add bracket pairs after quote
	enable_check_bracket_line = true, --- check bracket in same line
	check_ts = true,
	map_bs = true, -- map the <BS> key
	map_c_w = true, -- map <c-w> to delete an pair if possible
	ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
})

local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

npairs.add_rule(Rule("$", "$", { "tex", "latex" }))
npairs.remove_rule("'", "'", {"tex", "latex," })
npairs.remove_rule('"', '"', {"tex", "latex," })