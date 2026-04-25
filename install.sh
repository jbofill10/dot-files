#!/usr/bin/env bash
# Symlinks tracked dotfiles into the locations they belong on the OS.
# Idempotent: re-running is safe. Backs up real files/dirs before replacing.
#
# Usage:
#   ./install.sh            # install
#   ./install.sh --dry-run  # show what would change, do nothing
#
set -euo pipefail

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

log()  { printf '%s\n' "$*"; }
run()  { if [ "$DRY_RUN" = 1 ]; then log "DRY: $*"; else eval "$@"; fi; }

# link <src-relative-to-repo> <dest-absolute>
link() {
  local src="$REPO_DIR/$1"
  local dest="$2"

  if [ ! -e "$src" ]; then
    log "SKIP: source missing: $src"
    return
  fi

  # Already correct symlink?
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    log "OK:   $dest -> $src"
    return
  fi

  # Ensure parent exists
  run "mkdir -p \"$(dirname "$dest")\""

  # Back up anything currently at the destination
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    run "mkdir -p \"$BACKUP_DIR$(dirname "$dest")\""
    run "mv \"$dest\" \"$BACKUP_DIR$dest\""
    log "BACKUP: $dest -> $BACKUP_DIR$dest"
  fi

  run "ln -s \"$src\" \"$dest\""
  log "LINK: $dest -> $src"
}

log "Repo: $REPO_DIR"
[ "$DRY_RUN" = 1 ] && log "(dry-run — no changes will be made)"

# --- Claude Code ---
link "claude/CLAUDE.md"              "$HOME/.claude/CLAUDE.md"
link "claude/settings.json"          "$HOME/.claude/settings.json"
link "claude/statusline-command.sh"  "$HOME/.claude/statusline-command.sh"
link "claude/agents"                 "$HOME/.claude/agents"
link "claude/commands"               "$HOME/.claude/commands"
link "claude/hooks"                  "$HOME/.claude/hooks"
link "claude/skills"                 "$HOME/.claude/skills"

# --- Add other tools below as needed ---
# link "nvim"     "$HOME/.config/nvim"
# link "kitty"    "$HOME/.config/kitty"
# link "tmux/.tmux.conf" "$HOME/.tmux.conf"
# link "wezterm/.wezterm.lua" "$HOME/.wezterm.lua"

log "Done."
if [ -d "$BACKUP_DIR" ]; then
  log "Backups stored under: $BACKUP_DIR"
fi
