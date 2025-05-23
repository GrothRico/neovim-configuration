local plugin = {
	dir = vim.fn.stdpath("config") .. "/lua/custom-plugins/note-taking",
	config = function()
		local note_taking = require("custom-plugins.note-taking")
		note_taking.setup()
		vim.keymap.set("n", "<leader>bs", function()
			if note_taking.is_window_open() then
				note_taking.hide_window()
			else
				note_taking.open_window()
			end
		end, { desc = "Floating note buffer" })
	end,
}

return { plugin }
