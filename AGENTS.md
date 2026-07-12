# Agent instructions

This repository is a **Cursor workspace template** for demo and onboarding. It is not a production application.

## Purpose

Demonstrate how to configure Cursor with rules, skills, hooks, and agent instructions. When helping users here, prefer explaining and extending these patterns over building unrelated features.

## Layout

| Path | Purpose |
|------|---------|
| `PRD.md` | Product requirements for this template |
| `README.md` | Human-facing setup guide |
| `AGENTS.md` | This file — agent context |
| `.cursor/rules/` | Persistent coding and doc standards |
| `.cursor/skills/` | Repeatable workflows (e.g. release notes) |
| `.cursor/hooks.json` | Event-driven automation |
| `docs/architecture.md` | Example architecture doc |
| `src/` | Minimal TypeScript example for file-scoped rules |

## Commands

This demo repo has no build or test pipeline. If you add tooling later, document commands here, for example:

```bash
npm install
npm test
npm run lint
```

## Working agreements

- **Minimize scope** — small, focused changes; this is a teaching repo
- **Match existing patterns** — follow rule and skill file formats already in `.cursor/`
- **Do not** create skills under `~/.cursor/skills-cursor/` (Cursor-managed only)
- **Do not** add heavy dependencies unless the user asks for a real app scaffold
- **Prefer project scope** — commit rules, skills, and hooks under `.cursor/` so the team shares them

## When to use skills vs rules

- **Rules** — static standards (style, naming, error handling)
- **Skills** — multi-step workflows with checklists or scripts (release notes, incident response)
- **Hooks** — deterministic automation on events (logging, formatting, gating commands)

## Deeper docs

- [README.md](./README.md) — configuration overview
- [PRD.md](./PRD.md) — goals and customization checklist
- [docs/architecture.md](./docs/architecture.md) — example system doc
