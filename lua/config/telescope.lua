-- extensions
require("telescope").load_extension("fzf") -- FZF integration
require("telescope").load_extension("packer") -- packer extension
require("telescope").load_extension("luasnip") -- luasnip extension
require("project_nvim").setup({})
require("telescope").load_extension("projects")

-- wrap telescope results
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- use find_files if not in git project
local project_files = function(opts)
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				prompt_position = "top",
				preview_cutoff = 1,
				preview_height = 0.45,
				height = 0.99,
				width = 0.99,
			},
			bottom_pane = {
				preview_cutoff = 1,
				prompt_position = "top",
				height = 0.75,
			},
			center = {
				width = 0.5,
			},
		},
		sorting_strategy = "ascending",
		dynamic_preview_title = true,
		mappings = {
			i = {
				["<c-n>"] = actions.preview_scrolling_down,
				["<c-p>"] = actions.preview_scrolling_up,
				["<tab>"] = actions.move_selection_next,
				["<s-tab>"] = actions.move_selection_previous,
				["<c-l>"] = actions.toggle_selection,
			},
			n = {
				["l"] = actions.toggle_selection,
			},
		},
	},
	pickers = {
		buffers = {
			theme = "dropdown",
			layout_config = {
				width = 0.5,
			},
		},
		spell_suggest = {
			theme = "cursor",
			layout_config = {
				width = 0.33,
			},
		},
		find_files = {
			theme = "dropdown",
			layout_config = {
				width = 0.5,
			},
		},
		projects = {
			theme = "dropdown",
			layout_config = {
				width = 0.5,
			},
		},
	},
	extensions = {},
})

-- Add leader shortcuts
Map("n", "<leader><space>", function()
	require("telescope.builtin").buffers()
end, { desc = "display open buffers with telescope" })

Map("n", "<leader>ff", function()
	project_files(require("telescope.themes").get_dropdown({ layout_config = { width = 0.5 } }))
end, { desc = "display project files with telescope" })

Map("n", "<leader>fb", function()
	require("telescope.builtin").current_buffer_fuzzy_find({ layout_strategy = "bottom_pane" })
end, { desc = "current buffer fuzzy find with telescope" })

Map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags({ layout_strategy = "bottom_pane" })
end, { desc = "display help topics with telescope" })

Map("n", "<leader>fd", function()
	require("telescope.builtin").grep_string({ layout_strategy = "bottom_pane" })
end, { desc = "grep string with telescope" })

Map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep({ layout_strategy = "bottom_pane" })
end, { desc = "live grep with telescope" })

Map("n", "<leader>?", function()
	require("telescope.builtin").oldfiles({ layout_strategy = "bottom_pane" })
end, { desc = "display recent files with telescope" })

Map("n", "<leader>ft", function()
	require("telescope.builtin").tags({ layout_strategy = "bottom_pane" })
end, { desc = "display tags with telescope" })

Map("n", "<leader>fs", function()
	require("telescope").extensions.luasnip.luasnip({ layout_strategy = "bottom_pane" })
end, { desc = "display luasnip snippets with telescope" })

Map("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects(
		require("telescope.themes").get_dropdown({ layout_config = { width = 0.5 } })
	)
end, { desc = "display projects with telescope" })
