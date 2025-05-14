return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  config = function()
      local typescipt_tools = require("typescript-tools")
      typescipt_tools.setup({
	  settings = {
	      tsserver_plugins = { "@styled/typescript-styled-plugin" },
	  },
      })
  end
}
