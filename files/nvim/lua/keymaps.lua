-- [[ General keymaps ]]

-- Moving between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the right window" })

-- Splitting windows
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split the window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split the window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Resize the windows splits equally" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "close the current split" })

-- Modes and settings
vim.keymap.set("i", "<C-e>", "<esc>", { desc = "use c-e to exit insert mode" })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim: ts=2 sts=2 sw=2 et
