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
end)

Map("n", "<leader>ff", function()
	project_files(require("telescope.themes").get_dropdown({ layout_config = { width = 0.5 } }))
end)

Map("n", "<leader>fb", function()
	require("telescope.builtin").current_buffer_fuzzy_find({ layout_strategy = "bottom_pane" })
end)

Map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags({ layout_strategy = "bottom_pane" })
end)

Map("n", "<leader>fd", function()
	require("telescope.builtin").grep_string({ layout_strategy = "bottom_pane" })
end)

Map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep({ layout_strategy = "bottom_pane" })
end)

Map("n", "<leader>?", function()
	require("telescope.builtin").oldfiles({ layout_strategy = "bottom_pane" })
end)

-- Map("n", '"', "<Nop>") -- disable for next map
-- Map("n", '"', function()
-- require("telescope.builtin").registers({ layout_strategy = "bottom_pane" })
-- end)

-- Map("i", "<c-r>", "<Nop>") -- disable for next map
-- Map("i", "<c-r>", function()
-- require("telescope.builtin").registers({ layout_strategy = "bottom_pane" })
-- end)

-- Map("n", "z=", "<Nop>") -- disable for next map
-- Map("n", "z=", function()
-- require("telescope.builtin").spell_suggest()
-- end)

-- Map("n", "'", "<Nop>") -- disable for next map
-- Map("n", "'", function()
-- require("telescope.builtin").marks({ layout_strategy = "bottom_pane" })
-- end)

-- NOTICE!!!
-- there is an alternative for LSP enabled projects in the lsp-installer file that overides this!!!
Map("n", "<leader>ft", function()
	require("telescope.builtin").tags({ layout_strategy = "bottom_pane" })
end)

Map("n", "<leader>fs", function()
	require("telescope").extensions.luasnip.luasnip({ layout_strategy = "bottom_pane" })
end)

Map("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects(
		require("telescope.themes").get_dropdown({ layout_config = { width = 0.5 } })
	)
end)
