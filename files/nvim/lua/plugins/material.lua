return {
	"marko-cerovac/material.nvim",
	lazy = true,
	name = "material",
	--priority = 1000,
	config = function()
		require("material").setup({
			disable = {
				background = true,
			},
		})
		vim.g.material_style = "darker"
		vim.keymap.set("n", "<leader>ms", ':lua require("material.functions").find_style()<CR>', {})
	end,
}
