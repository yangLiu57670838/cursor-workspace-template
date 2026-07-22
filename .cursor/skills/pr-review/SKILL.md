---
name: pr-review
description: >-
  Reviews uncommitted local changes for React patterns, correctness, PRD/acceptance
  compliance, scope, error handling, edge cases, accessibility, security, type safety,
  test quality, and unnecessary complexity. Use when the user asks for a PR review,
  code review of local changes, or to run the pr-review skill.
---

# PR review (uncommitted changes)

Review **uncommitted change files only** — not the full repo and not committed history unless the user explicitly expands scope.

## Scope of review

1. Run:

```bash
git status --short
git diff
git diff --cached
```

2. Build the file list from untracked + unstaged + staged paths only.
3. Read and review those files (and their diffs). Ignore unrelated clean files.
4. If there are no uncommitted changes, say so and stop.

## Before scoring compliance

1. Read root [PRD.md](../../../PRD.md).
2. Use **only** requirements relevant to the changed files / stated task.
3. Treat PRD goals and flow outcomes as acceptance criteria unless the user provides a separate checklist.

## Review checklist

Evaluate each changed file against:

| Area | Look for |
|------|----------|
| **React patterns / best practice** | Functional components, hooks rules, derived state vs effects, composition over prop drilling, MUI/`sx` over ad-hoc CSS when UI rules apply |
| **Correctness** | Logic bugs, wrong conditions, broken flows, race conditions, stale closures |
| **PRD / acceptance criteria** | Implements relevant PRD goals/flows; does not invent out-of-scope product behavior |
| **Scope** | Diff matches the task; no drive-by refactors or unrelated files |
| **Error handling** | Failed requests, empty states, validation errors surfaced to the user; no silent catches |
| **Missing edge cases** | Null/empty lists, loading/error retries, partial KYC/KYB data, cancelled navigation |
| **Accessibility** | Labels, focus order, keyboard use, ARIA where needed, meaningful button/link text |
| **Security** | No secrets in code; no unsafe HTML; authz assumptions; PII handling in logs/UI |
| **Type safety** | No unjustified `any`; narrow unions; props and API responses typed |
| **Test quality** | Tests assert behavior (not implementation trivia); cover happy path + key failures if tests changed |
| **Unnecessary complexity** | Over-abstraction, dead code, premature generalization, deep nesting |

Skip checklist rows that clearly do not apply to a file (e.g. no a11y notes for pure docs).

## React focus (when `.tsx` / hooks change)

- Prefer controlled forms with explicit validation over hidden side effects
- Keep effects minimal; derive values during render when possible
- Colocate UI state; lift only when shared
- Lists need stable keys (not array index if order can change)
- Follow [docs/design.md](../../../docs/design.md) when UI files are in the diff

## Severity

- **Blocker** — wrong behavior, PRD miss, security issue, or broken type/contract
- **Major** — likely bug, missing error path, serious a11y gap, weak types in hot paths
- **Minor** — style, clarity, small edge case, optional test gap
- **Nit** — optional polish

## Output format

```markdown
## PR review (uncommitted)

**Files reviewed:** (paths from git status/diff only)
**PRD slice used:** (short — which goals/flows applied)

### Findings
- [Blocker|Major|Minor|Nit] `path` — finding; why it matters; suggested fix

### PRD / acceptance
- Met: ...
- Gaps: ...
- Out of scope in diff: ...

### Summary
- Ship / fix before merge / needs discussion
```

## Rules

- Findings only — no praise filler
- Every finding cites a file path (and line when useful)
- Do not request changes outside the uncommitted set unless a missing file blocks correctness
- Do not restate the entire PRD; cite only the slice you used
