--[[
IMPORTANT: remember to adjust lspconfig.lua such that all language servers
known about the additional capabilities provided by a completion plugin.
--]]

-- faster, but buggy as hell (cmdline terminal commands don't really work)
local blink_cmp = {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	enabled = function()
	    return vim.b.completion ~= false
	end,
	version = "v0.*",
	opts = {
	    keymap = { preset = "default" },
	    completion = {
		menu = {
		    auto_show = function(ctx)
			return ctx.mode ~= "cmdline" or vim.fn.getcmdtype() == ""
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
    enabled = true,
}

return {
    nvim_cmp,
    -- blink_cmp,
}
