# Week 10 Slide Plan -- Build Your Own: Skills, Agents, and the Researcher's Plugin

## Target: 23 slides, ~30 min presentation, then ~5 min live demo + ~15 min Q&A. The capstone.

**Core message.** For nine weeks you used tools other people built. Every week you ran one of six things without naming it: a **skill** (lit review, grants, manuscripts, figures, BIDS), an **agent** (`bids-validator`, `figure-qa`), a **command** (`/epic-dev`, `/init-project`), a **hook** (Week 4's pre-commit and CI checks), an **MCP server** (`matlab-mcp`, driving MATLAB and EEGLAB across the whole practicum), all packaged in a **plugin** (`research-skills`). This week names the six, hands you two questions that pick the right one for any job, and walks you through building the simplest, a skill, with `/skill-development`. The single most useful idea: **a skill is an onboarding guide written for the next Claude, not documentation for a human**, and its trigger description decides whether it ever loads. The arc closes the course loop: the HBN shot-change analysis grown since Week 3 becomes a reusable skill anyone can install. Tool user in; tool builder out.

The arc mirrors prior weeks: a clear framing up front (you already use all six), a durable reference artifact (the decision table), a mechanical defence (the `skill-reviewer` agent and the trigger test, the Week-10 equivalent of `cite-the-card` and `validate_fonts.py`), and every abstract point landing on the practicum the audience has lived in since Week 3.

## Definitions on first use
- **MCP** -- Model Context Protocol (the standard that lets Claude reach external tools and data).
- **ERP** -- event-related potential.
- **HBN** -- Healthy Brain Network (the practicum dataset).
- **CI** -- continuous integration (Week 4).
- **semver** -- semantic versioning (`MAJOR.MINOR.PATCH`).

## Slide Inventory

### Opening (2 slides, ~2 min)

1. **Title** -- "Week 10: Build Your Own -- Skills, Agents, and the Researcher's Plugin." Author block, course / Discord / recording links. Same title-slide pattern as Weeks 5-9. Subtitle nods to the finale: "The capstone."
2. **The reveal** -- Recap Weeks 1-9 paired by theme, landing on the turn: every week you *used* a tool; you never named what kind it was. Today you name all six and build one. Final bullet, `slide-up`: "You arrived a tool user. You leave a tool builder." Fragment-animated bullets. No hero SVG (text only); this is the emotional open of the capstone, keep it clean.

### Act 1 -- The six building blocks (7 slides, ~9 min)

3. **The question everyone has** -- Skill? Agent? Command? Hook? MCP? Plugin? Six words that get used interchangeably and are not interchangeable. The promise: two questions sort all of them. Asset: `six-blocks-jumble.svg` (the six terms scattered as an overlapping word-cloud on the left, an arrow to a tidy "2 questions" card on the right). Callout: "you do not need to memorize six definitions; you need two questions."
4. **Two questions that sort them all** -- (1) **Who triggers it?** Claude, from intent (skill, agent); you, explicitly (command); an event (hook); an always-on connection (MCP). (2) **Where does it run?** The main conversation (skill); its own context window (agent); outside the model entirely (hook, MCP). Asset: `two-questions.svg` (a 2-axis layout: vertical axis "who triggers", horizontal axis "where it runs", the five capabilities placed as cards in that space). This is the framework the whole act hangs on.
5. **The decision table** -- THE reference slide. "You want X -> reach for a Y," six rows (skill / agent / command / hook / MCP / plugin) with the one-line mental model underneath. Asset: `tool-decision-table.svg` (a clean table: left column "you want...", right column "reach for a...", plus the bottom rail: "Skill = knowledge | Agent = a worker | Command = a button | Hook = a tripwire | MCP = a wire to the outside | Plugin = the box"). This is the slide trainees screenshot. Make it readable from the back of the room.
6. **Skill vs agent -- the confusion worth clearing** -- Both are triggered by Claude from intent, so they get mixed up. A **skill** loads knowledge into the *main* conversation and Claude keeps working with it. An **agent** is a separate worker with its *own* context, its *own* tools, and a model choice; you hand it a scoped job and it returns a result (and several can run in parallel). Reach for an agent when the work is isolated, repeatable, or parallel; a skill when you want procedure in the room with you. Asset: `skill-vs-agent.svg` (left: skill = a card dropped into the main chat bubble, "knowledge, in context, you keep going"; right: agent = a separate boxed worker with its own tools, "delegated, isolated, returns a result"; examples tagged: figures skill vs `figure-qa` agent). Callout: "skill = knowledge you keep; agent = a job you delegate."
7. **Skill vs MCP -- knowledge vs a wire** -- The other confusion. A skill teaches Claude *how to do* something with tools it already has. An **MCP server** gives Claude *new tools* by wiring it to an external system. You have used one all course: `matlab-mcp` is what let Claude drive MATLAB and EEGLAB through the practicum. No skill could do that; it needed a connection. Asset: `mcp-wire.svg` (Claude in the centre, an MCP server as a socket on the edge, wires out to external systems: MATLAB/EEGLAB highlighted, plus a database, an API, a browser). Callout: "if the job needs the *outside world*, it is an MCP server, not a skill."
8. **You have used all six already** -- THE graduation slide. The course timeline, Weeks 1-9, each tagged by the tool type it secretly was: Wk3 `/epic-dev` (command), Wk4 pre-commit/CI (hook), Wk5 opencite (skill) and `matlab-mcp` (MCP, runs throughout), Wk6-7 grant/manuscript (skills), Wk8 `figure-qa` (agent), Wk9 `bids-conversion` (skill) + `bids-validator` (agent), all inside `research-skills` (plugin). Asset: `used-all-six.svg` (the Weeks 1-9 rail with colour-coded tool-type tags pinned to each, a legend mapping colour to tool type, `matlab-mcp` drawn as a band spanning Weeks 3-9). Callout: "none of this was magic; it was six building blocks you can now author yourself."
9. **The plugin is the box, the marketplace is the shelf** -- A plugin packages skills + agents + commands + hooks (+ MCP configs) behind one `plugin.json`; a marketplace (`marketplace.json`) is how plugins are listed and installed. `research-skills` is one marketplace holding seven plugins. Asset: `plugin-box.svg` (an open box labelled `plugin.json` with compartments `skills/`, `agents/`, `commands/`, `hooks/`; an arrow to a shelf labelled `marketplace.json` holding several plugin boxes). Bridges to "now let us open the simplest box: a skill."

### Act 2 -- Skills, up close (4 slides, ~6 min)

10. **What a skill actually is** -- An onboarding guide for a domain: it turns general Claude into a specialist by handing over procedural knowledge no model fully has. Anatomy: a required `SKILL.md` (frontmatter + body) plus optional `references/` (read as needed), `scripts/` (run, not always read), `assets/` (used in output). Asset: `skill-anatomy.svg` (the `skill-name/` tree annotated: `SKILL.md` = "always the entry point", `references/` = "loaded when needed", `scripts/` = "executed, token-free", `assets/` = "used in output"). Callout: "a skill is knowledge, packaged so it loads only when it is relevant."
11. **Progressive disclosure -- why skills stay cheap** -- The three-level loading: (1) metadata (name + description), always in context, ~100 words; (2) the `SKILL.md` body, loaded only when the skill triggers, target 1,500-2,000 words (hard cap ~5,000); (3) bundled resources, pulled only when Claude needs them. This is what lets you install dozens of skills without drowning the context window. Asset: `progressive-disclosure.svg` (a three-tier funnel: tier 1 "metadata -- always", tier 2 "SKILL.md -- on trigger", tier 3 "references / scripts / assets -- as needed", with rough word/size budgets on each tier). Callout: "keep `SKILL.md` lean; let `references/` carry the weight."
12. **The trigger description is everything** -- The frontmatter `description` decides whether Claude ever loads the skill. It must be third person and full of the exact phrases a user would say. Good vs bad, side by side. A perfect skill with a vague description never fires. Asset: `trigger-description.svg` (a `description:` line dissected: "This skill should be used when the user asks to '<phrase>', '<phrase>'..."; a green PASS example with concrete phrases beside a red FAIL example "Provides guidance for figures"). Callout: "the body is for when it loads; the description is *whether* it loads."
13. **Write for the next Claude, in imperative form** -- The non-obvious mindset: a skill is onboarding for a future agent, not docs for a human. Use imperative voice ("Parse the frontmatter", not "You should parse..."); do not duplicate the same fact in `SKILL.md` and `references/`; include what is non-obvious and skip what any model already knows. Asset: `write-for-claude.svg` (two columns: "Writing for a human" (second person, prose, background) crossed out, vs "Writing for the next Claude" (imperative, lean, non-obvious procedure) checked). Callout: "if a capable model already knows it, leave it out."

### Act 3 -- Building a skill (4 slides, ~5 min)

14. **`/skill-development` -- the skill that builds skills** -- A six-step process: (1) understand the use cases with concrete example prompts; (2) plan the reusable resources (scripts/references/assets); (3) scaffold the directory; (4) write `SKILL.md` (strong description, lean imperative body); (5) validate; (6) iterate. Asset: `skill-dev-process.svg` (the six steps as a horizontal flow with a loop arrow from 6 back to 4; each step labelled with its one output). Note: `/skill-development` ships in the official `plugin-dev` plugin.
15. **Test it: does it trigger?** -- The first and most important test is not "does the body read well", it is "does the skill load when it should". Say the natural-language phrase and watch it fire; install the plugin locally with `claude --plugin-dir ./my-plugin` to test before publishing; tighten the description until the right prompts trigger it and the wrong ones do not. Asset: `trigger-test.svg` (a prompt bubble "analyze the shot-change ERPs" -> a "skill loaded: shot-change-erp" chip -> a check; a second, off-topic prompt that correctly does *not* load it). Callout: "an untriggered skill is a skill that does not exist."
16. **Review and iterate** -- The `skill-reviewer` agent (an agent, naturally) checks description quality, writing style, and progressive disclosure. Then the real loop: use the skill on a real task, notice where it struggles, move bulk to `references/`, sharpen the description, add a `script` for anything rewritten repeatedly. Asset: `skill-reviewer-iterate.svg` (the `skill-reviewer` agent box emitting a short checklist, feeding a loop: use -> notice -> revise -> use). Frames this as Week 10's mechanical defence, the deterministic gate that turns "looks fine" into "passes review".
17. **When a skill is not enough -- level up** -- A skill cannot do everything. Need a separate isolated worker? an **agent** (`agent-development`). A deliberate entry point? a **command** (`command-development`). Something automatic on every commit or tool use? a **hook** (`hook-development`). A connection to an external system? an **MCP server** (`mcp-integration`). All six skills live in the official `plugin-dev` plugin. Asset: `level-up-tools.svg` (a skill at the centre with four "graduate to..." arrows to agent / command / hook / MCP, each annotated with its `plugin-dev` skill name). Callout: "start with a skill; reach for the others only when the skill cannot carry the job."

### Act 4 -- Make it your own (3 slides, ~4 min)

18. **Fork `research-skills`** -- The marketplace you installed back in Week 5 is a public GitHub repo. Fork it and it is yours: `plugins/*` each with a `plugin.json`, a top-level `marketplace.json`, and an `AGENTS.md` + `CLAUDE.md` pair. Asset: `fork-research-skills.svg` (the upstream `neuromechanist/research-skills` repo -> a Fork arrow -> `you/research-skills`, the `plugins/` tree visible inside). Callout: "the tools you have used all course are a repo you can own."
19. **Add your skill, install it back** -- Drop `shot-change-erp/` into a plugin's `skills/`, bump that plugin's version, then `claude plugin marketplace add ./your-fork` and install. Because instructions live in `AGENTS.md`, the same skill also works in Codex and Copilot CLI, cross-agent for free. Asset: `add-install-back.svg` (a four-step rail: add skill folder -> bump `plugin.json` version -> `marketplace add ./fork` -> `plugin install`; a side badge "AGENTS.md = works in Codex + Copilot too"). Commands verified against the `research-skills` README.
20. **Version and share** -- Each plugin is versioned independently with semver; the marketplace bump rules from the repo: adding a new plugin or skill is a minor bump (`0.x.0`), editing within a plugin is a patch (`0.x.y`). Then share: push your fork, open a pull request to upstream, or post it in the OSC Discord. Asset: `version-share.svg` (a semver line `MAJOR.MINOR.PATCH` annotated with the two bump rules, plus three share paths: fork / pull request / Discord). Callout: "a skill your lab can install is worth more than a script in your downloads folder."

### Act 5 -- Considerations and close (3 slides, ~3 min + 5 live)

21. **Before you build -- and when not to** -- A short pre-flight: is there already a skill for this? is this knowledge (skill), a connection (MCP), or an event (hook)? keep `SKILL.md` lean; do not build an agent when a skill will do; test the trigger; never put secrets or data in a skill. The honest note: the best skill is one you will actually reuse; a one-off does not need to be a skill. Asset: `pre-flight-checklist.svg` (a checklist card with the questions, plus a "do not build if..." footer: one-off task, already exists, needs a secret). Callout: "the bar is reuse: if you will do it again, make it a skill."
22. **Live demo roadmap** -- One thing, done well: run `/skill-development`, build `shot-change-erp` (a strong trigger description + a lean body that captures the find-epoch-average-plot procedure from the practicum), then prove it triggers by typing the phrase and watching it load; optionally run `skill-reviewer`. No live fork or install on stage. Asset: `demo-roadmap-build.svg` (two steps with timing badges: "build with /skill-development ~3 min" and "prove it triggers ~1 min"; a note: "fork + publish are on the slides, not risked live"). Matches the answered scope.
23. **Graduation -- what you can do now** -- The full course in one breath: `git init` (Wk1) to a published skill (Wk10). You used all six building blocks; today you built one; the HBN analysis you have grown since Week 3 is now a reusable skill anyone can install. What is next: build for the chore you redo most, fork `research-skills`, contribute back, help the next cohort. Final line, `slide-up`: "You arrived a tool user. You leave a tool builder." Two-column bullets + closing callout. No hero SVG; let the words and the course-long callbacks carry it.

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 2 min |
| Act 1 -- the six blocks | 7 | 9 min |
| Act 2 -- skills up close | 4 | 6 min |
| Act 3 -- building a skill | 4 | 5 min |
| Act 4 -- make it your own | 3 | 4 min |
| Act 5 -- considerations + close | 3 | 3 min + 5 live |
| **Total** | **23** | **~29 min content + 5 min demo** |

Q&A (~15 min) fills the rest. Act 1 carries the conceptual load (the taxonomy is the durable takeaway); budget extra breathing room on slides 5 (the decision table) and 8 (the graduation map).

## Animation Discipline (same as Weeks 5-9)

Every multi-bullet slide and every multi-line code block uses **fragment animations** so one concept is on screen at a time.
- Bullets stagger in one per click (`animation: { fragment: true, type: "fade", index: N }`), final bullet `slide-up`.
- Footer/side callouts appear after the main content (`fragment: true, type: "slide-up"`).
- Hero diagrams are single composed SVGs; build-on-click pacing lives in the speaker notes, not the SVG.
- Speaker notes lead with `[Press right Nx to reveal fragments]` on animated slides.

Text sizing (matching Weeks 8-9): title `xxl` / subtitle `large` / author `medium`; slide headers `xl`; bullets `xl` or `large`; hero images 82-92% width; callouts in `footer` (single-column) or `right` (two-column).

## Assets to produce (hand-crafted SVG, no mermaid; ship in `assets/icons/`)

Course palette (default theme, blue accent `#2563EB`). 20 hero SVGs; slides 1, 2, 23 are text/bullets only.

1. `six-blocks-jumble.svg` -- slide 3. Six overlapping terms resolving to a "2 questions" card.
2. `two-questions.svg` -- slide 4. 2-axis layout (who triggers x where it runs) with the five capabilities placed.
3. `tool-decision-table.svg` -- slide 5 (CENTERPIECE). "You want... -> reach for a..." table + one-line mental-model rail.
4. `skill-vs-agent.svg` -- slide 6. Skill-in-main-chat vs agent-as-isolated-worker, with examples tagged.
5. `mcp-wire.svg` -- slide 7. Claude + an MCP socket wired to MATLAB/EEGLAB, a database, an API, a browser.
6. `used-all-six.svg` -- slide 8 (graduation centerpiece). Weeks 1-9 rail, each tagged by tool type, `matlab-mcp` as a spanning band.
7. `plugin-box.svg` -- slide 9. Plugin box (`plugin.json` + compartments) on a `marketplace.json` shelf.
8. `skill-anatomy.svg` -- slide 10. Annotated `skill-name/` tree (`SKILL.md` + references/scripts/assets).
9. `progressive-disclosure.svg` -- slide 11. Three-tier loading funnel with budgets.
10. `trigger-description.svg` -- slide 12. Dissected `description:` line + PASS/FAIL examples.
11. `write-for-claude.svg` -- slide 13. "Writing for a human" vs "writing for the next Claude".
12. `skill-dev-process.svg` -- slide 14. Six-step `/skill-development` flow with a 6->4 loop.
13. `trigger-test.svg` -- slide 15. Prompt -> "skill loaded" chip -> check; off-topic prompt correctly not loading.
14. `skill-reviewer-iterate.svg` -- slide 16. `skill-reviewer` agent + use/notice/revise loop.
15. `level-up-tools.svg` -- slide 17. Skill -> agent/command/hook/MCP, each with its `plugin-dev` skill name.
16. `fork-research-skills.svg` -- slide 18. Upstream repo -> fork -> your repo, `plugins/` tree visible.
17. `add-install-back.svg` -- slide 19. Four-step add/bump/marketplace-add/install + AGENTS.md cross-agent badge.
18. `version-share.svg` -- slide 20. Semver line + bump rules + three share paths.
19. `pre-flight-checklist.svg` -- slide 21. Pre-build checklist + "do not build if..." footer.
20. `demo-roadmap-build.svg` -- slide 22. Two demo steps with timing badges.

## Production Notes
- Slide 5 (`tool-decision-table.svg`) and slide 8 (`used-all-six.svg`) are the two slides trainees will quote; give them the strongest, most legible treatment.
- Code/command snippets inside the build and fork slides render as SVG `<text>`, not raster, so they stay crisp and re-themeable.
- **Verify before freezing the JSON:** the exact `claude plugin` command spellings (`plugin marketplace add`, `plugin install neuroinformatics@research-skills`, `--plugin-dir`) against the `research-skills` README and the `skill-development` skill; the names of the `plugin-dev` skills (`skill-development`, `agent-development`, `command-development`, `hook-development`, `mcp-integration`, `plugin-structure`, `plugin-settings`); the `skill-reviewer` agent name; and the marketplace bump rules (new skill = minor, edit = patch).
- Facts safe to state about `research-skills`: seven plugins (project, grant, manuscript, opencite, figures, presentation, neuroinformatics), skills-first, cross-agent via `AGENTS.md`, independent per-plugin semver. `matlab-mcp` (matlab-mcp-tools) is the course's MCP server for MATLAB/EEGLAB.
- Keep the live demo honest and small (slide 22). The point of the finale is that building a skill is *approachable*, not that we can speed-run a whole plugin on stage.

## Continuity With Prior Weeks
- **Week 2:** `CLAUDE.md` was the first authoring step; a skill is the next.
- **Week 3:** `/epic-dev` and `/plan` were commands, now named and placed.
- **Week 4:** pre-commit and CI were hooks, now named.
- **Weeks 5-9:** every workflow was a skill; `figure-qa` and `bids-validator` were agents; the worked examples are tools the audience already trusts.
- **Whole practicum:** `matlab-mcp` is the MCP worked example.
- **Week 9 close:** "next week you build your own plugin." This is that week, and it closes the course.
