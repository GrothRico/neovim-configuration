return {
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  "kristijanhusak/vim-dadbod-ui",
  config = function()
      local cmd = function(x)
	  return "<cmd>" .. x .. "<CR>"
      end
      local cmd_chain = function(cmds)
	  local chain = ""
	  for _, c in cmds do
	    chain = chain .. cmd(c)
	  end
	  return chain
      end
      vim.keymap.set("n", "<leader>s", cmd_chain("tabnew", "DBUI"))
  end
}
