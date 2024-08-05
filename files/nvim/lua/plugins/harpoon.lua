return {
    "ThePrimeagen/harpoon",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("harpoon")

        global_settings = {
            save_on_toggle = false,
            save_on_change = true,
            enter_on_sendcmd = false,
            tmux_autoclose_windows = false,
            excluded_filetypes = { "harpoon" },
            mark_branch = true,
            tabline = false
        }

        -- Harpoon keymaps
        vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, {})
        vim.keymap.set("n", "<leader>hn", require("harpoon.ui").nav_next, {})
        vim.keymap.set("n", "<leader>hp", require("harpoon.ui").nav_prev, {})
        vim.keymap.set("n", [[hm]], ":Telescope harpoon marks<CR>", {})
        vim.keymap.set("n", "<C-n>", ":Neotree reveal toggle<CR>", {})
    end
}
