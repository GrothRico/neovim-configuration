--[[
IMPORTANT: remember to adjust lspconfig.lua such that all language servers
known about the additional capabilities provided by a completion plugin.
--]]

-- faster, but buggy as hell (cmdline terminal commands don't really work)
local blink_cmp = {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	enabled = function() return vim.b.completion ~= false end,
	version = "v0.*",
	opts = {
	    keymap = { preset = "default" },
	    completion = {
		menu = {
		    auto_show = function(ctx)
			return ctx.mode ~= "cmdline" -- doesn't really work
		    end
		},
		documentation = {
		    auto_show = true,
		},
	    },
	    appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	    },
	    signature = { enabled = true, },
	},
}

local nvim_cmp = {
    "hrsh7th/nvim-cmp",
    enabled = function() return vim.b.completion ~= false end,
    dependencies = {
	{
	    "L3MON4D3/LuaSnip",
	    version = "v2.*",
	},
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-path",
    },
    config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})
	cmp.setup({
	    snippet = {
		expand = function(args)
		    luasnip.lsp_expand(args.body)
		end
	    },
	    completion = {
		completeopt = "menu,menuone,noinsert",
	    },
	    sources = {
		{ name = "lazydev", group_index = 0 },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	    },
	    mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
	    })
	})
    end
}

return { nvim_cmp }
-- return { blink_cmp }
