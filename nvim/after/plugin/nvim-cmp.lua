local cmp = require'cmp'

-- reverse tab for copilot. enter for completion
cmp.setup({
  mapping = {
    -- Remove Tab key mapping
    ['<Tab>'] = cmp.mapping(function(fallback)
      fallback()  -- Default behavior for tab can be removed or replaced
    end, {'i', 's'}),  -- 'i' for insert mode, 's' for select mode
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
})
