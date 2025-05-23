vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.tabstop = 8
vim.o.softtabstop = 8
vim.o.visualbell = nil
vim.o.relativenumber = true
vim.o.colorcolumn = "80"
vim.o.guicursor = "n-v-c-sm:block"
vim.opt.scrolloff = 10
vim.o.autoindent = true
vim.o.updatetime = 500
vim.o.autoread = true

--[[ local file_ext_group = "Custom-colorcolumn-by-file-extension"
vim.api.nvim_create_augroup(file_ext_group, { clear = false })
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = { "*.php" },
	callback = function()
		vim.o.colorcolumn = "120"
	end,
	group = file_ext_group,
})
vim.api.nvim_create_autocmd({ "BufL", "BufNewFile" }, {
	pattern = { "*.php" },
	callback = function()
		vim.o.colorcolumn = "120"
	end,
	group = file_ext_group,
}) ]]
