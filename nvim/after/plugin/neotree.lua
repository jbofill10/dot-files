require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
		},
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(arg)
				vim.cmd([[
          setlocal relativenumber
        ]])
			end,
		},
	},
})
