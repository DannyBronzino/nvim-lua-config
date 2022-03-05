require("pairs"):setup({
	enter = {
		enable_mapping = false,
	},
	pairs = {
		tex = {
			{ "'", "'", { ignore_pre = "\\a" } },
		},
	},
})
