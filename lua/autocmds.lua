local au = vim.api.nvim_create_autocmd
-- autocmd User TelescopePreviewerLoaded setlocal wrap
au("User", {
	pattern = "TelescopePreviewerLoaded",
	command = "setlocal wrap",
})
