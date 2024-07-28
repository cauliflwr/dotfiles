-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		lazyrepo,
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- import lua/plugins folder
	spec = { { import = "plugins" }, { import = "plugins.lsp" } },
	install = { colorscheme = { "onedark" } },
	change_detection = { notify = false },
})

-- vim: ts=2 sts=2 sw=2 et
