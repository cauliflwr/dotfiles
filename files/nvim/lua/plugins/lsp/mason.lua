return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- enable mason
		mason.setup({
			ui = {
				border = "rounded",
			},
		})

		mason_lspconfig.setup({
			ensure_installed = { "bashls", "html", "lua_ls", "pyright", "ruff", "tflint" },

			--enable auto install of lsp configured servers
			automatic_installation = true,
		})
	end,
}
