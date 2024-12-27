local everforest = {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
	local everforest = require("everforest")
	everforest.setup({
	    background = "hard"
	})
	everforest.load()
    end,
}

local nightfox = {
    "EdenEast/nightfox.nvim",
    config = function()
	require("nightfox").setup({
	    options = {
		colorblind = {
		    enable = true,
		    severity = {
			protan = 0.6, -- red
			deutan = 1.0, -- green
			tritan = 0.3, -- blue
		    }
		},
	    },
	})
	vim.cmd.colorscheme("nightfox")
    end
}

local catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
	require("catppuccin").setup({
	    flavour = "mocha",
	    integrations = {
		treesitter = true,
	    }
	})
	vim.cmd.colorscheme("catppuccin")
    end
}

return nightfox
