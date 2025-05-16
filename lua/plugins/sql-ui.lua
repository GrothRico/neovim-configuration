local plugin = {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		local cmd = function(strs)
			local chain = ""
			for _, cmd in ipairs(strs) do
				chain = chain .. "<cmd>" .. cmd .. "<CR>"
			end
			return chain
		end
		vim.g.db_ui_use_nerd_fonts = 1
		vim.keymap.set("n", "<leader>ps", cmd({ "tabnew", "DBUI" }))
		vim.keymap.set("n", "<leader>pq", cmd({ "tabclose", "DBUIClose" }))
	end,
}

return { plugin }
