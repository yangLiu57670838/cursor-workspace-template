# PRD: Cursor Workspace Template

## Overview

A minimal, copy-friendly repository that demonstrates how to configure a Cursor workspace with **Rules**, **Skills**, **Agents**, and **Hooks**. The repo contains no production application code — only documentation and Cursor configuration examples.

## Goals

| Goal | Success criteria |
|------|------------------|
| Teach Cursor workspace configuration | README explains each config type with file paths and examples |
| Provide working examples | Rules, skills, hooks, and AGENTS.md load when the repo is opened in Cursor |
| Stay minimal | Entire template is readable in one sitting; no heavy dependencies |
| Be fork-friendly | Teams can clone, rename, and extend without deleting boilerplate |

## Non-goals

- Shipping a runnable application or CI pipeline
- Replacing Cursor product documentation
- Covering every hook event or rule option (see linked Cursor docs in README)

## Target users

- Engineers setting up AI-assisted workflows for a team repo
- Tech leads evaluating how to encode conventions for Cursor Agent
- Anyone learning the difference between rules, skills, agents, and hooks

## Configuration surfaces

### 1. Rules (`.cursor/rules/*.mdc`)

Persistent instructions injected into Agent context.

- **Always-on rules** — project-wide standards (`alwaysApply: true`)
- **File-scoped rules** — apply when matching files are open (`globs`)

**Demo files:** `core-standards.mdc`, `typescript-conventions.mdc`

### 2. Skills (`.cursor/skills/<name>/SKILL.md`)

Reusable workflows the agent loads when relevant. Skills use YAML frontmatter (`name`, `description`) and step-by-step instructions.

- **Project skills** — committed in `.cursor/skills/` (shared with the repo)
- **Personal skills** — `~/.cursor/skills/` (not in this template)

**Demo file:** `.cursor/skills/release-notes/SKILL.md`

### 3. Agent instructions (`AGENTS.md`)

Repository-level guidance for Cursor Agent: architecture, commands, boundaries, and where to find deeper docs. Loaded as persistent context for agent sessions in this repo.

**Demo file:** `AGENTS.md`

### 4. Hooks (`.cursor/hooks.json` + `.cursor/hooks/*`)

Scripts or prompt checks that run on Cursor events (file edit, shell command, session start, etc.). Hooks receive JSON on stdin and return JSON on stdout.

**Demo files:** `hooks.json`, `hooks/log-session-start.sh`

## Repository layout

```
cursor-workspace-template/
├── PRD.md                 # This document
├── README.md              # Setup and usage guide
├── AGENTS.md              # Agent instructions for this repo
├── .cursor/
│   ├── rules/             # Project rules (.mdc)
│   ├── skills/            # Project skills (SKILL.md per skill)
│   ├── hooks.json         # Hook event registry
│   └── hooks/             # Hook scripts
├── docs/
│   └── architecture.md    # Example doc referenced by rules/agents
└── src/
    └── example.ts           # Example source for file-scoped rules
```

## Customization checklist

When forking this template for a real project:

1. Update `AGENTS.md` with your stack, commands, and repo boundaries
2. Replace demo rules with your coding standards
3. Add skills for repeated team workflows (deploy, PR template, incident runbook)
4. Add hooks only where automation is worth the maintenance (format-on-save, secret scanning)
5. Remove or replace `src/example.ts` with your application code

## Out of scope for v1

- MCP server configuration (add `.cursor/mcp.json` separately if needed)
- Cursor Automations (cloud/scheduled agents)
- User-level config (`~/.cursor/`) — document in README only

## References

- [Cursor Rules](https://docs.cursor.com/context/rules)
- [Cursor Skills](https://docs.cursor.com/context/skills)
- [Cursor Hooks](https://docs.cursor.com/agent/hooks)
