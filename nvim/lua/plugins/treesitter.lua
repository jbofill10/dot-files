return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python", "java", "go", "typescript", "rust", "ruby", "css", "scss", "json", "yaml", "bash", "dockerfile"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 }
