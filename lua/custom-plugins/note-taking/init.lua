local note_taking = {
	buf = nil,
	win = nil,
	buffer_name = "note-taking.temporary-buffer.md",
}

note_taking.is_window_open = function()
	return note_taking.win and vim.api.nvim_win_is_valid(note_taking.win)
end

note_taking.hide_window = function()
	vim.api.nvim_win_hide(note_taking.win)
end

note_taking.open_window = function()
	if not note_taking.buf then
		note_taking.buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(note_taking.buf, note_taking.buffer_name)
	end
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	note_taking.win = vim.api.nvim_open_win(note_taking.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})
end

note_taking.setup = function() end

return note_taking
