# Banking Onboarding Demo

Demo / mock workspace for **banking onboarding** — personal and business account opening with KYC and KYB for bank staff.

Product scope lives in [PRD.md](./PRD.md). This is not production banking software.

## Cursor workspace context

This repo is meant as the **shared Cursor root** for a multi-folder (micro-repo) workspace. Commit Cursor config here so every micro-repo opened under the same workspace inherits the same agent context:

| Config | Path | Role |
|--------|------|------|
| Agent instructions | `AGENTS.md` | How agents work in this workspace; read `PRD.md` per task |
| Business requirements | `PRD.md` | Product goals and flows (source of truth) |
| Rules | `.cursor/rules/` | Coding and UI standards |
| Skills | `.cursor/skills/` | Repeatable workflows |
| Hooks | `.cursor/hooks.json` + `.cursor/hooks/` | Event automation |

Open this folder (or a multi-root workspace that includes it) in Cursor so rules, skills, hooks, and `AGENTS.md` apply across sibling micro-repos.

## Layout

```
.
├── PRD.md              # Business requirements
├── AGENTS.md           # Agent working agreements
├── README.md
├── .cursor/            # Shared rules, skills, hooks
├── docs/               # Design / architecture notes
└── src/                # Demo / scaffold code
```
