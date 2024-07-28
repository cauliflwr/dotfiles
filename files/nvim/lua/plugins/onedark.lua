return {
	-- https://github.com/navarasu/onedark.nvim
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			transparent = true,
			term_colors = true,
			code_style = {
				comments = "italic",
			},
		})
	end,
}
