require("neo-tree").setup({
	filesystem = {
        follow_current_file = {
        enabled = true,
        -- Other options can be added here if needed
    },
    filtered_items = {
        visible = true,
        hide_dotfiles = false,
        never_show = {
            ".claude",
            "CLAUDE.md",
        }
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
