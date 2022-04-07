-- wrap telescope results
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.opt_local.wrap = true
	end,
})

local M = {}

-- use find_files if not in git project
M.project_files = function(opts)
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

M.symbols = function(opts)
	if vim.lsp.client_is_stopped(1) then
		require("telescope.builtin").tags(opts)
	else
		require("telescope.builtin").lsp_workspace_symbols(opts)
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
			height = 0.75,
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

-- easier syntax
local function map(mode, l, r, opts)
	opts = opts or {}
	opts.silent = true
	vim.keymap.set(mode, l, r, opts)
end

-- Add leader shortcuts
map("n", "<leader><space>", [[<cmd>lua require("telescope.builtin").buffers()<CR>]])

map("n", "<leader>ff", [[<cmd>lua require("config.telescope").project_files()<CR>]])

map("n", "<leader>fb", [[<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>]])

map("n", "<leader>fh", [[<cmd>lua require("telescope.builtin").help_tags()<CR>]])

map("n", "<leader>ft", [[<cmd>lua require("config.telescope").symbols()<CR>]])

map("n", "<leader>fd", [[<cmd>lua require("telescope.builtin").grep_string()<CR>]])

map("n", "<leader>fg", [[<cmd>lua require("telescope.builtin").live_grep()<CR>]])

map("n", "<leader>fo", [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]])

map("n", "<leader>?", [[<cmd>lua require("telescope.builtin").oldfiles()<CR>]])

map("n", "<leader>fr", [[<cmd>lua require("telescope.builtin").registers()<CR>]])

map(
	"n",
	"<leader>fp",
	[[<cmd>lua require("telescope").extensions.packer.packer(require("telescope.themes").get_ivy())<CR>]]
)

return M
