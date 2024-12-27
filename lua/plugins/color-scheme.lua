local everforest = {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
	require("everforest").setup({})
    end,
}

local catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
	require("catppuccin").setup({
	    flavour = "macchiato", -- latte (light), frappe, macchiato, mocha (darkest)
	    integrations = {
		treesitter = true,
	    }
	})
    end
}

return catppuccin
