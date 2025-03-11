local harpoon = require("harpoon")

-- REQUIRED
harpoon.setup({
    global_settings = {
        sync_on_ui_close = true,
        save_on_toggle = true,
        save_on_change = true,
        enter_on_sendcmd = true,
        tmux_autoclose_windows = false, -- Changed from 0 to false
        excluded_filetypes = { "harpoon" },
        --mark_branch = true,
    }
})
require('telescope').load_extension('harpoon')
