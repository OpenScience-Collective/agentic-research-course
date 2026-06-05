# Week 10: Build Your Own -- Skills, Agents, and the Researcher's Plugin

*The capstone. For nine weeks you used tools other people built. This week you learn the six kinds of tool a coding agent can run, which one to reach for, and how to build the simplest of them, a skill, with `/skill-development`. You arrived a tool user; you leave a tool builder.*

## Learning Objectives

By the end of this session, you will:
- Name the six building blocks of an agent toolkit and tell them apart: **skill, agent, command, hook, MCP server, plugin**
- Use two questions (who triggers it, where it runs) to pick the right one for a given job
- Understand what a skill really is: an onboarding guide that turns general Claude into a specialist
- Build a working skill with `/skill-development`: frontmatter, trigger description, progressive disclosure, imperative writing
- Test whether a skill triggers, review it with the `skill-reviewer` agent, and iterate
- Know how to fork `research-skills`, add your own skill, install it back, and version it
- Decide when *not* to build, and what to consider before you do

## Outline

### Part 1: The six building blocks (10 min)
- The confusion every researcher has: skill? agent? command? hook? MCP? plugin?
- Two questions that sort them all: **who triggers it** (Claude, you, an event, an always-on connection) and **where it runs** (the main chat, its own context, outside the model)
- The decision table: what you want, the tool you reach for
- The two confusions worth clearing up: **skill vs agent** (knowledge in the main chat vs a worker in its own context) and **skill vs MCP** (knowledge vs a wire to an external system, like `matlab-mcp`)
- You have already used all six this course; today we name them
- The plugin is the box, the marketplace is the shelf

### Part 2: Skills, up close (10 min)
- A skill is an onboarding guide for a domain, not documentation for humans
- Anatomy: `SKILL.md` plus optional `references/`, `scripts/`, `assets/`
- Progressive disclosure: metadata always loaded, `SKILL.md` on trigger, resources only as needed
- The trigger description is everything: third person, specific phrases, or the skill never fires
- Write for the next Claude, in imperative form

### Part 3: Building a skill with /skill-development (10 min)
- The six-step process: understand, plan resources, scaffold, write, validate, iterate
- Live build: a small practicum-flavored skill that encodes the shot-change ERP workflow you have run since Week 3
- Testing: say the trigger phrase and watch it fire; local install with `--plugin-dir`
- The `skill-reviewer` agent and the iterate loop
- When a skill is not enough: leveling up to agents, commands, hooks, or an MCP server

### Part 4: Make it your own (8 min)
- Fork `research-skills`: the marketplace you have used since Week 5 is a GitHub repo you can own
- Add your skill, bump the version, `claude plugin marketplace add ./your-fork`, install it back
- Cross-agent for free: `AGENTS.md` means your skill also works in Codex and Copilot CLI
- Versioning and sharing: semantic versioning per plugin, the marketplace bump rules, and contributing back

### Considerations and close (2 min) + Q&A (15 min)
- What to consider before you build, and when not to build at all
- Graduation: you used all six, you built one. The HBN analysis you have grown since Week 3 is now a reusable skill anyone can install.

## Key Concepts

- **Skill:** Knowledge plus a workflow that auto-triggers from its description and runs in the main conversation. An onboarding guide for a domain. (`SKILL.md` + optional `references/`, `scripts/`, `assets/`.)
- **Agent (subagent):** An autonomous worker with its own context window, restricted tool set, and model choice. Delegated a scoped job, returns a result. (Examples this course: `bids-validator`, `figure-qa`.)
- **Command:** A user-invoked `/slash-command` entry point for a workflow that needs a deliberate trigger. (Examples: `/epic-dev`, `/init-project`.)
- **Hook:** Event-driven automation (PreToolUse, PostToolUse, Stop, and others) that runs deterministically when an event fires, not when the model decides. (Week 4's pre-commit and CI checks.)
- **MCP server:** Model Context Protocol; a connection that gives Claude new tools by wiring it to an external system. (The course's own `matlab-mcp`, which lets Claude drive MATLAB and EEGLAB.)
- **Plugin:** The package that bundles skills, agents, commands, hooks, and MCP server configs and ships them through a marketplace. (`plugin.json` manifest; `research-skills` is a marketplace of seven plugins.)
- **Progressive disclosure:** The three-level loading that keeps skills cheap: metadata always in context, `SKILL.md` body on trigger, bundled resources only when needed.
- **Trigger description:** The third-person, phrase-specific `description` in a skill's frontmatter that decides whether Claude loads it at all.

## The Mental Model in One Line

- **Skill = knowledge.** **Agent = a worker.** **Command = a button.** **Hook = a tripwire.** **MCP = a wire to the outside.** **Plugin = the box that ships them.**

## Before This Session

- Install `research-skills` if you have not: in Claude Code type `/plugin`, add marketplace `neuromechanist/research-skills`, install a plugin or two.
- Skim one `SKILL.md` you already have installed (for example `neuroinformatics/skills/bids-conversion/SKILL.md`) to see the shape of the thing you will build.
- Have a tiny, real chore in mind that you redo often, the kind of thing you would explain to a new lab member in a paragraph. That paragraph is your first skill.

## After the Course

- Build a skill for the chore you redo most; keep `SKILL.md` lean and let it earn its `references/`.
- Fork `research-skills`, add your skill, and install it back, so your whole lab gets it.
- Share it: open a pull request to `research-skills`, or post it in the [Open Science Collective](https://osc.earth) Discord.
- Help the next cohort. You now know the whole pipeline: from `git init` in Week 1 to a published skill in Week 10.
