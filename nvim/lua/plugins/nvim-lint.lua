return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            lua = { "luacheck" },
            go = { "golangcilint" },
            -- Add more file types and their respective linters
        }
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
