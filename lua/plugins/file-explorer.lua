local plugin = {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,

  config = function()
      require("oil").setup({})
      vim.keymap.set("n", "<leader>E", "<cmd>Oil<CR>")
  end
}

return { plugin }
