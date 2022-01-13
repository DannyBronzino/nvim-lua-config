local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			height = 0.95,
			preview_cutoff = 40,
			prompt_position = "top",
			width = 0.95,
		},
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-l>"] = actions.toggle_selection,
			},
      n = {
        ["l"] = actions.toggle_selection,
      },
		},
	},
})

-- FZF integration
require("telescope").load_extension("fzf")

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
	[[<cmd>lua require("telescope.builtin").find_files({previewer = false})<CR>]],
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
	[[<cmd>lua require("telescope.builtin").tags()<CR>]],
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
	[[<cmd>lua require("telescope.builtin").tags{ only_current_buffer = true }<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>?",
	[[<cmd>lua require("telescope.builtin").oldfiles()<CR>]],
	{ noremap = true, silent = true }
)
