local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
    'ts_ls',
    'jsonls',
    'html',
    'cssls',
    'bashls',
    'vimls',
    'pyright',
    'rust_analyzer',
    'gopls',
    'lua_ls',
    'eslint',

})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    --lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup({
    jdtls = function()
        return true
    end
})
