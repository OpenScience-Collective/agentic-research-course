# Week 3 Slide Plan

## Target: 15 slides, 30-35 min presentation, then live walkthrough + Q&A

**Core message.** AI is powerful. Structure turns that power into trustworthy research outputs. Structure starts with how you *describe* the problem (goals, rough steps, **checks**, success criteria, quality control) and extends into how you *manage* the work (epic + sub-issues + worktrees + plan-mode + PR review).

Last time 30 slides took an hour; cap at 15, ~2 min per slide.

## Slide Inventory

### Opening (3 min)

1. **Title** - "Week 3: Project Management with AI". Author, course link, Discord link.
2. **Where we are** - Week 1 git (safety net), Week 2 Claude Code (the agent). Today: structure that makes the agent trustworthy at research scale.

### Why Structure (4 min)

3. **AI is powerful; structure turns power into results** - Single-slide thesis. With no structure, speed compounds into technical debt. With steps + checks + balances, speed compounds into output. One callout, one contrast diagram (unstructured vs structured).
4. **Structured problem definition** - The most undervalued artifact in AI-assisted research. Write the problem down *before* you let the agent plan. A markdown file (or the user-scope `CLAUDE.md`) containing: **Goal**, **Rough steps**, **Checks** (what would fail the analysis), **Success criteria**, **Quality control**. Conversational works; markdown is better because it's versioned. Show the HBN `project_brief.md` with callouts pointing at each section.

### Initialize the Project (3 min)

5. **`/project:init-project`** - Consumes your structured definition and scaffolds the standing files for the agent to work inside: `CLAUDE.md` (project-scope AI context), `.rules/` (team coding standards), `.context/` (working plan, ideas, scratch history, research), `.gitignore`. Local-only; Week 4 adds remote CI/CD. Show the folder tree.

### The Epic/Sprint Workflow (8 min)

6. **Epic = multi-phase feature** - A feature too large for one PR. Each phase = one sub-issue = one branch = one worktree = one PR. Plain-English definition on one slide.
7. **Our epic -- HBN "The Present" boy vs puppy ERSP** - The concrete research question. Two files in hand: `project_brief.md` (our structured definition) and `shot_events.tsv` (56 shots, 49 trusted labels after drift filter). Everything else gets generated. Numbers: 23 has_boy, 18 has_puppy, 3 both, 7 neither.
8. **Six phases** - Preprocess -> AMICA + dipfit -> IClabel -> expand shot events + epoch -> ERSP precompute + cluster -> group stats + figures. Each phase is a check on the previous one (e.g., AMICA runs only if preprocess passes; clustering runs only after IClabel prunes non-brain components).
9. **GitHub Issues + sub-issues** - Parent epic issue, child sub-issue per phase, linked with `gh sub-issue add`. Sub-issue status = phase status. Show the commands, not the UI.
10. **Git worktrees** - Work Phase 2 while Phase 1 is in review. No stashing, no context loss. Show three commands (`git worktree add ...`).

### Plan-Mode and Review Are Checks (5 min)

11. **`/plan` is a check on your reasoning** - Plan mode proposes files, functions, tests, open questions *before* any code is written. You reshape the plan; then Claude implements. This is the single most leveraged habit in the course. The check here: did I define the problem tightly enough for the plan to be short?
12. **`/review-pr` is a check on the output** - Six specialized reviewers on every PR: code quality, silent failures, comments, test coverage, type design, architecture. Rule: address every finding, or explain the false positive in the PR. No technical debt carried forward. This is AI checking AI, supervised by you.

### Bridge to Hands-On (2 min)

13. **What's next vs what today already gives you** - Week 4 adds CI/CD (pre-commit hooks, GitHub Actions, typed/linted pipelines). Those are remote automated checks. Today's workflow already ships -- you do not need CI/CD to start.

### Final Handoff (3 min)

14. **Walkthrough roadmap** - Next ~30 minutes, live: (a) `git init` the practicum locally, (b) copy `project_brief.md` + `shot_events.tsv` into it, (c) `/project:init-project`, (d) push a fresh private repo to `OpenScience-Collective`, (e) create the epic and six sub-issues, (f) `/plan` Phase 1 preprocessing, (g) approve and watch Claude Code write the first MATLAB function through `matlab-mcp`.
15. **What we have, what we do next** - Two columns, no filler.
    - **Have:** `project_brief.md` (goal, steps, checks, success, QC). `shot_events.tsv` (56 shots, `has_boy`, `has_puppy`, `LLR`, `match_diff_s`).
    - **Do next, live:** init practicum -> push private -> epic + six sub-issues -> `/plan` -> Phase 1 preprocessing for HBN-EEG Release 3 in MATLAB/EEGLAB.
    - Bottom line: "Questions? Ask while the agent preprocesses."

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 3 min |
| Why structure | 2 | 4 min |
| Initialization | 1 | 3 min |
| Epic workflow | 5 | 8 min |
| Plan + review as checks | 2 | 5 min |
| Bridge + final | 3 | 5 min |
| **Total** | **15** | **28 min** |

Remaining 15-17 min: live walkthrough during the session + Q&A at the end.

## Assets Needed (produce via `/scientific-figures:scientific-figures` skill)

- `week-03/structure-vs-chaos.svg` - slide 3. Two-panel contrast: left = tangled arrows, right = clean pipeline with checks.
- `week-03/problem-definition.svg` - slide 4. A markdown document icon with five labelled sections: Goal, Steps, Checks, Success, QC.
- `week-03/init-project-tree.svg` - slide 5. Folder tree for `/project:init-project` output (`CLAUDE.md`, `.rules/`, `.context/`, `.gitignore`).
- `week-03/epic-phases.svg` - slide 8. Epic branch fanning into six phase branches merging back via PRs.
- `week-03/worktree.svg` - slide 10. Two working directories on the filesystem, each pointed at a different branch.
- `week-03/review-pr.svg` - slide 12. A PR card at center, six reviewer-agent icons around it pointing in.
- `week-03/checks-balances.svg` - slide 13 or reused on slide 3. A scale with "AI power" on one pan and "structure + checks" on the other, balanced.

No mermaid. Hand-crafted SVGs only. Delegate to `/scientific-figures:scientific-figures`.

## Screenshots Needed

- None mandatory. If time permits, capture: `gh sub-issue add` terminal output, `/plan` mode interactive view (reuse from Week 2 if available).

## Speaker-Note Themes

- Slide 3 lands the thesis. Don't rush. Let the contrast breathe.
- Slide 4 is the most important teaching slide. Spend 90 seconds here. Read the five sections aloud from the brief.
- Slide 7 is the first time the audience sees a concrete research project. Keep it up long enough for them to notice the numbers are real.
- Slide 11 vs slide 12: frame plan-mode as a check on your problem definition and `/review-pr` as a check on the output. Both are instances of the same thesis from slide 3.
- Slide 15 is the bridge. The walkthrough starts the moment it goes up. The slide stays on screen until the agent starts typing.
