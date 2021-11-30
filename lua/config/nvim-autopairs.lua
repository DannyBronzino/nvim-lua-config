local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.setup({
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
-- latex inline math
npairs.add_rule(Rule("$", "$", { "tex", "latex" }))

-- disable quotation marks in latex because I use csquotes
npairs.get_rule("'")[1]:with_pair(function()
	if vim.bo.filetype == "tex" then
		return false
	end
end)

npairs.get_rule('"')[1]:with_pair(function()
	if vim.bo.filetype == "tex" then
		return false
	end
end)
