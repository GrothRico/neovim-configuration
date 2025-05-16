return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		main = "nvim-treesitter.configs",
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			auto_install = true,
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"cmake",
				"doxygen",
				"json",
				"lua",
				"nix",
				"php",
				"rust",
				"python",
				"sql",
				"yaml",
				"xml",
				"go",
				"markdown",
				"typescript",
				"javascript",
				"html",
				"css",
			},
		},
	},
}
