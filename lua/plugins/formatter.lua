-- TODO: not working, always switches to lsp_format

-- inspired by kickstart.nvim
local plugin = {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "stylelint" },
				javascriptreact = { "prettierd", "stylelint" },
				typescript = { "prettierd", "stylelint" },
				typescriptreact = { "prettierd", "stylelint" },
				php = { "php-cs-fixer" },
			},
			format_on_save = {
				timeout_ms = 10000,
				lsp_format = "fallback",
			},
		})
	end,
}

return { plugin }
