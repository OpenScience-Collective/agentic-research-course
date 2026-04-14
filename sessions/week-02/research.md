# Week 2 Research: Setting Up Claude Code for Research

Research compiled from official Anthropic documentation at [code.claude.com/docs](https://code.claude.com/docs/en/overview) and [claude.com](https://claude.com), April 2026.

---

## Table of Contents

1. [Week 1 Recap for New Audience](#1-week-1-recap-for-new-audience)
2. [What Is Claude Code (and How It Differs from Claude Chat and Claude Cowork)](#2-what-is-claude-code)
3. [How to Set Up Claude Code](#3-how-to-set-up-claude-code)
4. [Interfaces: Terminal, VS Code, Desktop App, Web, Conductor](#4-interfaces)
5. [Core Concepts: Plugins, Skills, MCP, Hooks, Agents](#5-core-concepts)
6. [CLAUDE.md and AGENTS.md](#6-claudemd-and-agentsmd)
7. [Plan Mode](#7-plan-mode)
8. [Built-in Commands and Bundled Skills](#8-built-in-commands-and-bundled-skills)
9. [Anthropic Best Practices (Official)](#9-anthropic-best-practices)
10. [Our Recommended Workflow: research-skills Plugin](#10-our-recommended-workflow)
11. [Pricing, Teams, and Academic/Nonprofit Discounts](#11-pricing-and-discounts)
12. [Open Questions and Design Decisions](#12-open-questions)

---

## 1. Week 1 Recap for New Audience

**Context:** Audience grew ~10x since Week 1. Many attendees missed the foundational session. Need to cover basics without boring returning participants.

### Tension to Resolve

The current outline allocates 3 minutes for a Week 1 recap. With a 10x larger audience, many of whom missed Week 1 entirely, this is insufficient. Options:

- **Option A (8-10 min recap):** Cover git/GitHub/terminal basics properly, compress other sections.
- **Option B (short recap + async):** Keep 3-min recap with pointers to the Week 1 recording and setup guide. Trust newcomers to catch up.
- **Option C (hybrid):** 5-min recap of the critical concepts, plus a "Week 1 Essentials" one-pager linked in the session materials.

### Key Concepts to Recap

**What is version control (git)?**
- A system that tracks every change to your files over time
- Every save point is called a "commit," a snapshot of your project at that moment
- You can go back to any previous snapshot, compare changes, and work in parallel
- Think of it as unlimited undo with full history

**What is git vs GitHub?**
- **git:** the tool that runs on your machine, tracks changes locally
- **GitHub:** the website/service that stores your git repositories online, enables collaboration (pull requests, issues, code review)
- Analogy: git is like Word's "Track Changes"; GitHub is like Google Docs, the shared workspace

**What is the terminal/command line?**
- A text-based interface to your computer (instead of clicking icons)
- Claude Code lives here; it reads/writes files, runs commands, and interacts with git
- Essential commands: `cd` (navigate), `ls` (list files), `pwd` (where am I), `mkdir` (create directory)

**What is `gh` (GitHub CLI)?**
- Command-line tool for GitHub operations: create repos, open PRs, manage issues
- Claude Code uses `gh` heavily for GitHub integration
- Must be installed and authenticated separately from git

**Why this matters for AI-assisted research:**
- AI tools generate code 10x faster, so mistakes accumulate 10x faster without guardrails
- Git is the undo button: `git diff` shows what changed, `git revert` brings you back
- Structured workflows (issues, branches, PRs) create review checkpoints
- Without version control, an AI coding agent is a power tool with no safety guard

---

## 2. What Is Claude Code

### Claude Code

An **agentic coding tool** that reads your codebase, edits files, runs commands, and integrates with development tools. Unlike a chatbot that answers questions and waits, Claude Code autonomously explores, plans, and implements changes.

Source: [code.claude.com/docs/en/overview](https://code.claude.com/docs/en/overview)

### How Claude Code Differs from Claude Chat and Claude Cowork

| Feature | Claude Chat | Claude Code | Claude Cowork |
|---------|------------|-------------|---------------|
| **What it is** | Conversational AI in browser/app | Agentic coding tool | Agentic knowledge work tool |
| **Where it runs** | Browser, desktop app, mobile | Terminal, VS Code, JetBrains, desktop app, web | Claude Desktop app only |
| **File access** | Upload/download only | Full read/write to project files | Read/write to granted folders |
| **Can run commands** | No (except code execution sandbox) | Yes, full terminal access | Yes, in isolated VM |
| **Target user** | Everyone | Developers, researchers who code | Knowledge workers (analysts, legal, operations) |
| **Autonomy** | Responds to each message | Plans and implements multi-step tasks | Completes multi-step tasks autonomously |
| **Git integration** | None | Deep (commits, PRs, branches) | None |
| **Requires coding** | No | Comfortable with terminal | No |

**Claude Cowork** is Anthropic's newest agentic product (generally available as of April 2026; some features still in research preview). It brings agentic capabilities to the Claude Desktop app for non-coding tasks: creating spreadsheets with formulas, PowerPoint presentations, formatted documents, data analysis. It runs code in an isolated VM on your computer, can coordinate sub-agents in parallel, and supports scheduled tasks. Available on Pro, Max, Team, and Enterprise plans.

Source: [claude.com/product/cowork](https://claude.com/product/cowork), [support.claude.com](https://support.claude.com/en/articles/13345190-get-started-with-claude-cowork)

### Key Capabilities of Claude Code

- Read your entire codebase and understand project structure
- Write and edit code across multiple files
- Run terminal commands (build, test, lint)
- Create git commits, branches, and pull requests
- Connect to external tools via MCP (Model Context Protocol)
- Spawn sub-agents for parallel work
- Schedule recurring tasks
- Work across terminal, IDE, desktop app, and browser

---

## 3. How to Set Up Claude Code

### Prerequisites

- A terminal (macOS Terminal, iTerm2, VS Code terminal, Windows PowerShell/CMD)
- A Claude subscription (Pro at $20/month, Max from $100/month, Team, or Enterprise) OR an Anthropic Console account (API access, pay-per-token)

### Installation Methods

| Method | Command | Auto-updates? |
|--------|---------|---------------|
| **Native (recommended)** | macOS/Linux: `curl -fsSL https://claude.ai/install.sh \| bash` | Yes |
| | Windows PowerShell: `irm https://claude.ai/install.ps1 \| iex` | Yes |
| **Homebrew** | `brew install --cask claude-code` | No (`brew upgrade claude-code`) |
| **WinGet** | `winget install Anthropic.ClaudeCode` | No (`winget upgrade`) |

Windows native setups require [Git for Windows](https://git-scm.com/downloads/win).

### First Run

```bash
cd your-project
claude
```

Prompted to log in on first use. That's it.

### Authentication

- First launch opens browser for login
- Supports: Claude subscription (Pro/Max/Team/Enterprise) or Anthropic Console account (API)
- Terminal CLI and VS Code also support third-party providers (AWS Bedrock, Google Vertex AI)
- Check status: `claude auth status`
- Switch accounts: `/login` in session

### Permission Model

Claude Code asks permission before taking actions. Three key modes:

| Mode | Behavior | When to use |
|------|----------|-------------|
| **Default** | Asks before file edits and shell commands | Starting out, learning the tool |
| **Accept Edits** | Auto-approves file edits plus filesystem commands (mkdir, touch, mv, cp, rm, sed); asks for other shell commands | Trusted coding sessions |
| **Plan Mode** | Prevents edits; Claude can still read files and run shell commands (with normal permission prompts), but cannot modify your source | Complex changes, unfamiliar code |
| **Auto Mode** | Background classifier evaluates safety, blocks risky actions | Team/Enterprise/API plan only; requires Sonnet 4.6 or Opus 4.6; opt-in via `--enable-auto-mode` |

Cycle modes with `Shift+Tab`. The default cycle covers `default`, `acceptEdits`, and `plan`. Auto mode must be enabled with `--enable-auto-mode` (Team/Enterprise/API only, not Pro/Max). Configure permanent rules with `/permissions`.

Source: [code.claude.com/docs/en/overview](https://code.claude.com/docs/en/overview), [code.claude.com/docs/en/permission-modes](https://code.claude.com/docs/en/permission-modes)

---

## 4. Interfaces

### Terminal CLI (Primary)

Full-featured command-line interface. All features available. This is what we teach in the course.

### VS Code Extension

- Install from Extensions marketplace (search "Claude Code")
- Inline diffs, @-mentions, plan review, conversation history in editor
- Good for researchers who prefer a visual editor
- Also works in Cursor IDE

### JetBrains Plugin

- IntelliJ IDEA, PyCharm, WebStorm, and other JetBrains IDEs
- Interactive diff viewing, selection context sharing

### Claude Code Desktop App (by Anthropic)

- Standalone app for macOS and Windows
- Visual diff review, multiple sessions side-by-side
- Schedule recurring tasks, kick off cloud sessions
- Installation instructions on the [Claude Code overview page](https://code.claude.com/docs/en/overview)

### Claude Code on the Web

- Browser-based at [claude.ai/code](https://claude.ai/code)
- No local setup needed
- Long-running tasks, work on repos you don't have locally
- Also available via Claude iOS app

### Conductor (Third-Party)

- **What:** Third-party macOS desktop app for orchestrating teams of coding agents
- **Not by Anthropic;** wraps Claude Code (and optionally OpenAI Codex) in a native GUI
- **Key features beyond CLI:**
  - Parallel agents: Spin up multiple Claude Code instances in isolated workspaces (separate git branch per workspace)
  - Visual diff viewer for reviewing changes
  - Checkpoints: turn-by-turn snapshots of Claude's changes, independent from git
  - Scripts: automation hooks for setup, run, and archive
  - Todos: task checklist that blocks merging until complete
  - Guided PR workflow from issue to merge
- **Platform:** macOS only (Windows/Linux in development)
- **Cost:** Currently free; uses your own Claude Code credentials
- **Privacy:** Chat stays local; analytics collected via PostHog
- **Docs:** [docs.conductor.build](https://docs.conductor.build/)

**Course recommendation:** Mention Conductor as a third-party option for students who prefer a GUI, but teach with the terminal CLI for universality.

All official surfaces (terminal, VS Code, JetBrains, desktop app, web) connect to the same Claude Code engine. CLAUDE.md files, settings, and MCP servers work across all of them.

---

## 5. Core Concepts: Plugins, Skills, MCP, Hooks, Agents

### Concept Map

```
Plugin [distributable package]
├── Skills [workflow/knowledge, on-demand]
├── Hooks [automated actions at lifecycle points]
├── Agents [specialized workers with own context]
├── MCP servers [external tool connectors]
└── Settings [default configuration]

CLAUDE.md [persistent instructions, loaded every session]
Auto-memory [Claude's self-written notes, loaded every session]
```

### Plugin

A **distributable package** of Claude Code extensions (skills, hooks, agents, MCP servers) that can be installed from marketplaces.

- Install with `/plugin install name@marketplace`
- Skills are namespaced: `/plugin-name:skill-name`
- Has a manifest at `.claude-plugin/plugin.json`
- Can include `skills/`, `agents/`, `hooks/`, `.mcp.json`, `bin/`

**When to use:** When you want to share a set of tools with a team or community. Our research-skills plugin is an example.

**When NOT to use:** For personal, project-specific customizations, just put files in `.claude/` directly.

Source: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)

### Skill

A **workflow or knowledge base** stored as a `SKILL.md` file. Claude uses skills when relevant, or you invoke them with `/skill-name`. Skills load on-demand (not every session), so detailed reference material costs nothing until needed.

- Stored in `.claude/skills/<name>/SKILL.md` (project) or `~/.claude/skills/<name>/SKILL.md` (personal)
- YAML frontmatter controls behavior: `description`, `disable-model-invocation`, `allowed-tools`, `context: fork`
- Can include supporting files (templates, scripts, examples)
- Bundled skills ship with Claude Code: `/simplify`, `/batch`, `/debug`, `/loop`, `/claude-api`

**When to use:** You keep pasting the same playbook, checklist, or multi-step procedure into chat. Or a section of CLAUDE.md has grown into a procedure rather than a fact.

**Skill vs CLAUDE.md:** CLAUDE.md is loaded every session (facts, rules, conventions). Skills load on demand (procedures, workflows, checklists).

Source: [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)

### MCP (Model Context Protocol)

An **open standard** for connecting Claude Code to external tools and data sources. MCP servers expose tools that Claude can call.

- Configure with `claude mcp add <name> <command>` or `.mcp.json` file
- Examples: read Google Drive docs, update Jira tickets, query databases, pull Slack messages, drive MATLAB via matlab-mcp-tools
- Tools are deferred by default (only names in context until used)

**When to use:** Connect Claude to external services it can't reach through the terminal. Our practicum uses matlab-mcp-tools to drive EEGLAB from Claude Code.

Source: [code.claude.com/docs/en/mcp](https://code.claude.com/docs/en/mcp)

### Hook

**Automated shell commands, HTTP endpoints, or LLM prompts** that execute at specific lifecycle points. Unlike CLAUDE.md instructions (advisory), hooks are deterministic and guaranteed.

- Configured in `settings.json` under `"hooks"` key
- Events: `SessionStart`, `PreToolUse`, `PostToolUse`, `Stop`, `UserPromptSubmit`, and many more
- Can block, allow, modify, or provide feedback on actions
- Four types: command, http, prompt, agent

**When to use:** Actions that MUST happen every time with zero exceptions. Examples: run linter after every file edit, block destructive commands, auto-format code.

**Hook vs CLAUDE.md:** CLAUDE.md says "please do X." Hooks enforce "X will happen."

Source: [code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks)

### Agent (Subagent)

A **specialized AI worker** that runs in its own context window with its own system prompt, tools, and permissions.

- Defined in `.claude/agents/<name>.md` with YAML frontmatter
- Built-in types: `Explore` (read-only), `Plan` (planning), `general-purpose`
- Can restrict tools, specify model (e.g., use Haiku for cheap tasks)
- Claude delegates automatically based on agent description, or you trigger explicitly

**When to use:** Tasks that would flood your main conversation with file reads, logs, or search results. The subagent does the work in its own context and returns only a summary.

**Agent vs Skill:** Skills add knowledge/procedures to your conversation. Agents run in separate context windows and return summaries.

Source: [code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents)

### Decision Tree

| Need | Use |
|------|-----|
| Persistent instructions for every session | CLAUDE.md |
| Repeatable workflow or checklist | Skill |
| Automated action at lifecycle point | Hook |
| Isolated worker for a side task | Agent (subagent) |
| External tool/API connector | MCP server |
| Distributable package of all the above | Plugin |

---

## 6. CLAUDE.md and AGENTS.md

### What Is CLAUDE.md

A markdown file containing **persistent instructions** that Claude reads at the start of every session. You write it; it guides Claude's behavior. It is context, not enforced configuration; the more specific and concise, the better adherence.

### Scope Hierarchy (Most Specific Wins)

| Scope | Location | Shared with | Use case |
|-------|----------|-------------|----------|
| **Managed policy** | System-level (IT-deployed) | All users | Company standards, security policies |
| **Project** | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Team (via git) | Project architecture, coding standards |
| **User** | `~/.claude/CLAUDE.md` | Just you | Personal preferences across all projects |
| **Local** | `./CLAUDE.local.md` (gitignored) | Just you | Personal project-specific notes |

CLAUDE.md files in parent directories are also loaded (useful for monorepos). Subdirectory CLAUDE.md files load on demand when Claude works with files there.

### What to Include

- Build and test commands Claude can't guess
- Code style rules that differ from defaults
- Testing instructions and preferred runners
- Repository etiquette (branch naming, PR conventions)
- Architectural decisions specific to your project
- Common gotchas or non-obvious behaviors
- `[NEVER DO THIS]` section for hard rules

### What NOT to Include

- Anything Claude can figure out by reading code
- Standard language conventions Claude already knows
- Detailed API documentation (link to docs instead)
- Information that changes frequently
- Long tutorials or explanations
- Self-evident practices like "write clean code"

### Best Practices (from Official Docs)

- **Keep under 200 lines.** Longer files cause Claude to ignore rules due to context pressure.
- **Use markdown headers and bullets.** Structure helps Claude scan like readers do.
- **Be specific:** "Use 2-space indentation" beats "format code properly."
- **Remove conflicting instructions.** If two rules contradict, Claude picks one arbitrarily.
- **Use `/init` to generate a starting CLAUDE.md.** Claude analyzes your codebase and creates a file. Refine from there.
- **Import files with `@path` syntax:** `@README.md`, `@docs/conventions.md`, `@~/.claude/my-notes.md`

### `.claude/rules/` Directory

For larger projects, organize instructions into multiple files:

```
.claude/
├── CLAUDE.md              # Main instructions
└── rules/
    ├── code-style.md      # Code style guidelines
    ├── testing.md          # Testing conventions
    └── security.md         # Security requirements
```

Rules can be **path-scoped** with YAML frontmatter:

```markdown
---
paths:
  - "src/api/**/*.ts"
---
# API Development Rules
- All endpoints must validate input
```

These only load when Claude works with matching files, saving context.

### AGENTS.md

**Claude Code does NOT read AGENTS.md.** If your repo uses AGENTS.md for other tools, create a CLAUDE.md that imports it:

```markdown
@AGENTS.md

## Claude Code Specific
Use plan mode for changes under src/billing/.
```

### Auto Memory

Claude also maintains **auto-memory** at `~/.claude/projects/<project>/memory/MEMORY.md`. Claude writes this itself based on your corrections and discovered patterns. First 200 lines OR 25KB (whichever comes first) loaded every session. Machine-local, not shared.

Toggle with `/memory` command.

Source: [code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory)

---

## 7. Plan Mode

### What It Is

A permission mode that **prevents edits**. Claude can still read files and run shell commands (subject to normal permission prompts), but cannot modify your source. Claude gathers information, asks questions, and creates a detailed implementation plan for your approval before making any changes.

### How to Enter/Exit

- **Shift+Tab** to cycle permission modes (Default, Accept Edits, Plan)
- **`/plan [description]`** to enter plan mode with an optional task
- **Shift+Tab** again to exit back to normal mode

### Recommended Workflow (Official Anthropic Pattern)

1. **Explore** (Plan Mode): Claude reads files, answers questions, builds understanding
2. **Plan** (Plan Mode): Claude creates detailed implementation plan
3. **Review** (You): Press `Ctrl+G` to open plan in your text editor for editing
4. **Implement** (Normal Mode): Switch back, Claude implements the approved plan
5. **Commit** (Normal Mode): Claude commits with descriptive message, opens PR

### When to Use Plan Mode

- Uncertain about the approach
- Change affects multiple files
- Unfamiliar with the codebase being modified
- Complex architectural decisions

### When to Skip

- Scope is clear and fix is small (typo, log line, variable rename)
- Task is exploratory
- You can describe the diff in one sentence

Source: [code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices)

---

## 8. Built-in Commands and Bundled Skills

### Essential Commands (Built-in)

| Command | Purpose |
|---------|---------|
| `/help` | Show available commands |
| `/init` | Generate starter CLAUDE.md by analyzing your codebase |
| `/plan [description]` | Enter plan mode |
| `/clear` | Clear conversation, reset context (aliases: `/reset`, `/new`) |
| `/compact [focus]` | Summarize conversation to free context |
| `/config` | Open settings (theme, model, permissions) |
| `/model [name]` | Switch model (opus, sonnet, haiku) |
| `/effort [level]` | Set reasoning effort (low/medium/high/max) |
| `/memory` | Edit CLAUDE.md, toggle auto-memory |
| `/permissions` | Manage tool allow/deny rules |
| `/diff` | Interactive diff viewer for uncommitted changes |
| `/rewind` | Restore code and/or conversation to previous point |
| `/resume` | Resume a previous session |
| `/cost` | Show token usage |
| `/context` | Visualize context window usage |
| `/doctor` | Diagnose installation issues |
| `/mcp` | Manage MCP server connections |
| `/plugin` | Manage plugins |
| `/agents` | Manage agent configurations |
| `/hooks` | Browse hook configurations |
| `/desktop` | Continue session in desktop app |
| `/schedule` | Create cloud scheduled tasks |
| `/btw <question>` | Quick side question without adding to conversation |
| `/batch <instruction>` | Parallelize large changes across worktrees (skill) |
| `/simplify [focus]` | Review and improve recent code (skill) |
| `/debug [description]` | Debug logging and troubleshooting (skill) |
| `/loop [interval] [prompt]` | Run prompt repeatedly (skill) |

### Key Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Shift+Tab` | Cycle permission modes (default, accept edits, plan) |
| `Esc` | Stop Claude mid-action |
| `Esc + Esc` | Open rewind menu |
| `Ctrl+G` | Open in text editor (edit plan, compose long prompts) |
| `Ctrl+L` | Clear prompt input |
| `Ctrl+O` | Toggle transcript viewer (see detailed tool usage) |
| `Ctrl+T` | Toggle task list |
| `Ctrl+R` | Reverse search command history |
| `@` | File path autocomplete |
| `!` at start | Bash mode (run commands directly) |
| `/` at start | Show commands and skills |

Source: [code.claude.com/docs/en/commands](https://code.claude.com/docs/en/commands), [code.claude.com/docs/en/interactive-mode](https://code.claude.com/docs/en/interactive-mode)

---

## 9. Anthropic Best Practices (Official)

These are the top patterns from Anthropic's official best-practices documentation. They should be prominently featured in the session.

### 1. Give Claude a Way to Verify Its Work

> This is the single highest-leverage thing you can do.

Claude performs dramatically better when it can verify its own work: run tests, compare screenshots, validate outputs. Without verification criteria, you become the only feedback loop.

- Include test cases, expected outputs, or screenshots
- "Write a validateEmail function. Test cases: user@example.com is true, invalid is false. Run the tests after implementing."
- Use the Chrome extension for UI verification

### 2. Explore First, Then Plan, Then Code

Separate research and planning from implementation to avoid solving the wrong problem. Use Plan Mode for the explore/plan phase, then switch to normal mode for implementation.

Four phases: Explore, Plan, Implement, Commit.

### 3. Manage Context Aggressively

Context is the most important resource to manage. LLM performance degrades as context fills.

- `/clear` between unrelated tasks
- Use subagents for investigation (separate context windows)
- After two failed corrections, `/clear` and write a better prompt
- `/compact` with focus instructions when auto-compaction triggers

### 4. Provide Specific Context in Prompts

| Instead of | Write |
|------------|-------|
| "add tests for foo.py" | "write a test for foo.py covering the edge case where the user is logged out. avoid mocks." |
| "fix the login bug" | "users report login fails after session timeout. check src/auth/, especially token refresh. write a failing test that reproduces the issue, then fix it" |
| "add a calendar widget" | "look at how existing widgets are implemented. HotDogWidget.php is a good example. Follow the pattern for a new calendar widget." |

### 5. Write an Effective CLAUDE.md

- Run `/init` to generate a starting point
- Keep under 200 lines
- Include only things Claude can't figure out by reading code
- Prune regularly; if Claude follows a rule without the instruction, remove it

### 6. Common Failure Patterns to Avoid

- **Kitchen sink session:** Mixing unrelated tasks in one session. Fix: `/clear` between tasks.
- **Correcting over and over:** Context polluted with failed approaches. Fix: After two corrections, `/clear` and rewrite prompt.
- **Over-specified CLAUDE.md:** Too long, Claude ignores half. Fix: Ruthlessly prune.
- **Trust-then-verify gap:** Plausible code that doesn't handle edge cases. Fix: Always provide verification.
- **Infinite exploration:** Unscoped "investigate" prompts. Fix: Use subagents or scope narrowly.

Source: [code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices)

---

## 10. Our Recommended Workflow: research-skills Plugin

**Important distinction:** Everything above is from official Anthropic documentation. This section covers our opinionated additions built on top of the official features, via the [research-skills](https://github.com/neuromechanist/research-skills) plugin.

### The `.context/` Directory Pattern

Not a Claude Code feature; this is our recommended structure for tracking project state across sessions. The research-skills `project` plugin's `/init-project` command scaffolds this automatically.

| File | Purpose | When to update |
|------|---------|----------------|
| `plan.md` | Task tracking with phases and status | Start of each work session |
| `ideas.md` | High-level concepts, design decisions | When making design decisions |
| `research.md` | Technical explorations, solutions found | After investigating a technical question |
| `scratch_history.md` | Failed attempts, lessons learned | Immediately after a failed attempt |

### The `.rules/` Directory Pattern

Our recommended way to modularize development standards. The `project` plugin provides templates:

| Rule file | Always include? | Purpose |
|-----------|----------------|---------|
| `testing.md` | Yes | NO MOCK policy, real test structure |
| `git.md` | Yes | Atomic commits, branch strategy |
| `code_review.md` | Yes | PR review process with toolkit agents |
| `python.md` | If Python | UV, ruff, ty |
| `documentation.md` | If docs | MkDocs setup, writing standards |
| `ci_cd.md` | If CI/CD | GitHub Actions templates |
| `self_improve.md` | Long-running projects | Rule evolution from experience |

### CLAUDE.md Template

The research-skills project plugin provides a CLAUDE.md template with:
- Project context section (purpose, tech stack, architecture)
- Architecture map
- Environment setup commands
- Development workflow (10-step checklist)
- Core principles (no mocks, atomic commits, no tech debt)
- `[NEVER DO THIS]` section
- References to `.rules/` and `.context/` files

### research-skills Plugin Domains

Each week of the course maps to a plugin domain:

| Week | Plugin Domain | Key Skills |
|------|--------------|------------|
| 2 | `project` | `/init-project`, `/epic-dev`, `/setup-ci` |
| 5 | `opencite` | `/opencite`, `/literature-review` |
| 6 | `grant` | `/grant-write`, `/grant-review` |
| 7 | `manuscript` | `/paper-review`, `/manuscript-prep` |
| 8 | `scientific-figures` | `/scientific-figures` |
| 9 | `neuroinformatics` | `/convert-bids`, `/validate-bids`, `/design-experiment` |
| 10 | Plugin development | Building your own |

### What We Found Most Useful

1. **CLAUDE.md + `.context/` + `.rules/`** as a trinity: instructions, state tracking, and standards
2. **`/init-project`** to scaffold everything at once
3. **Plan mode before any multi-file change**
4. **`/review-pr` with parallel subagents** to catch issues before merge
5. **No mocks policy** enforced via CLAUDE.md and `.rules/testing.md`

---

## 11. Pricing and Discounts

### Individual Plans

| Plan | Price | Claude Code? |
|------|-------|-------------|
| **Free** | $0/month | No |
| **Pro** | $20/month ($17/month annual) | Yes |
| **Max** | From $100/month (5x or 20x usage) | Yes |

### Team Plans (5-150 people)

| Seat Type | Annual | Monthly |
|-----------|--------|---------|
| **Standard** | $20/seat/month | $25/seat/month |
| **Premium** | $100/seat/month | $125/seat/month |

Mix and match seats. Includes Claude Code, Cowork, SSO, admin controls.

### Enterprise

- $20/seat base + usage-based scaling
- Spend limits, SCIM, audit logs, compliance API, HIPAA-ready option

### API Pricing (Pay-per-token)

| Model | Input (per 1M tokens) | Output (per 1M tokens) |
|-------|-----------------------|------------------------|
| Opus 4.6 | $5 | $25 |
| Sonnet 4.6 | $3 | $15 |
| Haiku 4.5 | $1 | $5 |

Anthropic publishes average enterprise cost guidance in [code.claude.com/docs/en/costs](https://code.claude.com/docs/en/costs): around $13/developer/active day and $150-250/developer/month, with 90% of users under $30/active day.

### Nonprofit Discount

**Yes, Anthropic offers nonprofit pricing.**

- **Team plan for nonprofits:** $8/user/month for organizations with fewer than 20 people (vs $20-25 standard)
- **Premium seats (nonprofit):** not published on the public page; contact sales
- **Eligibility:** 501(c)(3) organizations, international equivalents, K-12 schools, mission-based healthcare providers
- **Verification:** Through Goodstack partner (~2-3 minutes)
- **Enterprise:** Custom pricing; contact nonprofit sales team (for larger organizations above the 20-person cap)

Source: [claude.com/solutions/nonprofits](https://claude.com/solutions/nonprofits)

### Education/University Plans

**Yes, Anthropic offers education plans.**

- "Comprehensive university-wide plan" for students, faculty, and staff
- Specific pricing not publicly listed; requires contacting the Education team
- Includes: learning mode (guided discovery), Claude Code for programming education, Claude API for research, integration with Canvas/Wiley/Panopto
- Fall 2026 student programs with application process
- Partnerships with University of San Francisco, LSE, Northeastern, Dartmouth, and others

Source: [claude.com/solutions/education](https://claude.com/solutions/education)

### Recommendation for PIs/Departments

- **For individual researchers:** Pro plan ($20/month, or $17/month billed annually) is sufficient
- **For labs under 20 people** at 501(c)(3) universities: apply as the nonprofit purchasing entity for the Team plan at **$8/seat/month** (vs $20-25 standard) via Goodstack verification. Most US universities are 501(c)(3)s; the lab typically registers as the unit, not the whole university.
- **For departments or groups over 20 people:** route to Enterprise; contact the nonprofit sales team for pricing
- **For university-wide adoption:** Contact Anthropic Education team for institutional plan with student/faculty/staff access, Canvas/LMS integration, and learning mode features
- **For API-heavy research:** Console account with pay-per-token; use workspace spend limits

---

## 12. Open Questions and Design Decisions

### For Session Planning

1. **Week 1 recap duration:** 3 minutes (original) vs 8-10 minutes? How to handle 10x audience growth?
2. **Live demo scope:** Install + CLAUDE.md creation + first task is ambitious for 38 minutes of content. Consider cutting UV/Bun setup to Week 3 or making it async.
3. **Conductor mention:** How deep to go? Mention as an option vs demo?
4. **Cowork:** Mention briefly as context (what else Claude offers) or skip to avoid confusion?

### Content Not Covered Here (Saved for Later Weeks)

- **Week 3:** Epic/sprint workflow, git worktrees, project management
- **Week 4:** CI/CD, pre-commit hooks, code quality
- **Week 5+:** Domain-specific skills (opencite, grant, manuscript, etc.)

### References

- Official docs: [code.claude.com/docs](https://code.claude.com/docs/en/overview)
- Best practices: [code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices)
- Memory/CLAUDE.md: [code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory)
- Skills: [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)
- Plugins: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins)
- MCP: [code.claude.com/docs/en/mcp](https://code.claude.com/docs/en/mcp)
- Hooks: [code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks)
- Subagents: [code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents)
- Commands: [code.claude.com/docs/en/commands](https://code.claude.com/docs/en/commands)
- Nonprofit pricing: [claude.com/solutions/nonprofits](https://claude.com/solutions/nonprofits)
- Education pricing: [claude.com/solutions/education](https://claude.com/solutions/education)
- Conductor (third-party): [docs.conductor.build](https://docs.conductor.build/)
- research-skills plugin: [github.com/neuromechanist/research-skills](https://github.com/neuromechanist/research-skills)
