-- LSP configuration using native Neovim 0.11+ API
-- Keymaps are configured globally in lua/juan/remap.lua

-- Enable verbose LSP logging for debugging
vim.lsp.log.set_level("debug") -- Options: 'trace', 'debug', 'info', 'warn', 'error'

vim.lsp.config("lua_ls", {
	on_init = function(client)
		-- Add Neovim-specific Lua settings
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Add lazy.nvim plugins to the library
					"${3rd}/luv/library",
				},
			},
		})
	end,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Global LSP configuration for all servers
vim.lsp.config("*", {
	-- Capabilities are set automatically by blink.cmp
	-- on_attach handler for any server-specific setup
	on_attach = function(client, bufnr)
		-- Additional per-buffer setup can go here if needed
		-- Keymaps are already set globally in lua/juan/remap.lua
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("jdtls.jdtls_setup").setup()
	end,
})

-- Enable LSP servers for their configured filetypes
-- These servers are installed via Mason (ensure_installed in lua/plugins/mason-lsp.lua)
vim.lsp.enable({ "lua_ls", "gopls", "vtsls", "snyk_ls" })

-- Setup golangci-lint-langserver (requires lspconfig due to custom init_options)
-- This runs alongside gopls to provide linting diagnostics
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- Define golangci-lint-langserver if not already defined
if not configs.golangci_lint_ls then
	configs.golangci_lint_ls = {
		default_config = {
			cmd = { "golangci-lint-langserver" },
			root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
			filetypes = { "go", "gomod" },
			init_options = {
				command = {
					"golangci-lint",
					"run",
					"--output.json.path",
					"stdout",
					"--show-stats=false",
					"--issues-exit-code=1",
				},
			},
		},
	}
end

-- Start the golangci-lint-langserver
lspconfig.golangci_lint_ls.setup({
	filetypes = { "go", "gomod" },
	on_attach = function(client, bufnr) end,
})
