return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
	"nvim-lua/plenary.nvim",
	{
	    "nvim-telescope/telescope-fzf-native.nvim",
	    build = "make",
	    cond = function()
		return vim.fn.executable("make") == 1
	    end,
	},
	{
	    "nvim-telescope/telescope-ui-select.nvim",
	},
	{
	    "nvim-tree/nvim-web-devicons",
	    enabled = vim.g.have_nerd_font,
	},
    },
    config = function()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")
	local theme = require("telescope.themes")
	local leaderMap = function (keys, func)
	    vim.keymap.set("n", "<leader>" .. keys, func)
	end
	telescope.setup({
	    extensions = {
		["ui-select"] = {
		    require("telescope.themes").get_dropdown(),
		}
	    },
	    defaults = {
		layout_config = {
		    vertical = { width = 0.95 },
		    horizontal = { width = 0.95 },
		},
	    },
	})
	pcall(telescope.load_extension, "fzf")
	pcall(telescope.load_extension, "ui-select")
	leaderMap("f", builtin.find_files)
	leaderMap("F", function () 
	    builtin.find_files({ no_ignore = true })
	end)
	leaderMap("g", builtin.live_grep)
	leaderMap("/", function()
	    builtin.current_buffer_fuzzy_find(theme.get_dropdown({
		winblend = 10,
		previewer = false,
	    }))
	end)
	leaderMap("nv", function()
	    builtin.find_files({
		cwd = vim.fn.stdpath("config"),
	    })
	end)
    end
}
