require("ibl").setup {
    exclude = { filetypes = { "dashboard" } },
    indent = { char = "│" },
    whitespace = { highlight = { "Whitespace" } },
    scope = {
        show_start = false,
        show_end = false,
        highlight = "IblScope"
    },
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#A3BBFF" }) -- Replace with your desired color
}
