return {
	"AlexvZyl/nordic.nvim",
	lazy = true,
	--priority = 1000,
	config = function()
		require("nordic").setup({
			transparent_bg = true,
			bright_border = true,
			cursorline = {
				theme = "light",
			},
			telescope = {
				style = "classic",
			},
		})
	end,
}
