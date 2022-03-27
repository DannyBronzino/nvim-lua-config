local M = {}

-- wrap telescope results
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	command = "setlocal wrap",
})

-- use find_files if not in git project
M.project_files = function()
	local opts = {} -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

local actions = require("telescope.actions")

require("telescope").load_extension("fzf") -- FZF integration
require("telescope").load_extension("packer") -- packer extension

require("telescope").setup({
	defaults = {
		layout_strategy = "bottom_pane",
		sorting_strategy = "ascending",
		layout_config = {
			preview_cutoff = 60,
			prompt_position = "top",
			height = 0.5,
			width = 0.8,
		},
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

-- Add leader shortcuts
vim.api.nvim_set_keymap(
	"n",
	"<leader><space>",
	[[<cmd>lua require("telescope.builtin").buffers()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ff",
	[[<cmd>lua require("config.telescope").project_files()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	[[<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fh",
	[[<cmd>lua require("telescope.builtin").help_tags()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ft",
	[[<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fd",
	[[<cmd>lua require("telescope.builtin").grep_string()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fg",
	[[<cmd>lua require("telescope.builtin").live_grep()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fo",
	[[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>?",
	[[<cmd>lua require("telescope.builtin").oldfiles()<CR>]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>fr",
	[[<cmd>lua require("telescope.builtin").registers()<CR>]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>fp",
	[[<cmd>lua require("telescope").extensions.packer.packer(require("telescope.themes").get_ivy())<CR>]],
	{ noremap = true, silent = true }
)

return M
