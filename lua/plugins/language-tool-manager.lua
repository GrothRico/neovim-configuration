return {
    "williamboman/mason.nvim",
    config = function()
	require("mason").setup({
	    ensure_installed = {
		"lua_ls",
		"clangd",
		"ts_ls",
		"rust_analyzer",
		"glsl_analyzer",
		"python-lsp-server",
		"intelephense",
	    }
	})
    end,
}
