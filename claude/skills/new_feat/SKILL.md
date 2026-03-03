---
name: new-feat
description: Use when starting new feature work that needs a branch, optionally in an isolated worktree
context: fork
---

# New Feat

Create a branch off main for feature work. Optionally set up an isolated git worktree. Supports both new branches and existing branches.

## Usage

- `/new_feat <branch-name>` — create a new branch off main
- `/new_feat -e <branch-name>` — use an existing branch

## Process

### Step 1: Parse arguments

Extract the branch name and mode from the arguments:
- If args start with `-e`, mode is **existing branch**. Branch name is the next argument.
- Otherwise, mode is **new branch**. Branch name is the first argument.

If no branch name is provided, ask the user via `AskUserQuestion`.

### Step 2: Ask about worktree

Ask the user via `AskUserQuestion`:
- "Work in an isolated worktree?"
- Options: "Yes, create a worktree" / "No, just the branch"

### Step 3: Detect project name

Run `basename $(git rev-parse --show-toplevel)` to get the project directory name.

### Step 4: Switch to main

Run `git checkout main`. If this fails due to uncommitted changes, stop and tell the user to commit or stash first.

### Step 5: Create branch (new branch mode only)

Run `git checkout -b <branch-name>`. If the branch already exists, stop and suggest using `-e` mode instead.

### Step 6a: Create worktree (if user chose worktree)

Worktree path: `~/.claude-work/worktrees/<project-name>/<branch-name>/`

- **New branch mode:** `git worktree add <path> <branch-name>`
- **Existing branch mode:** `git worktree add <path> <branch-name>`

If the worktree path already exists, stop and report it — the worktree may already be set up.

### Step 6b: Stay in repo (if user chose no worktree)

Just check out the branch: `git checkout <branch-name>`. No worktree created.

### Step 7: Report

If worktree was created, tell the user:
- Worktree created at `<path>`
- Branch `<branch-name>` is ready
- They can `cd <path>` to work in the isolated worktree

If no worktree, tell the user:
- Branch `<branch-name>` is ready
- They are on the branch in the current repo

## Error Handling

| Error | Action |
|-------|--------|
| Dirty working tree on checkout | Stop. Tell user to commit or stash. |
| Branch already exists (new mode) | Stop. Suggest `-e` mode. |
| Worktree path already exists | Stop. Report existing path. |
| Branch doesn't exist (existing mode) | Stop. Suggest dropping `-e` flag to create it. |

## Quick Reference

| Invocation | What happens |
|------------|-------------|
| `/new_feat feat/my-feature` (with worktree) | checkout main → create branch → worktree at `~/.claude-work/worktrees/<project>/feat/my-feature/` |
| `/new_feat feat/my-feature` (without worktree) | checkout main → create branch → stay in repo |
| `/new_feat -e feat/my-feature` | same as above but for an existing branch |
