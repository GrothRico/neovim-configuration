return {
    "nvim-lua/plenary.nvim",  -- needed for vim.fn utilities
    lazy = false,  -- load on startup
    config = function()
	local fixer = vim.fn.stdpath("data") .. "/mason/bin/php-cs-fixer"
	if io.open(fixer) == nil then
	    print("You need to install PHP CodeSniffer using Mason")
	end
	vim.api.nvim_create_autocmd("BufWritePost", {
	    pattern = "*.php",
	    callback = function()
		local cmd = string.format("%s fix %s --using-cache=no --quiet", fixer, vim.fn.expand("%:p"))
		vim.fn.system(cmd)
		vim.cmd("edit")
	    end,
	})
    end
}
