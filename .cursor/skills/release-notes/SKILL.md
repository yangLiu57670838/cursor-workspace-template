---
name: release-notes
description: Drafts release notes from recent git commits. Use when the user asks for release notes, a changelog entry, or what's new in a version.
---

# Release notes

## Workflow

1. Run `git log --oneline -20` to list recent commits
2. Group commits by type: features, fixes, docs, chores
3. Write user-facing bullets (past tense, no commit hashes in the final text)
4. Add a one-line summary at the top

## Output format

```markdown
## vX.Y.Z — [short title]

[One-sentence summary]

### Features
- ...

### Fixes
- ...

### Docs
- ...
```

## Tips

- Skip merge commits and version-bump-only commits unless relevant
- Translate internal jargon into plain language for readers
