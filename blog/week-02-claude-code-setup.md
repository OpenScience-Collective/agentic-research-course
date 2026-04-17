# Week 2 Setup Guide: Setting Up Claude Code for Research

*A step-by-step walkthrough for installing Claude Code, writing your first `CLAUDE.md`, and wiring up the project patterns that turn a generic AI into a domain-aware research assistant.*

This guide accompanies [Week 2](../sessions/week-02/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). By the end, you will have Claude Code installed and authenticated, a working `CLAUDE.md` for one of your real projects, a `.context/` directory tracking live project state, and enough prompting practice to complete a real research task end to end.

You do not need to finish the entire guide in one sitting. The install and first run can take 10 minutes. Writing a good `CLAUDE.md`, by contrast, is something you will come back to every few sessions for the rest of the course.

---

## Why Setup Matters Before You Run

Week 1 installed the safety net (git, GitHub, the command line). This week installs the tool that makes the safety net necessary.

Claude Code is an autonomous agent. It reads your entire project, writes code across multiple files, runs commands, creates commits and pull requests (PRs), and iterates on its own output until tests pass. The same agent can either accelerate your research by an order of magnitude or silently write code that looks plausible and is wrong in ways you will only discover three weeks later.

The difference between those two outcomes is setup. Concretely:

- A blank project with no `CLAUDE.md` gets a generic AI that guesses about your conventions, reinvents things that already exist, and produces output you need to manually review line by line.
- A project with a thoughtful `CLAUDE.md`, a `.context/` directory, and a prompting habit gets a collaborator that follows your rules, reuses your patterns, proposes plans before editing, and verifies its own work.

Setup is a one-time investment of 20 to 30 minutes per project. It pays back every single session after that. This guide is long because it covers that investment in depth, not because any one step is hard.

---

## 1. Understand What Claude Code Is

Claude Code is not autocomplete, and it is not a chat sidebar. It is an agent that:

- Reads your entire project and understands the structure
- Writes and edits code across multiple files in one pass
- Runs terminal commands (build, test, lint, deploy) and reads the output
- Creates git branches, commits, and pull requests
- Plans multi-step implementations before writing any code
- Iterates on its own work until tests pass or you stop it

You describe the outcome you want. Claude Code figures out how to build it, runs the result, and corrects itself when it fails.

### Claude Code vs Claude Chat vs Claude Cowork

Anthropic currently offers three agentic products. They overlap in branding but solve different problems.

- **Claude Chat** is the conversational AI at [claude.ai](https://claude.ai). You paste in text or files, ask questions, and get answers. No access to your filesystem or terminal.
- **Claude Code** is what this course is about: an agent for developers and researchers that runs on your machine, reads your repository, and modifies files. It is available as a command-line interface (CLI), a VS Code extension, a desktop app, and a web interface.
- **Claude Cowork** (generally available in April 2026) is aimed at non-coding knowledge workers. It builds spreadsheets, slide decks, and documents on your behalf. If someone in your lab asks Claude to build a grant budget in Excel, that is Cowork, not Code.

All three are available on Claude Pro and above. For this course, we use Claude Code.

---

## 2. Install Claude Code

### macOS

Native install (recommended, auto-updates):

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Or via [Homebrew](https://brew.sh):

```bash
brew install claude-code
```

### Linux

If `curl` is missing (common on minimal Ubuntu and some WSL images), install it first:

```bash
sudo apt install curl
```

Then run the installer:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Windows

In PowerShell:

```powershell
irm https://claude.ai/install.ps1 | iex
```

Native Windows installs require [Git for Windows](https://git-scm.com/downloads/win). If you are using Windows Subsystem for Linux (WSL, set up in Week 1), install inside your Ubuntu terminal using the Linux instructions above.

### Verify the install

```bash
claude --version
```

You should see a version string. If the command is not found, open a new terminal (the installer updates your shell profile but not the current session).

---

## 3. First Run and Authentication

Navigate to any project folder (use the `my-research-project` you created in Week 1 if you do not have another one handy):

```bash
cd my-research-project
claude
```

On first run, a browser window opens for login. You can authenticate two ways:

- **Claude subscription** (Pro, Max, Team, or Enterprise). This uses your existing monthly quota.
- **Anthropic Console account**, which gives pay-per-token access if you already have application programming interface (API) credits.

Check your auth state at any time from your shell (not inside a running `claude` session; type `/exit` to drop back to the shell first if needed):

```bash
claude auth status
```

### Which plan for this course?

Claude Pro at $20 per month (or $17 per month with annual billing) is sufficient for everything we do in these 10 sessions. If you run out of quota in the middle of a live demo, upgrading to Max gets you 5x or 20x the usage.

If your lab is at a 501(c)(3) nonprofit (or international equivalent), you can get the Team plan at $8 per seat per month. Organizations purchasing fewer than 20 seats verify through Goodstack; larger purchases go through Anthropic sales directly. See [Anthropic's nonprofits page](https://claude.com/solutions/nonprofits) for details. This is meaningful savings for research groups.

---

## 4. The Permission Model

Claude Code asks before doing anything destructive. You control the guardrails through four permission modes. Understanding these early prevents a lot of friction later.

| Mode | Behavior | When to use |
|------|----------|-------------|
| **Default** | Asks before every file edit and shell command | Starting out; unfamiliar tasks |
| **Accept Edits** | Auto-approves file edits plus common filesystem commands (`mkdir`, `touch`, `mv`, `cp`, `rm`, `rmdir`, `sed`) | Trusted coding sessions where you are watching the output |
| **Plan** | Read-only; Claude can read files and run exploratory commands, but cannot modify anything | Complex multi-file changes where you want a proposal first |
| **Auto** | A safety classifier evaluates each action automatically; available on Max, Team, Enterprise, or API (not Pro) | Long-running agentic tasks where you trust the classifier; start in it with `--permission-mode auto` |

Press `Shift+Tab` to cycle Default, Accept Edits, and Plan (and Auto, on plans that include it). Two presses from Default lands on Plan. You can also jump straight to Plan Mode with `/plan`.

### Persist permissions across sessions

The `/permissions` command opens a persistent allow/deny list. Use it to pre-approve tools you always want (for example, running `pytest` or `ls`) so Claude does not interrupt you for them.

```text
/permissions
```

See [the permissions doc](https://code.claude.com/docs/en/permissions) for advanced patterns like path-scoped rules and environment variable exceptions.

### A practical rule of thumb

Start every new project in Default mode. Switch to Accept Edits once you have a sense of what Claude is doing in this codebase. Drop back to Default for anything involving migrations, destructive commands, or unfamiliar directories.

---

## 5. Write Your First `CLAUDE.md`

`CLAUDE.md` is a plain markdown file at your project root. Claude Code reads it at the start of every session. This is the single most important file in your project for AI-assisted development. A good `CLAUDE.md` is the difference between an AI that guesses and an AI that knows your project.

### Let Claude bootstrap it

The fastest way to start is to have Claude Code analyze your codebase and generate a first draft for you:

```bash
cd your-project
claude
```

Then at the prompt:

```text
/init
```

Claude reads your files, identifies the tech stack, finds build and test commands, and generates a starter `CLAUDE.md`. Refine it manually from there. This is almost always better than starting from a blank file because Claude will surface things you forgot to write down.

### What goes in, what stays out

Treat `CLAUDE.md` like a README for an AI colleague. Include what is non-obvious. Leave out what it can figure out on its own.

**Include:**

- Build, test, and lint commands Claude cannot guess from your files
- Code style rules that differ from language defaults (indent width, quote style, import order)
- Repository etiquette (branch naming, commit style, PR conventions)
- Architecture decisions that are load-bearing but not visible in any single file
- Common gotchas or non-obvious behaviors (flaky tests, machines where a step fails, environment variables that must be set)
- A "never do this" section for hard rules

**Exclude:**

- Anything Claude can figure out by reading your code
- Standard language conventions the model already knows (for example, "write docstrings for Python functions")
- Long tutorials or API documentation (link to them instead)
- Information that changes frequently (current sprint tasks, temporary flags)
- Self-evident practices ("write clean code", "be consistent")

### Before and after: the same project, two `CLAUDE.md` files

A bloated `CLAUDE.md` is the single most common mistake. Long files cause Claude to ignore rules because important instructions get buried. Here is the same imaginary Healthy Brain Network (HBN) EEG preprocessing project, one done wrong and one done right.

**Bloated version (500+ lines, Claude mostly ignores it):**

```markdown
# Project

This is a Python project. Python uses indentation for block structure.
Please write Python code that is well-formatted and follows PEP 8.
Use docstrings for all functions. Use type hints.
Use meaningful variable names. Do not use single-letter variables
except for loop counters.

When writing EEG code, please make sure you filter the data correctly.
A bandpass filter should be applied before any other operation.
Here is a list of every file in the repository:
- src/preprocessing/step1_load.py: loads data
- src/preprocessing/step2_filter.py: filters
- ... (200 more lines listing files)

Please use tests. Tests should be thorough. Tests should cover edge cases.
When writing tests, please use pytest. When running tests, please use pytest.
...
```

This tells Claude nothing it does not already know. The actual project rules are buried under generic advice and an auto-generated file listing that goes stale the moment someone adds a file.

**Lean version (80 lines, Claude actually follows it):**

```markdown
# HBN EEG Preprocessing

## Project
Bandpass-filtered event-related potential (ERP) analysis of Healthy Brain
Network (HBN) EEG data around movie shot-change events. MATLAB via
matlab-mcp; EEGLAB for preprocessing.

## Stack
- Python 3.12 with UV (never pip or conda)
- MATLAB R2024a with EEGLAB 2024.0
- Data: `./data/bids/` (BIDS format, do not edit)

## Workflow
- Branch per issue: `feature/issue-N-description`
- Commits: atomic, under 50 chars, no emojis, no AI attribution
- PR before merge; run `/review-pr` first

## Code style
- Python: ruff format, ruff check --fix, ty for types
- MATLAB: snake_case for variables, PascalCase for classes
- No mocks in tests; real fixtures only

## Gotchas
- `pop_loadset` fails silently on files over 2 GB; chunk first
- The preprocessing pipeline expects sfreq = 500; resample on load
- matlab-mcp session cap is 3; close old sessions with `matlab_close`

## Context files
- `.context/plan.md` -- current tasks and next steps
- `.context/scratch_history.md` -- failed attempts, so we do not repeat them

## Never
- Never use pip, conda, or virtualenv (UV only)
- Never commit raw data files (gitignored; check before every push)
- Never mock EEGLAB calls in tests
```

Everything here is non-obvious, load-bearing, and specific to this project. Claude picks up every rule because there is no noise to drown them out.

### Keep it under 200 lines

If your `CLAUDE.md` is creeping past 200 lines, delete things. If you see Claude already doing something correctly without the rule, delete the rule. Prune regularly; treat it like code. Long `CLAUDE.md` files are how teams end up with an AI that ignores instructions.

### Scope hierarchy

`CLAUDE.md` lives at multiple levels. All levels concatenate into Claude's context. Within a directory, the local file appends after the project file, so your personal notes take precedence at that level.

| Scope | Location | Shared with |
|-------|----------|-------------|
| Organization | System-level, IT-deployed | All users on the machine |
| Project | `./CLAUDE.md` (in repo) | Team, via git |
| User | `~/.claude/CLAUDE.md` | Just you, across all projects |
| Local | `./CLAUDE.local.md` (gitignored) | Just you, this project only |

Most research projects use Project scope (shared with the team) and User scope (your personal coding preferences). Add `CLAUDE.local.md` to `.gitignore` if you use it, so private notes do not leak into commits.

---

## 6. Structure Evolving State with `.context/`

`CLAUDE.md` holds static rules. Research projects also have state that changes every few days: what you are working on right now, what you already tried, what decisions led here. Stuffing that into `CLAUDE.md` bloats it within a month.

The `.context/` directory is an opinionated pattern we use across our research codebases for tracking this evolving state separately from the static rules.

```
your-project/
├── CLAUDE.md
└── .context/
    ├── plan.md              # Current tasks, phases, status
    ├── ideas.md             # Design decisions, architecture notes
    ├── research.md          # Technical findings, solutions considered
    └── scratch_history.md   # Failed attempts, lessons learned
```

Claude reads these files alongside `CLAUDE.md`. Your `plan.md` becomes its task list. Your `scratch_history.md` prevents it from repeating your mistakes. This is not an official Claude Code feature, just a pattern; we have found it the most useful convention in EEG, neuroimaging, and grant-writing projects.

### Starter contents

Here is what each file looks like when you first create it. Fill them in as you work. Claude will update them too, if you ask.

**`.context/plan.md`**

```markdown
# Current Work

## In progress
- [ ] Set up BIDS loader for HBN subset
- [ ] Verify sampling rate matches across subjects

## Up next
- Build ERP pipeline for movie shot-change events
- Add unit tests for filter step

## Done
- [x] Project scaffold
- [x] CLAUDE.md first pass
```

**`.context/ideas.md`**

```markdown
# Design Decisions

## Why EEGLAB over MNE-Python
We already have the preprocessing scripts in MATLAB and the lab is
MATLAB-literate. Rewriting in MNE-Python would take a month; wrapping
EEGLAB through matlab-mcp takes a day.

## Why 1-40 Hz bandpass
Matches the filter used in the canonical HBN preprocessing paper
(Alexander et al., 2017) for comparability.
```

**`.context/research.md`**

```markdown
# Technical Investigations

## matlab-mcp session limits
Tested on macOS: 3 concurrent MATLAB sessions before the MCP server
slows noticeably. Close sessions with `matlab_close` between phases.
```

**`.context/scratch_history.md`**

```markdown
# Failed Attempts and Lessons

## 2026-04-12: Tried loading all subjects in one pass
Ran out of memory at subject 14. `pop_loadset` does not stream.
Fix: process one subject at a time, save intermediate .set files.
Lesson: HBN is big. Always chunk.
```

### Optional: scaffold with a plugin

If you want this directory set up automatically, install the `project` plugin from the course companion marketplace. Inside a running `claude` session, add the marketplace first, then install and run the plugin:

```text
/plugin marketplace add neuromechanist/research-skills
/plugin install project@research-skills
/init-project
```

The plugin creates the directory, seeds each file with a sensible template, and adds a `CLAUDE.md` section pointing Claude at the files.

---

## 7. Prompting for Research

How you talk to Claude Code matters more than which model you use. This section is short on theory and long on examples because prompting is a skill you build by imitation.

### Be specific, not polite

The worst prompts are vague. The best prompts read like a lab protocol.

**Vague (Claude will guess):**

```text
fix the preprocessing
```

**Specific (Claude knows exactly what you want):**

```text
In src/preprocessing/step2_filter.py, change the bandpass from 0.5-45 Hz
to 1-40 Hz to match the Alexander et al. 2017 pipeline. Update the
docstring to cite the source. Run tests/test_filter.py and fix any
failures.
```

The second prompt is longer, but it eliminates the three or four clarifying questions Claude would otherwise ask, and it tells Claude how to check its own work.

### Give domain context once, reuse it

Claude does not start every session knowing that you work on EEG data from a movie-watching paradigm. Put the durable context in `CLAUDE.md`. For session-specific context, give it upfront in the first prompt:

```text
Working on the HBN movie shot-change analysis. The input is a BIDS-format
EEG dataset at ./data/bids/. Events are tagged with HED descriptors for
shot changes. My goal for this session is to build an ERP extraction
function that averages across trials per subject and saves results as
BIDS-compliant derivatives.

First task: read one subject's .set file and print its event structure.
Do not write the ERP code yet.
```

The domain preamble costs you 30 seconds of typing. It saves Claude from asking what BIDS is, what HED is, and what shot-change means in this context.

### Iterate, do not restart

Your first prompt will rarely produce the final answer. That is fine. Refine the output instead of starting from scratch.

```text
That's close. Two changes:
1. Change the filter to 0.5-45 Hz instead; I was wrong about the cutoff.
2. Add a figure showing the power spectrum before and after filtering,
   saved to figures/qc/filter_response.png.
```

Do not say "no, that is wrong, start over." That wastes Claude's context on re-reading files it already knows. Tell it what to change.

### Voice dictation is fine

If you dictate prompts (in the car, walking between meetings, recovering from a repetitive strain injury (RSI)), Claude handles the artifacts well. Typos, "um", "uh", incomplete sentences all come through legibly. Do not edit dictation before pasting; it costs you more time than the extra tokens save.

### When to stop prompting and start reading

After two failed corrections on the same point, stop. The model is not going to get it on attempt three. Instead:

1. Press `Esc` to stop Claude mid-action
2. Run `/clear` to reset the context (wipes the current conversation without ending the session)
3. Re-read the file yourself
4. Write a new prompt from scratch that includes what you just learned

Two bad corrections burn more context than a clean restart. See the "Manage context aggressively" best practice below.

---

## 8. Plan Mode: Explore, Plan, Implement

The single highest-impact feature for research workflows is Plan Mode. From Default, press `Shift+Tab` twice to reach it (once from Accept Edits), or type `/plan` to jump straight in.

The four-phase flow is:

1. **Explore** (Plan Mode): Claude reads files, asks questions, builds understanding. It cannot edit anything.
2. **Plan** (Plan Mode): Claude proposes an implementation plan. Press `Ctrl+G` to open the plan in your text editor and revise it before approving. If `$EDITOR` is not set, Claude falls back to `vi`; to avoid that, run `export EDITOR=nano` (or `export EDITOR="code --wait"` for VS Code) before starting.
3. **Implement** (Normal Mode): `Shift+Tab` back to Default or Accept Edits. Claude follows the approved plan.
4. **Commit** (Normal Mode): Claude writes the commit message and opens a PR if you ask.

### When to use Plan Mode

- The change spans multiple files
- You are unfamiliar with the code being modified
- You are not certain the approach you have in mind is the right one
- The task involves anything destructive (data migrations, schema changes, mass renames)

### When to skip it

Plan Mode overhead does not pay off for small, obvious edits:

- Fixing a typo
- Adding a log line
- Renaming a variable with find-and-replace
- Formatting or linting fixes

Time saved by skipping planning on a 30-second task is about 30 seconds. Time saved by using it on a three-file refactor is hours.

---

## 9. The Extension Ecosystem

Claude Code has five extension mechanisms. You will use all of them over this course. Knowing when to reach for each saves a lot of time.

| Concept | What it is | When to use |
|---------|-----------|-------------|
| **Plugin** | Distributable package bundling everything below | Share a tool or workflow with your team or the community |
| **Skill** | Workflow or knowledge file that loads on demand | Repeatable procedures, checklists, domain recipes |
| **Model Context Protocol (MCP) server** | Connector to external data or tools | Google Drive, Jira, databases, MATLAB, HED annotation |
| **Hook** | Automated shell command at a Claude lifecycle point | Enforce something with zero exceptions (pre-commit, post-edit) |
| **Subagent** | Isolated worker with its own context window | Side investigations that would pollute your main context |

Three distinctions that cleared things up for me when I was learning this:

- **Hooks say "this will happen."** They are deterministic shell commands Claude cannot skip.
- **`CLAUDE.md` says "please do this."** It is advisory. Claude usually follows it, but it is not enforced.
- **Subagents say "do this in your own space."** They keep your main conversation clean when you need to explore a side question.

For our research practicum, we use [`matlab-mcp-tools`](https://github.com/neuromechanist/matlab-mcp-tools) as the MCP server so Claude Code can drive EEGLAB (installed in Week 9). We also use [Serena](https://github.com/oraios/serena) for semantic code exploration in large codebases, and language server protocol (LSP) servers for real-time intelligence in typed languages (covered in Week 4). For neuroimaging annotation, `hed-mcp` handles Hierarchical Event Descriptor (HED) tagging (Week 9).

Claude Code also ships with a handful of built-in skills (`/simplify`, `/loop`, `/claude-api`, and others listed in the Quick Reference). These are always available without installing anything.

You do not need the third-party tools now. They are listed so the names are familiar when they come up.

---

## 10. Apply the Three Core Best Practices

These come directly from [Anthropic's official best practices](https://code.claude.com/docs/en/best-practices). They are the highest-leverage habits for agentic work.

### 1. Give Claude a way to verify its work

Include tests, expected outputs, or screenshots in your prompts. This is the single highest-leverage thing you can do. Without verification, every mistake requires your attention. With verification, Claude catches its own mistakes before you see them.

**Instead of:**

```text
add tests for foo.py
```

**Write:**

```text
Write tests for foo.py covering the edge case where the user is logged
out. Avoid mocks; use real fixtures. Run the tests and fix any failures
before declaring done.
```

The second prompt gives Claude a termination condition: "tests pass."

### 2. Explore first, then plan, then code

Use Plan Mode to separate research from execution. This prevents solving the wrong problem when the scope is non-trivial. Most of the time Claude gets stuck is because it started implementing before it understood.

### 3. Manage context aggressively

Claude's context window fills up fast, and performance degrades as it fills.

- `/clear` between unrelated tasks
- Use subagents for investigation so exploration does not consume your main context
- After two failed corrections, `/clear` and rewrite your prompt with what you learned
- `/compact [focus]` if you want to keep the thread but drop details

A smaller, cleaner context beats a large, noisy one every time.

---

## 11. The Practicum: HBN EEG Analysis

Starting next week, we use a real dataset and a real analysis goal to ground every technique. You do not need to install anything yet; this section is a preview of what you are building toward.

**The dataset:** The Healthy Brain Network (HBN) EEG corpus. Thousands of children and adolescents, tens of thousands of sessions, recorded while watching short film clips. Publicly available, BIDS-formatted, well documented.

**The goal:** Extract event-related potentials (ERPs) around movie shot-change events. Shot changes are visually abrupt; the brain responds predictably. Our pipeline will detect the shot-change timestamps from the video, align them to the EEG, and average the neural response across trials and subjects.

**The tools:**

- EEGLAB (MATLAB toolbox for EEG preprocessing)
- matlab-mcp-tools (MCP server that lets Claude Code drive MATLAB and EEGLAB)
- Python with UV for scripting glue and analysis
- HED annotations for event tagging

**The weekly thread:**

- Week 3: project management (epics, sprints, worktrees) using the HBN project as the live example
- Week 4: CI and code quality around the analysis scripts
- Week 5 through 8: literature review, grant scaffolding, manuscript prep, figures, all tied to this project
- Week 9: BIDS validation, PsychoPy for the stimulus replay, Lab Streaming Layer (LSL) for timestamps

If you want to peek ahead, the datasets are at [fcon_1000.projects.nitrc.org/indi/cmi_healthy_brain_network](https://fcon_1000.projects.nitrc.org/indi/cmi_healthy_brain_network/). Do not download yet; we will walk through the subset we use in Week 9.

---

## 12. Before Next Session

- Install Claude Code so `claude --version` works
- Run `/init` in a real project to generate a starter `CLAUDE.md`
- Refine that `CLAUDE.md` manually: add the gotchas, prune what the AI already knows, keep it under 200 lines
- Create the `.context/` directory with four starter files (`plan.md`, `ideas.md`, `research.md`, `scratch_history.md`)
- Give Claude one real task from your research. Small is fine: plot some data, write a function, summarize a file
- Practice Plan Mode on one task and compare the output to what you would have written yourself
- Optional: install the `project` plugin from [research-skills](https://github.com/neuromechanist/research-skills) to scaffold everything automatically

Next week: project management with epics, sprints, and git worktrees, all demonstrated on the HBN practicum project.

---

## Quick Reference

### Install and first run

```bash
# macOS / Linux
curl -fsSL https://claude.ai/install.sh | bash

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex

# Then in any project
cd your-project
claude
```

### Most-used commands

| Command | What it does |
|---------|-------------|
| `/init` | Generate a starter `CLAUDE.md` by analyzing the project |
| `/plan [description]` | Enter Plan Mode (equivalent to `Shift+Tab` twice from Default) |
| `/clear` | Reset context between unrelated tasks |
| `/compact [focus]` | Summarize conversation to free context |
| `/memory` | Edit `CLAUDE.md`, toggle auto-memory |
| `/model` | Switch between Opus, Sonnet, Haiku |
| `/diff` | Interactive viewer of uncommitted changes |
| `/rewind` | Undo to any previous checkpoint |
| `/cost` | Show token usage |
| `/context` | Visualize context window usage |
| `/permissions` | Persist allow/deny rules |

### Keyboard shortcuts

| Shortcut | Action |
|----------|--------|
| `Shift+Tab` | Cycle permission modes (Default, Accept Edits, Plan; plus Auto on Max/Team/Enterprise/API) |
| `Esc` | Stop Claude mid-action |
| `Esc` twice | Open rewind menu |
| `Ctrl+G` | Open current input in your text editor |
| `@` at start | File path autocomplete |
| `!` at start | Bash mode (run commands directly) |

### The five extension mechanisms

| Mechanism | File location | Invoke with |
|-----------|--------------|-------------|
| Plugin | Installed via `/plugin install name@marketplace` | `/plugin-name:command` |
| Skill | `.claude/skills/<name>/SKILL.md` | `/skill-name` or Claude auto-detects |
| MCP server | `.mcp.json` or `claude mcp add` | Claude uses when relevant |
| Hook | `.claude/settings.json` | Fires automatically at lifecycle event |
| Subagent | `.claude/agents/<name>.md` | Claude delegates based on description |

### Bundled skills (ship with Claude Code)

| Command | What it does |
|---------|-------------|
| `/simplify` | Review and improve recent code |
| `/batch` | Parallelize large changes across worktrees |
| `/debug` | Enable debug logging and troubleshoot |
| `/loop` | Run a prompt repeatedly on an interval |
| `/claude-api` | Load Claude API reference for your language |

---

## Resources

- [Claude Code documentation](https://code.claude.com/docs) (official)
- [Best practices](https://code.claude.com/docs/en/best-practices) (Anthropic)
- [Memory / CLAUDE.md](https://code.claude.com/docs/en/memory)
- [Plugins](https://code.claude.com/docs/en/plugins)
- [Skills](https://code.claude.com/docs/en/skills)
- [Model Context Protocol (MCP)](https://code.claude.com/docs/en/mcp)
- [Hooks](https://code.claude.com/docs/en/hooks)
- [Subagents](https://code.claude.com/docs/en/sub-agents)
- [Nonprofit pricing](https://claude.com/solutions/nonprofits) (for 501(c)(3) labs)
- [Course repository](https://github.com/OpenScience-Collective/agentic-research-course)
- [Open Science Collective Discord](https://discord.gg/5dWJCUmUww)
- [research-skills plugin](https://github.com/neuromechanist/research-skills) (course companion)
- [matlab-mcp-tools](https://github.com/neuromechanist/matlab-mcp-tools) (EEGLAB integration for the practicum)

---

*Part of the [Agentic Research Course](https://github.com/OpenScience-Collective/agentic-research-course) by the Open Science Collective. Licensed under CC-BY-4.0.*
