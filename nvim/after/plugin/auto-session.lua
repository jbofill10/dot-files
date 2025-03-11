require("auto-session").setup {
    auto_restore_enabled = false,
    auto_restore_last_session = false,
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    auto_save_enabled = true,
    auto_session_use_git_branch = true,
    log_level = "error"
}
