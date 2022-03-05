require("pairs"):setup({
	enter = {
		enable_mapping = false,
	},
	pairs = {
		['*'] = {
			{ "'", "'", { ignore_pre = "\\a" } },
		},
	},
	mapping = {
		jump_left_in_any = "<m-{>",
		jump_right_in_any = "<m-}>",
		jump_left_out_any = "<m-[>",
		jump_right_out_any = "<m-]>",
	},
})
