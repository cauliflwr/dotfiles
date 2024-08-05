return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile"
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            python = { "ruff" }
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            pattern = { "*.js", "*.py" },
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end
        })

        vim.keymap.set("n", "<leader>lf", function()
            lint.try()
        end, { desc = "[L]int [f]ile" })
    end
}
