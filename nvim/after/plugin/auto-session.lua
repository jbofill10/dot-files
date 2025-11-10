require("auto-session").setup {
    auto_restore = false,
    auto_restore_last_session = false,
    auto_save = true,
    git_use_branch_name = true,
    log_level = "error",
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" }
}
