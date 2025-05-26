local ColorScheme = {
	Dark = "dark",
	Light = "light",
}

local current_color_scheme = os.getenv("NVIM_COLOR_THEME") or ColorScheme.Dark

local everforest = {
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		local everforest = require("everforest")
		everforest.setup({
			background = "hard",
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
					},
				},
			},
		})
		local map = {
			light = "dayfox",
			dark = "nightfox",
		}
		vim.api.nvim_create_user_command("SwitchColorScheme", function()
			current_color_scheme = current_color_scheme == ColorScheme.Dark and ColorScheme.Light or ColorScheme.Dark
			vim.cmd.colorscheme(map[current_color_scheme])
			vim.notify("Switched to " .. current_color_scheme .. " mode")
		end, {})

		vim.cmd.colorscheme(map[current_color_scheme])
	end,
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
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

return {
	-- everforest,
	-- catppuccin,
	nightfox,
}
