return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to previous result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- Telescope keymaps
        vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [s]tatus" })
        vim.keymap.set("n", "<leader>sfh", builtin.help_tags, { desc = "[S]earch [f]or [h]elp" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [f]iles" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [g]rep" })
        vim.keymap.set("n", "<leader>cs", builtin.colorscheme, { desc = "[C]olor[s]cheme" })
    end,
}
