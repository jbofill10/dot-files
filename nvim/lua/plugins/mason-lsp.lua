return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		automatic_enable = false, -- Disable automatic enabling to use native vim.lsp API
		ensure_installed = {
			"lua_ls",
			"gopls",
			"vtsls",
			"jdtls",
			"golangci_lint_ls",
			"google-java-format",
			"prettierd",
			"goimports",
			"gofumpt",
            "snyk_ls"
		}, -- Auto-install these LSP servers
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
