return {
    "neovim/nvim-lspconfig",
    dependencies = {
	{ "williamboman/mason.nvim", config = true },
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	{ "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
	-- TODO: 
    end
}
