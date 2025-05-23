local plugin = {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})
	end,
}

return { plugin }
