# Week 10 Guide: Build Your Own -- Skills, Agents, and the Researcher's Plugin

*The capstone. For nine weeks you used tools other people built. Every week, without naming it, you ran one of six things: a **skill** (the lit-review, grant, manuscript, figure, and Brain Imaging Data Structure workflows), an **agent** (`bids-validator`, `figure-qa`), a **command** (`/epic-dev`, `/init-project`), a **hook** (Week 4's pre-commit and continuous-integration checks), a **Model Context Protocol (MCP) server** (`matlab-mcp`, which drove MATLAB and EEGLAB through the whole practicum), all packaged in a **plugin** (`research-skills`). This week names the six, hands you two questions that pick the right one for any job, and walks you through building the simplest, a skill, with `/skill-development`. The single most useful idea: **a skill is an onboarding guide written for the next Claude, not documentation for a human**, and its trigger description is what decides whether it ever loads. You arrived a tool user. You leave a tool builder.*

This guide accompanies [Week 10](../sessions/week-10/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). It is the finale, and it reframes the whole course: the workflows you have leaned on since Week 5 were not magic, they were six building blocks you can now author yourself. The live demo turns the Healthy Brain Network (HBN) shot-change analysis you have grown since Week 3 into a small, reusable skill. The loop closes literally: the thing you analyzed becomes a thing you publish.

> **Scope note.** Only *skills* are built live this week. Agents, commands, hooks, and MCP servers are named and placed on the decision table, and signposted to their own `plugin-dev` skills, but the hands-on build is a single skill with `/skill-development`. Forking and publishing are shown as commands, not run on stage, so a network hiccup cannot derail the finale.

---

## You Have Used All Six Already

Start with the reveal, because it makes everything else concrete. Map the course onto the six building blocks:

- **Week 3 -- `/epic-dev`, `/plan`.** Those were **commands**.
- **Week 4 -- pre-commit and continuous integration.** Those were **hooks**, event-driven and deterministic.
- **Weeks 5-9 -- opencite, grant, manuscript, figures, Brain Imaging Data Structure conversion.** Every one was a **skill**.
- **Weeks 8-9 -- `figure-qa`, `bids-validator`.** Those were **agents**.
- **The whole practicum -- `matlab-mcp`.** That was an **MCP server**, the wire that let Claude drive MATLAB and EEGLAB.
- **`research-skills`.** The **plugin** marketplace that shipped weeks 5 through 9.

None of it was magic. The names were just never said out loud. This week says them.

---

## Two Questions That Sort All Six

Researchers stay confused about skill versus agent versus MCP long after a course ends, because the words get used interchangeably and are not interchangeable. You do not need six definitions. You need two questions.

1. **Who triggers it?** Claude, from intent (a skill or an agent); you, explicitly (a command); an event (a hook); an always-on connection (an MCP server).
2. **Where does it run?** The main conversation (a skill); its own context window (an agent); outside the model entirely (a hook or an MCP server).

That is the whole framework. It produces a decision table you can screenshot:

| You want... | Reach for a... |
|---|---|
| Claude to follow your procedure when the topic comes up | **Skill** |
| A scoped job done on its own, returning a result | **Agent** |
| A deliberate `/entry-point` for a multi-step workflow | **Command** |
| Something to happen automatically on an event (save, commit, tool use) | **Hook** |
| Claude to reach an external system (MATLAB, a database, an application programming interface) | **MCP server** |
| To bundle and share any of the above | **Plugin** |

One line to remember it by: **Skill = knowledge. Agent = a worker. Command = a button. Hook = a tripwire. MCP = a wire to the outside. Plugin = the box.**

### Skill vs Agent: the confusion worth clearing

Both are triggered by Claude from intent, so they get mixed up. The difference is where the work happens. A **skill** loads knowledge into the *main* conversation, and Claude keeps working with the procedure in hand. An **agent** is a separate worker with its *own* context window, its *own* tools, and a model choice; you hand it a scoped job and it returns a result, and several agents can run in parallel. From this course: `scientific-figure` is a skill you use directly; `figure-qa` is an agent you hand a figure to and it reports back.

Reach for an agent when the work is isolated, repeatable, or runs in parallel. Reach for a skill when you want the procedure in the room with you.

### Skill vs MCP: knowledge vs a wire

The other confusion. A skill teaches Claude *how to do* something with tools it already has. An **MCP server** gives Claude *new tools* by wiring it to an external system. You used one all course: `matlab-mcp` is what let Claude drive MATLAB and EEGLAB. No skill could do that; it needed a connection. The test: if the job needs the outside world (a program, a database, an application programming interface, a browser), it is an MCP server, not a skill.

### The plugin is the box; the marketplace is the shelf

A **plugin** is the only one of the six that is a container, not a capability. A single `plugin.json` manifest bundles `skills/`, `agents/`, `commands/`, and `hooks/` (and optionally an MCP server config). A **marketplace** (`marketplace.json`) lists plugins for install. `research-skills` is one marketplace holding seven plugins: `project`, `grant`, `manuscript`, `opencite`, `figures`, `presentation`, and `neuroinformatics`.

---

## What a Skill Actually Is

A skill is an onboarding guide for a domain. It turns general Claude into a specialist by handing over procedural knowledge no model fully has. It is a required `SKILL.md` file plus optional folders:

```
shot-change-erp/
├── SKILL.md          (required: frontmatter + body)
├── references/       (detailed docs, loaded only when needed)
├── scripts/          (code, executed, often never read into context)
└── assets/           (templates, icons, fonts used in your output)
```

### Progressive disclosure: why skills stay cheap

Skills load in three levels, in order, so you only pay for what you use:

1. **Metadata** (name + description) -- always in context, about 100 words.
2. **The `SKILL.md` body** -- loaded only when the skill triggers; target 1,500 to 2,000 words.
3. **Bundled resources** -- `references/`, `scripts/`, `assets/`, pulled only when Claude needs them; effectively unlimited, because a script can run without ever being read into the context window.

This is what lets you install dozens of skills without drowning the context window. The practical rule: keep `SKILL.md` lean, and let `references/` carry the weight.

### The trigger description decides everything

The frontmatter `description` decides whether Claude ever loads the skill. It must be third person and full of the exact phrases a user would say. A perfect skill with a vague description never fires.

```yaml
---
name: shot-change-erp
description: This skill should be used when the user asks to "analyze shot-change ERPs",
  "epoch around movie cuts", "shot-onset ERP", or to compute event-related potentials
  around movie shot changes in EEG data.
---
```

Compare a description that works with one that does not:

- **Fires:** `This skill should be used when the user asks to "convert to BIDS", "create a BIDS sidecar", "validate BIDS compliance"...` -- third person, concrete phrases Claude can match to a real message.
- **Stays asleep:** `Provides guidance for figures.` -- vague, no phrases, wrong person. Nothing for Claude to match.

The body is for when it loads. The description is *whether* it loads.

### Write for the next Claude, in imperative form

The non-obvious mindset: a skill is onboarding for a future agent, not documentation for a human reader. Three rules follow:

- **Imperative voice.** "Read `events.tsv`," not "You should read the file."
- **Lean.** Only the non-obvious steps; do not duplicate the same fact in `SKILL.md` and `references/`.
- **Leave out what a model already knows.** If a capable model already knows it, it is noise.

A good body reads like terse procedure:

```text
Read events.tsv; keep shot-onset rows.
Epoch -200..600 ms around each onset.
Baseline-correct, average, plot the ERP.
Flag channels over threshold.
```

---

## Building a Skill with /skill-development

You do not author a skill from a blank file. You run `/skill-development`, which is itself a skill (it ships in the official `plugin-dev` plugin). It is a six-step process:

1. **Understand** the use cases with concrete example prompts.
2. **Plan** the reusable resources (scripts, references, assets).
3. **Scaffold** the directory (`mkdir -p skills/shot-change-erp/{references,scripts}`).
4. **Write** `SKILL.md`: a strong description and a lean, imperative body.
5. **Validate** with the `skill-reviewer` agent.
6. **Iterate.**

Steps 4 through 6 are the loop you actually live in.

### Test it: does it trigger?

The first and most important test is not "does the body read well," it is "does the skill load when it should." The test has two sides, and both are passing:

- Say the natural-language phrase ("analyze the shot-change ERPs") and watch the skill load.
- Say an off-topic message ("what is the capital of France?") and confirm it does *not* load.

Test locally before publishing by loading the plugin from disk:

```bash
claude --plugin-dir ./my-plugin
```

Then type the phrases and watch what fires. An untriggered skill is a skill that does not exist.

### Review and iterate

The `skill-reviewer` agent (an agent, naturally) checks the mechanical things: is the description specific, is the body lean, is detail moved to `references/`, is the writing imperative, are the examples complete.

```text
"Review my skill and check it follows best practices."
```

Then comes the real loop: use the skill on a real task, notice where it struggles, and revise: sharpen the description, move bulk to `references/`, add a `script` for anything you rewrite repeatedly. This is Week 10's mechanical defence, the same idea as `cite-the-card` (Week 5) and `validate_fonts.py` (Week 8): a deterministic gate that turns "looks fine" into "passes review."

### When a skill is not enough: level up

A skill is the starting point, not the ceiling. When it cannot carry the job, the other five building blocks each have a `plugin-dev` skill to guide you:

- A separate, isolated worker -> an **agent** (`agent-development`).
- A deliberate entry point -> a **command** (`command-development`).
- Something automatic on every commit or tool use -> a **hook** (`hook-development`).
- A connection to an external system -> an **MCP server** (`mcp-integration`).

---

## Make It Your Own

### Fork research-skills

The marketplace you installed back in Week 5 is a public GitHub repository. Fork it and it is yours: `plugins/*` each with a `plugin.json`, a top-level `marketplace.json`, and an `AGENTS.md` plus `CLAUDE.md` pair. The tools you have used all course are a repo you can own.

### Add your skill, install it back

Drop `shot-change-erp/` into a plugin's `skills/`, bump that plugin's version, then add and install:

```bash
claude plugin marketplace add ./research-skills
claude plugin install neuroinformatics@research-skills
```

Because instructions live in `AGENTS.md`, the same skill also works in Codex and GitHub Copilot CLI, cross-agent for free.

### Version and share

Each plugin is versioned independently with semantic versioning. The bump rules from the repo:

- Adding a new plugin or skill -> a **minor** bump (`0.x.0`).
- Editing within an existing plugin -> a **patch** bump (`0.x.y`).

Then share, in increasing reach: push your fork so your lab installs from it; open a pull request to contribute upstream; or post it in the OSC Discord for the community. A skill your lab can install beats a script in your downloads folder.

---

## Before You Build, and When Not To

A whole session about building deserves an honest counterweight: do not over-build. A quick pre-flight before you start:

- Is there already a skill for this?
- Is this knowledge (a skill), a connection (an MCP server), or an event (a hook)?
- Will you actually reuse it?
- Is `SKILL.md` lean, with detail in `references/`?
- Did you test that it triggers?
- Any secrets or data? Never put them in a skill; it is shared knowledge, not a vault.

Skip it if it is a one-off, if it already exists, or if it needs a secret. The bar is reuse: if you will do it again, make it a skill.

---

## Live Walkthrough

One thing, done well, about four minutes:

1. **Build with `/skill-development`** -- write a strong trigger description and a lean `SKILL.md` for `shot-change-erp`, capturing the find-shot-events, epoch, average, plot procedure the course has run since Week 3.
2. **Prove it triggers** -- type the natural-language phrase and watch the skill load; optionally run the `skill-reviewer` agent.

No live fork and no install on stage. The point of the finale is not a speed-run of a whole plugin; it is that building a skill is approachable.

---

## Common Pitfalls

- **Polishing a skill that never loads.** Fix the trigger description first; the best body is invisible if Claude cannot match a message to it.
- **Reaching for an agent when a skill will do.** Agents are for isolated, parallel, or repeatable work, not for everything.
- **Confusing a skill with an MCP server.** If the job needs an external program or service, it is a connection, not knowledge.
- **A fat `SKILL.md`.** It taxes every trigger. Move detail to `references/`.
- **Second-person prose.** Write imperative instructions for the next Claude, not a tutorial for a person.
- **Secrets in a skill.** Skills are shared. Keep credentials and data out.

---

## The Course in One Breath

From `git init` in Week 1 to a published skill in Week 10. You used all six building blocks; this week you built one; the HBN shot-change analysis you have grown since Week 3 is now a reusable skill anyone can install.

What is next:

- Build a skill for the chore you redo most.
- Fork [`research-skills`](https://github.com/neuromechanist/research-skills), add your skill, and install it back so your whole lab gets it.
- Contribute it upstream with a pull request, or post it in the [Open Science Collective](https://osc.earth) Discord.
- Help the next cohort. You now know the whole pipeline.

You arrived a tool user. You leave a tool builder. Thank you for ten weeks.
