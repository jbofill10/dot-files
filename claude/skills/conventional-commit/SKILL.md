---
name: conventional-commit
description: Use when work is complete and ready to commit, or when asked to commit changes - stages relevant files, drafts a conventional commit message, and waits for user approval before committing
---

# Conventional Commit

Create a conventional commit from the current working tree changes. Stages files explicitly, drafts a message, and waits for human approval before committing.

## Iron Law

```
NEVER push to remote without user approval via AskUserQuestion
NEVER add Co-authored-by or Signed-off-by trailers
NEVER use git add . or git add -A
NEVER commit without user approval via AskUserQuestion
NEVER stage sensitive files (.env, credentials, secrets, keys)
```

## Process

### Step 1: Analyze changes

1. Run `git status` and `git diff` (staged + unstaged) to understand what changed.
2. Run `git branch --show-current` to get the current branch name.
3. Extract the Jira ticket ID from the branch name: everything before the first underscore (e.g., `CLS-1540-2` from `CLS-1540-2_conform_supportal_rpcs`). If no underscore or no ticket pattern found, omit the ticket tag.
4. Determine the conventional commit type based on the nature of changes:
   - `feat` - new functionality
   - `fix` - bug fix
   - `refactor` - restructuring without behavior change
   - `test` - adding/updating tests
   - `docs` - documentation only
   - `chore` - maintenance, dependencies
   - `ci` - CI/CD changes
   - `build` - build system changes
   - `perf` - performance improvement
   - `style` - formatting, whitespace
5. Determine scope from the primary area of change (e.g., `points`, `promotion`, `offer`).

### Step 2: Stage files

- Stage relevant changed files by specific filename (never `git add .` or `git add -A`).
- Never stage: `.env`, credentials, secrets, keys, large binaries.
- Use `git add <file1> <file2> ...` with explicit paths.

### Step 3: Present commit message for approval

- Draft the commit message in format: `type(scope): [TICKET-ID] subject`
- Example: `fix(points): [CLS-1540-2] conform supportal rpcs with pending events cache`
- Present ONLY the commit message via `AskUserQuestion` and STOP. Wait for user to approve, edit, or reject.
- Do not show the diff -- user only wants to see the message.

### Step 4: Commit

- If approved: execute `git commit` with the approved message using HEREDOC format.
- If user provided edits: use their edited message.
- If rejected: stop, do not commit.
- Run `git status` after to verify success.

### Step 5: Offer to push

After a successful commit:

1. Run `git rev-parse --abbrev-ref @{upstream} 2>/dev/null` to check for an upstream tracking branch.
2. If no upstream, or if local is ahead of remote, ask via `AskUserQuestion`:
   - "Push `<branch>` to origin?"
   - Options: "Yes, push" / "No, I'll push later"
3. If approved: `git push -u origin <branch>`
4. If rejected: stop, do not push.

## Writing Style Rules

- Subject line under 72 characters
- No em dashes, no emojis
- Lowercase after the colon
- No period at end of subject
- Imperative mood ("add feature" not "added feature" not "adds feature")
- Sound human, not AI-generated
- Body only when the change genuinely needs explanation (multi-paragraph changes, non-obvious reasoning)

## Integration

- Can be invoked standalone when user says "commit this", "make a commit", etc.
- Can be called by other skills like `finishing-a-development-branch`.
- Pairs with `edit-pr` — the natural flow is: do work, `/conventional-commit` (commit + push), `/edit-pr`.
