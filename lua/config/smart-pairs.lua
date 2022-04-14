require("pairs"):setup({
	enter = {
		enable_mapping = false,
	},
	pairs = {
		tex = {
			{ '"', '"', { cross_line = true } },
			{ "'", "'", { ignore_pre = "\\w", cross_line = true } },
		},
		markdown = {
			{ '"', '"', { cross_line = true } },
			{ "'", "'", { ignore_pre = "\\w", cross_line = true } },
		},
	},
})
