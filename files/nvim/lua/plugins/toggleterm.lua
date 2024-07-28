return {
	"akinsho/toggleterm.nvim",
	lazy = false,
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			start_in_insert = true,
			persist_mode = false,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
			autochdir = true,
		})
		function _G.set_terminal_keymaps()
			local opts = { noremap = true }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
			vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
