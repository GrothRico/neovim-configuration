local function write_to_clipboard(str)
	vim.fn.setreg("+", str)
end

local is_scrollbind_on = false

vim.api.nvim_create_user_command("CopyCurrentFilepath", function()
	local current_filepath = vim.fn.expand("%")
	write_to_clipboard(current_filepath)
end, {})

vim.api.nvim_create_user_command("ToggleScrollbind", function()
	is_scrollbind_on = not is_scrollbind_on
	if is_scrollbind_on then
		vim.cmd("windo set scrollbind")
	else
		vim.cmd("windo set noscrollbind")
	end
end, {})
