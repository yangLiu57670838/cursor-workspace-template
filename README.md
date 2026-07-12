# Cursor Workspace Template

A demo repository showing how to define **Rules**, **Skills**, **Agent instructions**, and **Hooks** for a Cursor workspace. Use it as a starting point when onboarding a team to AI-assisted development.

See [PRD.md](./PRD.md) for product goals and layout.

## Quick start

1. Clone or fork this repo
2. Open the folder in [Cursor](https://cursor.com)
3. Open **Cursor Settings → Rules** to confirm project rules appear
4. Open **Cursor Settings → Hooks** to confirm hooks are registered
5. Start an Agent chat and ask: *"Follow the release-notes skill to draft notes for a patch release"*

## What goes where

| Concept | Location | Scope | When it applies |
|---------|----------|-------|-----------------|
| **Rules** | `.cursor/rules/*.mdc` | Project (git) | Always, or when matching files are open |
| **Skills** | `.cursor/skills/<name>/SKILL.md` | Project (git) | When the agent decides the skill is relevant |
| **Agent** | `AGENTS.md` (repo root) | Project (git) | Every Agent session in this repo |
| **Hooks** | `.cursor/hooks.json` + `.cursor/hooks/*` | Project (git) | On Cursor events (edit, shell, session, etc.) |

Personal equivalents (not committed):

| Concept | Personal location |
|---------|-------------------|
| User rules | Cursor Settings → Rules (User) |
| User skills | `~/.cursor/skills/<name>/SKILL.md` |
| User hooks | `~/.cursor/hooks.json` + `~/.cursor/hooks/*` |

> **Note:** Built-in Cursor skills live in `~/.cursor/skills-cursor/` and are managed by Cursor — do not copy files there.

## Rules

Rules are Markdown files with YAML frontmatter in `.cursor/rules/`.

```markdown
---
description: Brief summary shown in the rule picker
globs: **/*.ts          # optional — file pattern
alwaysApply: false      # true = every conversation
---

# Rule title

Your instructions here.
```

**Examples in this repo:**

- [`core-standards.mdc`](.cursor/rules/core-standards.mdc) — always-on project conventions
- [`typescript-conventions.mdc`](.cursor/rules/typescript-conventions.mdc) — applies when editing `src/**/*.ts`

Create new rules with the `/create-rule` command in Cursor or by adding `.mdc` files manually.

## Skills

Skills teach the agent a repeatable workflow. Each skill is a directory with a `SKILL.md` file:

```
.cursor/skills/release-notes/
└── SKILL.md
```

Required frontmatter:

```yaml
---
name: release-notes
description: Drafts release notes from git history. Use when the user asks for release notes or changelog entries.
---
```

Optional fields:

- `disable-model-invocation: true` — skill only loads when explicitly invoked (default for most skills)

**Example in this repo:** [`.cursor/skills/release-notes/SKILL.md`](.cursor/skills/release-notes/SKILL.md)

Add supporting files (`reference.md`, `scripts/`) for longer workflows.

## Agent instructions (`AGENTS.md`)

`AGENTS.md` at the repo root gives Cursor Agent durable context about:

- Project purpose and directory layout
- Commands to run (test, lint, build)
- What not to touch
- Pointers to deeper docs

See [AGENTS.md](./AGENTS.md) in this repo.

Some teams also use `.cursor/rules/` with `alwaysApply: true` for overlapping concerns; prefer `AGENTS.md` for repo-wide agent orientation and rules for enforceable coding standards.

## Hooks

Hooks run scripts or LLM prompt checks on agent and editor events.

**Registry:** [`.cursor/hooks.json`](.cursor/hooks.json)

```json
{
  "version": 1,
  "hooks": {
    "sessionStart": [
      { "command": ".cursor/hooks/log-session-start.sh" }
    ]
  }
}
```

**Script:** [`.cursor/hooks/log-session-start.sh`](.cursor/hooks/log-session-start.sh)

Common events:

| Event | Use case |
|-------|----------|
| `sessionStart` / `sessionEnd` | Session setup or audit |
| `beforeShellExecution` | Approve or block shell commands |
| `afterFileEdit` | Format or validate after edits |
| `beforeSubmitPrompt` | Policy checks on user prompts |
| `preToolUse` / `postToolUse` | Gate or enrich tool calls |

Hook scripts read JSON from stdin and write JSON to stdout. Make scripts executable:

```bash
chmod +x .cursor/hooks/*.sh
```

Verify hooks in **Cursor Settings → Hooks** or the **Hooks** output channel.

## Directory map

```
.
├── AGENTS.md
├── PRD.md
├── README.md
├── .cursor/
│   ├── rules/
│   ├── skills/
│   ├── hooks.json
│   └── hooks/
├── docs/
│   └── architecture.md
└── src/
    └── example.ts
```

## Extending this template

1. **Real app code** — replace `src/example.ts` with your source tree
2. **MCP** — add `.cursor/mcp.json` for external tools (GitHub, Linear, etc.)
3. **More rules** — one concern per rule; keep each under ~50 lines
4. **Team skills** — encode PR review, deploy, or on-call runbooks in `.cursor/skills/`
5. **Safety hooks** — e.g. `beforeShellExecution` to flag network or destructive commands

## License

MIT — use freely for demos and internal templates.
