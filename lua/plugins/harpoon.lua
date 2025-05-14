return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
	local harpoon = require("harpoon")
	harpoon:setup()
	vim.keymap.set("n", "<leader>q", function()
	    harpoon:list():add()
	    print("Harpoon: Added '" .. vim.fn.expand("%:p") .. "'")
	end)
	vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

	for i=0,9 do
	    vim.keymap.set("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	    end)
	end

	vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end)
	vim.keymap.set("n", "<C-l>", function() harpoon:list():next() end)
    end
}
