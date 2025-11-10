require("ibl").setup {
    exclude = { filetypes = { "dashboard" } },
    indent = { char = "│" },
    whitespace = { highlight = { "Whitespace" } },
    scope = {
        show_start = false,
        show_end = false,
        highlight = "IblScope"
    }
}
