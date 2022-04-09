-- wrap telescope results
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- use find_files if not in git project
project_files = function(opts)
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

symbols = function(opts)
	if vim.lsp.client_is_stopped(1) then
		require("telescope.builtin").tags(opts)
	else
		require("telescope.builtin").lsp_workspace_symbols(opts)
	end
end

local actions = require("telescope.actions")

-- extensions
require("telescope").load_extension("fzf") -- FZF integration
require("telescope").load_extension("packer") -- packer extension
require("telescope").load_extension("luasnip") -- luasnip extension

require("telescope").setup({
	defaults = {
		layout_strategy = "bottom_pane",
		sorting_strategy = "ascending",
		layout_config = {
			preview_cutoff = 60,
			prompt_position = "top",
			height = 0.75,
		},
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
		},
	},
})

local map = require("utils").map

-- Add leader shortcuts
map("n", "<leader><space>", function()
	require("telescope.builtin").buffers()
end)

map("n", "<leader>ff", function()
	project_files()
end)

map("n", "<leader>fb", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end)

map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end)

map("n", "<leader>ft", function()
	symbols()
end)

map("n", "<leader>fd", function()
	require("telescope.builtin").grep_string()
end)

map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end)

map("n", "<leader>fo", function()
	require("telescope.builtin").lsp_document_symbols()
end)

map("n", "<leader>?", function()
	require("telescope.builtin").oldfiles()
end)

map("n", "<leader>fr", function()
	require("telescope.builtin").registers()
end)
