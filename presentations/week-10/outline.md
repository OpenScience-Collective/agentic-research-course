# Week 10 Outline -- Build Your Own: Skills, Agents, and the Researcher's Plugin

## Target
23 slides, ~30 min presentation + ~5 min live demo + ~15 min Q&A. The capstone session.

## Core message
For nine weeks you used tools other people built. Every week, without naming it, you ran one of six things: a **skill** (the lit-review, grant, manuscript, figure, and BIDS workflows), an **agent** (`bids-validator`, `figure-qa`), a **command** (`/epic-dev`, `/init-project`), a **hook** (Week 4's pre-commit and CI checks), an **MCP server** (`matlab-mcp`, which drove MATLAB and EEGLAB through the whole practicum), all shipped inside a **plugin** (`research-skills`). This week names the six, gives you two questions to pick the right one for any job, and walks you through building the simplest, a skill, with `/skill-development`. The single most useful idea: **a skill is an onboarding guide written for the next Claude, not documentation for a human**, and its trigger description is what decides whether it ever loads. The arc closes the course loop: the HBN shot-change analysis you have grown since Week 3 becomes a reusable skill anyone can install. You arrived a tool user; you leave a tool builder.

## Narrative arc
1. **The reveal** -- you have used all six building blocks already; today you name them.
2. **The taxonomy** -- two questions (who triggers it, where it runs) sort skill / agent / command / hook / MCP; the plugin is the box that ships them. Clear the two confusions that actually bite: skill vs agent, skill vs MCP.
3. **Skills up close** -- what a skill really is, its anatomy, progressive disclosure, and the trigger description that makes or breaks it.
4. **Build one** -- `/skill-development` as a six-step process; test that it triggers; review with `skill-reviewer`; iterate; and when a skill is not enough, level up to an agent, command, hook, or MCP.
5. **Make it your own** -- fork `research-skills`, add your skill, install it back, get cross-agent support for free, and version it.
6. **Considerations and close** -- what to weigh before building (and when not to), then graduation: used all six, built one, loop closed.

## Practicum thread
The live build is a small skill that encodes the shot-change event-related potential (ERP) workflow the course has run on Healthy Brain Network (HBN) EEG data since Week 3 ("The Present" movie). The skill does not re-derive the analysis; it captures the procedure (find shot events, epoch around them, average, plot) as the onboarding guide a new lab member would need. The loop closes literally: the thing you analyzed becomes the thing you publish.

## Continuity
- **Week 2 (Claude Code + CLAUDE.md):** that `CLAUDE.md` was your first piece of agent authoring; a skill is the next step up.
- **Week 3 (`/epic-dev`, `/plan`):** those were commands. Today, commands get a name and a place on the decision table.
- **Week 4 (CI, pre-commit):** those were hooks, event-driven and deterministic. Named today.
- **Weeks 5-9 (opencite, grant, manuscript, figures, BIDS):** every one was a skill; `figure-qa` and `bids-validator` were agents. The worked examples are tools you already trust.
- **Whole practicum (`matlab-mcp`):** the MCP server you drove all course is the worked example for "a wire to an external system."
- **Week 9 close ("next week you build your own plugin"):** this is that week.

## The decision framework (the conceptual centerpiece)
Two questions sort all six:
1. **Who triggers it?** Claude (auto, from intent) -> skill or agent. You (explicitly) -> command. An event -> hook. An always-on connection -> MCP server.
2. **Where does it run?** The main conversation -> skill. Its own context window -> agent. Outside the model entirely -> MCP server / hook.

| You want... | Reach for a... |
|---|---|
| Claude to follow your procedure when the topic comes up | **Skill** |
| A scoped job done in isolation (often in parallel), returning a result | **Agent** |
| A deliberate `/entry-point` for a multi-step workflow | **Command** |
| Something to happen automatically on an event (save, commit, tool use) | **Hook** |
| Claude to reach an external system (MATLAB, a database, an API, a browser) | **MCP server** |
| To bundle and share any of the above | **Plugin** (via a marketplace) |

One-line model: **Skill = knowledge. Agent = a worker. Command = a button. Hook = a tripwire. MCP = a wire to the outside. Plugin = the box.**

## Live demo (kept deliberately small and safe)
A single thing, done well: run `/skill-development`, build a tiny `shot-change-erp` skill (frontmatter with a strong trigger description, a lean `SKILL.md` body), then prove it triggers by typing the natural-language phrase and watching the skill load. Optionally run the `skill-reviewer` agent on it. No live repo fork and no install-back on stage; that material is taught with the commands on slides and in the blog, so a network or auth hiccup cannot derail the finale.

## Out of scope (deliberate)
- Hooks, MCP servers, commands, and agents are *named and placed* on the decision table, but only *skills* are built live; the `plugin-dev` skills (`agent-development`, `command-development`, `hook-development`, `mcp-integration`, `plugin-structure`, `plugin-settings`) are signposted as the next steps, not taught in depth.
- No live `git` fork or `claude plugin install` on stage (demo-risk); shown as commands instead.
- Marketplace publishing mechanics beyond the bump rules (registries, CI release) are left to the blog and the repo docs.

## Why this is the right capstone
It is the only session where the audience builds a tool instead of using one, and it reframes all nine prior weeks as a tour of the six building blocks they can now author themselves. The decision table is the durable takeaway (researchers stay confused about skill vs agent vs MCP long after a course ends); the live build proves it is approachable; the fork-and-own path tells them exactly how to make it real for their own lab.
