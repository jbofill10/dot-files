return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- Required for neotest-golang v2
	build = ":TSUpdate",
	lazy = false,
	priority = 1000,
	config = function()
		-- Main branch API (different from master branch)
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Install parsers using main branch API
		local parsers = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"elixir",
			"heex",
			"javascript",
			"html",
			"python",
			"java",
			"go",
			"typescript",
			"rust",
			"ruby",
			"css",
			"scss",
			"json",
			"yaml",
			"bash",
			"dockerfile",
		}

		-- Install parsers asynchronously (main branch uses .install() method)
		require("nvim-treesitter").install(parsers)

		-- Enable treesitter highlighting for all filetypes
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})

		-- Enable treesitter-based indenting
		vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
}
