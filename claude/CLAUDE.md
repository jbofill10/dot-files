## Writing Style

Direct and to the point. Fewer words without embellishments.

## Model selection for delegated work

When delegating work to a subagent, infer the appropriate model based on task complexity and pass that work to the corresponding agent definition:

- **Haiku** — trivial lookups, simple file reads, mechanical edits, quick factual questions
- **Sonnet** — typical coding, refactoring, debugging, moderate research, most everyday tasks
- **Opus** — architecturally complex work, deep multi-file reasoning, tricky debugging, novel design decisions

Pick the smallest model that can plausibly handle the task well. When in doubt between two tiers, pick the lower one first.
