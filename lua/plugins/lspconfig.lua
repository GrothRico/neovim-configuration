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
	local configs = require("lspconfig.configs")
	lspconfig.lua_ls.setup({ capabilities = capabilities })
	lspconfig.clangd.setup({ capabilities = capabilities })
	lspconfig.rust_analyzer.setup({ capabilities = capabilities })
	lspconfig.glsl_analyzer.setup({ capabilities = capabilities })
	-- lspconfig.pyright.setup({
	-- 	cmd = { "poetry", "run", "pyright-langserver", "--stdio" },
	-- 	capabilities = capabilities,
	-- })
	lspconfig.pylsp.setup({
		cmd = { "poetry", "run", "python", "-m", "pylsp" },
		capabilities = capabilities,
		settings = {
			pylsp = {
				plugins = {
					pylsp_mypy = {
						enabled = true,
						override = {
							interpreter = "python",
						},
					},
					ruff = { enabled = true },
				},
			},
		},
	})
	configs.intelephense = {
		default_config = {
			cmd = { "intelephense", "--stdio" },
			filetypes = { "php" },
			root_dir = function(fname)
				return vim.loop.cwd()
			end,
		},
	}
	lspconfig.intelephense.setup({ capabilities = capabilities })
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
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
		vim.keymap.set("n", "<leader>t", vim.lsp.buf.type_definition)
		vim.keymap.set("n", "gd", telescope.lsp_definitions)
		vim.keymap.set("n", "<leader>lr", telescope.lsp_references)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "<leader>D", telescope.diagnostics)
		vim.keymap.set("n", "<leader>d", function()
			telescope.diagnostics({ bufnr = 0 })
		end)
		vim.keymap.set("n", "<leader>lS", telescope.lsp_workspace_symbols, { noremap = true })
		vim.keymap.set("n", "<leader>ls", telescope.lsp_document_symbols, { noremap = true })
		configure_lsps()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("Custom-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("Custom-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("Custom-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "Custom-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})
	end,
}
