return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		--{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- define keymap opts
		local opts = { noremap = true, silent = true }

		-- define keymaps when lsp is attached
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keymaps
			opts.desc = "Get [c]ode [a]ctions"
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Show [D]ocumentation for what is under the cursor"
			vim.keymap.set("n", "D", vim.lsp.buf.hover, opts)
		end

		-- used to enable autocompletion (needs to be assigned to each lsp server)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- configure bashls server
		lspconfig.bashls.setup({
			capabilities = capabilities,
		})

		-- configure html server
		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure lua_ls server
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- configure pyright server
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure ruff server
		lspconfig.ruff.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure tflint server
		lspconfig.tflint.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
