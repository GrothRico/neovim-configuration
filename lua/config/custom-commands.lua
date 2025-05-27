local function write_to_clipboard(str)
	vim.fn.setreg("+", str)
end

vim.api.nvim_create_user_command("CopyCurrentFilepath", function()
	local current_filepath = vim.fn.expand("%")
	write_to_clipboard(current_filepath)
end, {})
