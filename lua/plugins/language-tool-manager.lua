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
			},
		})
	end,
	init = function()
		local pylsp = require("mason-registry").get_package("python-lsp-server")
		pylsp:on("install:success", function()
			local function mason_package_path(package)
				local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
				return path
			end

			local path = mason_package_path("python-lsp-server")
			local command = path .. "/venv/bin/pip"
			local args = {
				"install",
				"-U",
				"python-lsp-ruff",
				"pylsp-mypy",
			}
			require("plenary.job")
				:new({
					command = command,
					args = args,
					cwd = path,
				})
				:start()
		end)
	end,
}
