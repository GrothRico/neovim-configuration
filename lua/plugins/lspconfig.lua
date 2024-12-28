local get_code_completion_engine_type = function()
    local blink_cmp_enabled, blink_cmp = pcall(require, "blink.cmp")
    local nvim_cmp_enabled, nvim_cmp = pcall(require, "cmp")
    if blink_cmp_enabled then
	return "blink"
    elseif nvim_cmp_enabled then
	return "nvim-cmp"
    end
    return nil
end

local get_capabilities = function()
    local code_completion_engine_type = get_code_completion_engine_type()
    if code_completion_engine_type == "blink" then
	return require("blink.cmp").get_lsp_capabilities()
    elseif code_completion_engine_type == "nvim-cmp" then
	return vim.tbl_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities()
	)
    end
end

local configure_lsps = function()
    local lspconfig = require("lspconfig")
    local capabilities = get_capabilities()
    lspconfig.lua_ls.setup({ capabilities = capabilities })
    lspconfig.clangd.setup({ capabilities = capabilities })
end

local completion_dependency = function()
    local engine = get_code_completion_engine_type()
    if engine == "blink" then
	return "saghen/blink.cmp"
    elseif engine == "nvim-cmp" then
	return "hrsh7th/cmp-nvim-lsp"
    end
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
	completion_dependency(),
	{
	    "folke/lazydev.nvim",
	    ft = "lua",
	    opts = {
		library = {
		    {
			path = "${3rd}/luv/library",
			words = { "vim%.uv" },
		    },
		},
	    },
	},
    },
    config = function()
	local telescope = require("telescope.builtin")
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
	vim.keymap.set("n", "gd", telescope.lsp_definitions)
	vim.keymap.set("n", "<leader>lr", telescope.lsp_references)
	configure_lsps()
    end
}
