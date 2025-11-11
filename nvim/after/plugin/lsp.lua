-- LSP configuration using native Neovim 0.11+ API
-- Keymaps are configured globally in lua/juan/remap.lua

-- Configure lua_ls with Neovim-specific settings
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

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'java',
    callback = function()
        require 'jdtls.jdtls_setup'.setup()
    end,
})

-- Enable LSP servers for their configured filetypes
-- These servers are installed via Mason (ensure_installed in lua/plugins/mason-lsp.lua)
vim.lsp.enable({ "lua_ls", "gopls", "vtsls" })
