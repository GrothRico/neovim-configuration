local plugin = {
    dir = vim.fn.stdpath("config") .. "/lua/custom-plugins/phpstan",
    config = function()
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	    pattern = "*.php",
	    callback = function()
		require("custom-plugins.phpstan").run_phpstan()
	    end
	})
    end,
}

return { plugin }
