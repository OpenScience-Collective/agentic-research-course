# Week 3 Guide: Project Management with AI

*How to structure a research project so an AI agent can be trusted with it. Covers the structured problem definition, `/project:init-project`, epic/phase workflow, GitHub sub-issues, git worktrees, plan mode, and `/review-pr`.*

This guide accompanies [Week 3](../sessions/week-03/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). By the end you will know how to turn a research question into a written problem definition, scaffold a project the agent can operate inside, decompose the work into independently shippable phases, and run each phase through plan mode and PR review without carrying technical debt forward. Every concept here is anchored to the Healthy Brain Network (HBN) practicum: a study-level ERP analysis comparing boy-shots to puppy-shots in "The Present" short film.

Setup was a one-time investment. Project management is a habit. This guide is long because the habit has many small parts, not because any one part is complicated.

---

## Why Structure Matters Before You Scale

Week 2 installed the agent. Claude Code can now read your project, write code across multiple files, run commands, open pull requests, and iterate on its own work. The question is how to organize the work *so you trust the output*.

A single script is a commit. You write it, run it, check the result, and ship. A study-level EEG analysis is different: import Brain Imaging Data Structure (BIDS) data, preprocess, decompose with independent component analysis (ICA), classify components, epoch around events, compute event-related spectral perturbation (ERSP), cluster, and run group statistics. Six or seven phases, each with parameters, failure modes, and checkpoints. Each phase generates hundreds of lines of code and hours of compute.

The agent is happy to write all of that at once. You should not be happy to let it. With no structure, speed compounds into technical debt: the agent writes plausible code that silently does the wrong thing, and you discover the mistake three weeks later during peer review. With steps, checks, and balances, speed compounds into output: the agent writes one reviewable chunk at a time, you reshape the plan before any code is committed, the PR review catches anything you missed, and at the end you have a pipeline you can point a collaborator at.

The rest of this guide is about the specific steps, checks, and balances that make that second outcome the default.

---

## 1. Write a Structured Problem Definition

Before any code gets written, before `/plan` gets invoked, before `/project:init-project` scaffolds anything, write the problem down. This is the most undervalued artifact in AI-assisted research. Five sections, every time.

- **Goal.** One or two sentences. What question does this answer? For the HBN practicum: "Do the first 500 ms of EEG differ when a movie shot opens with the boy visible versus the puppy visible, in HBN-EEG Release 3 during the `ThePresent` task?"
- **Rough steps.** A phase sketch the plan can renegotiate. Not a prescription. For the practicum: preprocess, ICA and dipfit, component classification, shot-aligned epoching, ERSP computation, group statistics.
- **Checks.** What would invalidate the analysis? Name the failure modes up front. "Bad channels not removed", "ICA non-convergence", "too few brain components per subject", "shot-event count mismatch between EEG and stimulus TSV", "zero-trial conditions after drift filtering."
- **Success criteria.** What does "done" look like? A saved EEGLAB STUDY file under `derivatives/`. Group-level ERSP maps for the two conditions. Cluster-level statistics. A figure at the cluster of maximal effect.
- **Quality control (QC).** Data-quality notes, known gotchas, drift filters, invalidation rules. "Labels for shots with `match_diff_s > 1.0 s` are set to `n/a` because the nearest annotation is from a different shot." "Subjects with zero brain components after ICLabel are dropped."

Conversational works. You can tell Claude Code in plain English what the goal, steps, checks, success, and QC are. Markdown is better because it is versioned, reviewable, and read by Claude on every session. Put it in a file and commit it.

Scope matters. A project-specific problem definition (like `project_brief.md` for the practicum) lives in the repo. Cross-project defaults that apply to everything you do (commit style, test policy, never-do rules) live in the user-scope `~/.claude/CLAUDE.md`. Claude Code reads both.

Here is a short excerpt from the practicum `project_brief.md` to show the shape:

```markdown
## Research Question
Compare event-related spectral perturbation (ERSP) in the 0 to 500 ms window
after shot onset for boy-shots vs puppy-shots in The Present, using HBN-EEG
Release 3.

## Rough Steps (a sketch; `/plan` will reshape these)
1. Preprocess R3: filter, cleanline, channel rejection
2. AMICA + dipfit
3. IClabel, drop non-brain components
4. Expand shot events from shot_events.tsv, epoch
5. ERSP precompute, IC clustering
6. Group statistics, manuscript-ready figures

## Checks (what would invalidate the analysis)
- Bad channels retained after `clean_rawdata`
- AMICA fails to converge on >20% of subjects
- Fewer than 5 brain components after IClabel for any subject
- Trials per condition below 20 after epoching

## Success Criteria
- STUDY file saved to derivatives/ with all intermediate stages
- Group ERSP maps per condition, 0-500 ms baseline-corrected
- Cluster-level statistics at p < 0.05 FDR
- One figure showing the condition difference at the peak cluster

## Quality Control
- Drift filter: `match_diff_s > 1.0 s` rows have has_boy/has_puppy = n/a
- Resample to 500 Hz on load if source is 100 Hz mini
- `derivatives/` checkpoint after each phase
```

That file plus `shot_events.tsv` is literally everything in the practicum repository at the start of the Week 3 walkthrough. Every other file gets generated from them.

---

## 2. Scaffold the Project with `/project:init-project`

Once the problem is written down, run `/project:init-project` to generate the standing files that turn a bare repository into a working project for the agent.

```text
# inside the repo root
claude
# then, at the Claude prompt:
/project:init-project
```

The skill reads your problem definition, asks a few clarifying questions, and produces:

- `CLAUDE.md` -- project-scope AI context, pulled from your brief, plus the team rules and never-do section
- `.rules/` -- team coding standards: `git.md`, `documentation.md`, `code_review.md`, `self_improve.md` if applicable
- `.context/plan.md` -- current tasks and what comes next
- `.context/ideas.md` -- design decisions and rationale
- `.context/research.md` -- technical investigations
- `.context/scratch_history.md` -- failed attempts so the agent does not repeat them
- `.gitignore` with sensible language defaults

This is a local scaffold. It runs on your laptop and commits to your repo. Remote automated gates (GitHub Actions, pre-commit, typed linters) arrive in Week 4. You do not need them to start.

Read everything `/project:init-project` generates before you commit it. The generated `CLAUDE.md` is an 80% draft; the last 20% is facts about your project that only you can add. Prune aggressively. A bloated `CLAUDE.md` gets ignored; a tight one gets followed.

---

## 3. Epic = Multi-Phase Feature

A feature too large for one pull request (PR) is called an **epic**. You decompose it into **phases**. Each phase is the smallest chunk that is still meaningfully reviewable and mergeable. For the HBN practicum the six phases are:

1. Preprocess Release 3: import BIDS, high-pass 1 Hz, cleanline 60/120/180 Hz, channel rejection
2. AMICA and dipfit: per-subject ICA, attach weights, compute dipoles
3. IClabel: classify components, keep brain, drop the rest
4. Shot events and epoching: expand `shot_events.tsv`, epoch around shots, split by flag
5. ERSP precompute and IC clustering: study-level, 3 to 80 Hz
6. Group statistics and figures: cluster contrasts, manuscript-ready plots

Each phase has a natural failure mode and a natural checkpoint. AMICA does not run until preprocessing passes. Clustering does not run until IClabel has pruned non-brain components. The staging is itself a check: if a phase fails, you do not waste compute on downstream ones.

The single most useful sentence on this slide: **phase = sub-issue = branch = worktree = PR**. One unit of research work, five tracking artifacts that hold each other accountable. If any of the five is missing, the other four cannot ship. You cannot merge without a PR. You cannot open a PR without a branch. You cannot track a branch without a sub-issue. You cannot work two phases in parallel without two worktrees.

---

## 4. GitHub Issues and Sub-Issues

Every phase is a GitHub Issue. The epic itself is also a GitHub Issue, and the phase issues are its **sub-issues**. This requires a GitHub CLI extension:

```bash
# install once per machine
gh extension install agbiotech/gh-sub-issue
```

Create the parent epic issue first. Write a short description and list the phases:

```bash
gh issue create \
    --title "Epic: HBN The Present boy vs puppy ERSP" \
    --label "epic,P1" \
    --body-file epic.md
# -> opens issue #1
```

Then one sub-issue per phase, each linked to the parent:

```bash
gh issue create --title "Phase 1: Preprocess R3" --label feature
# -> issue #2
gh sub-issue add 1 --sub-issue-number 2

gh issue create --title "Phase 2: AMICA + dipfit" --label feature
# -> issue #3
gh sub-issue add 1 --sub-issue-number 3

# ...repeat for phases 3-6
```

Sub-issue status equals phase status. When you close issue #2, Phase 1 is done. When all six sub-issues are closed, the epic closes automatically.

No out-of-band trackers. Issues live where the code lives, PRs close them automatically when merged, and the whole epic tree is visible from the parent issue page on GitHub. If you find yourself opening a spreadsheet or a Notion page to track phase progress, something has gone wrong.

---

## 5. Git Worktrees for Parallel Phase Development

Git worktrees let you check out multiple branches simultaneously, each in its own directory. You work on Phase 2 while Phase 1 is in review. No stashing, no `git stash pop`, no context loss when you switch branches in the same directory.

Create an epic branch off `main`, then phase branches off the epic branch:

```bash
# repo root is still your main working directory
cd ~/Documents/git/agentic-research-practicum

# epic branch in its own worktree directory
git worktree add ../epic-hbn -b feature/epic-hbn main

# Phase 1 worktree, branched from the epic branch
git worktree add ../hbn-phase1 -b feature/phase1-preproc feature/epic-hbn

# Phase 2 worktree, in parallel with Phase 1
git worktree add ../hbn-phase2 -b feature/phase2-amica feature/epic-hbn
```

You now have three working directories (`../epic-hbn`, `../hbn-phase1`, `../hbn-phase2`) alongside the main one, each on a different branch. Open each in its own terminal tab; run Claude Code in each separately. Phase 2 work does not disturb Phase 1 review, and vice versa.

After a phase PR merges, clean up:

```bash
git worktree remove ../hbn-phase1
```

The worktree is gone, but the branch (and any unmerged commits) remains in the repository until you delete it separately.

**Worktrees solve context loss; they are not a feature.** Most researchers have never used them because, until AI agents, the cost of switching branches in the same directory was tolerable. With the agent writing hundreds of lines per phase and multiple phases in flight, stashing becomes a bottleneck. Worktrees remove it.

---

## 6. The Epic Branch as an Integration Point

On simple projects, phases can merge straight into `main`. On involved projects (the HBN practicum is one), phases merge into the **epic branch** first, and only after all phases integrate cleanly on the epic branch does the whole epic merge to `main` as a single PR.

Why the extra step? Because an epic-level integration test catches things that per-phase tests cannot. Phase 1 (preprocessing) and Phase 4 (epoching) each pass their own tests in isolation. But when Phase 4 consumes Phase 1's output, the channel rejection from Phase 1 might leave an electrode that Phase 4's topoplot code expects. No per-phase test would catch that mismatch because each phase is tested against its own synthetic input. Merging to the epic branch first forces the phases to integrate against each other, runs the end-to-end pipeline on a real subject, and surfaces cross-phase issues before they reach `main`.

The rule of thumb:

- **0 to 2 phases** -- skip the epic branch; merge straight to `main`.
- **3 to 5 phases** -- optional; use an epic branch if phases depend on each other's outputs.
- **6 or more phases, or research pipelines** -- always use an epic branch. The integration test is worth the extra review.

For the practicum, the branching looks like this:

```
main ─────────────────────────────────────────────────●──── main
       \                                              ^
        epic-hbn ────●──●──●──●──●──● integration ── /   epic PR
                    /  /  /  /  /  /
                   P1 P2 P3 P4 P5 P6   (phase PRs)
```

Each phase PR targets `feature/epic-hbn`, not `main`. Once Phase 6 merges to the epic branch, you run the end-to-end pipeline on a test subject (one run, real data, everything on). If it succeeds, open the epic PR from `feature/epic-hbn` to `main` with the integration evidence in the description. Reviewers get to see the whole epic at once.

---

## 7. `/plan` Mode: A Check on Your Reasoning

Plan mode is the single most leveraged habit in the course. It proposes files, functions, tests, and open questions *before* any code is written.

To enter plan mode, press `Shift+Tab` until the status line shows "plan mode". You can also type `/plan` to jump straight there.

What happens next depends on your problem definition. If the definition is tight, the plan is short and specific. If the definition is vague, the plan sprawls. **The length of the plan is itself a check on the definition.** If Claude's plan runs to thirty bullet points for a single phase, go back to your problem definition and tighten the Goal, Steps, Checks, Success, QC sections. Then re-plan.

Once the plan looks right, approve it. Claude starts implementing. Files get created and edited in order; tests run; failures get fixed. You read along and intervene if needed. The plan is the contract; anything the agent does outside it gets flagged.

Example plan-mode prompt for Phase 1 of the HBN practicum:

```text
/plan

Phase 1 of the epic: preprocess HBN-EEG Release 3 for the ThePresent task.
Read project_brief.md, shot_events.tsv, and the reference pipeline at
~/Documents/git/HBN_BIDS_analysis/study_handy_scripts.m.

Deliverables for this phase:
1. A MATLAB function preproc_r3.m that takes a study path, an output path,
   and a task name, and produces a cleaned ALLEEG saved to derivatives/preproc/
2. Command-line entry point so Claude can run it via matlab-mcp
3. One end-to-end test on subject sub-NDARAA075AMK from the R3-mini

Checks from project_brief.md that must hold:
- All non-brain electrodes retained; only bad channels are dropped
- Cleanline removes 60, 120, 180 Hz without introducing ringing
- Output is ~20 ALLEEG datasets (one per mini subject), shape preserved
```

Claude proposes the plan. You reshape it. Then implement.

A tight problem definition plus a good plan produces a session where the agent writes the phase, runs the tests, and opens a PR in roughly the time it takes you to grab a coffee. A thin definition plus a vague plan produces hours of back-and-forth. Invest in the definition.

---

## 8. `/review-pr`: A Check on the Output

Once a phase PR is open, run `/review-pr`. Six specialized reviewers examine the PR, each through a different lens:

| Reviewer | Catches |
|----------|---------|
| `code-reviewer` | Style, naming, logic errors, OWASP-class issues |
| `silent-failure-hunter` | try/except swallowing errors, fallbacks hiding bugs |
| `comment-analyzer` | Stale, wrong, or load-bearing comments |
| `pr-test-analyzer` | Test coverage vs what the feature actually does |
| `type-design-analyzer` | Invariants, encapsulation, enforcement |
| `code-simplifier` | Removes duplication, tightens the diff |

All six run in parallel. The reviewers post their findings as PR comments. You read them and address everything that is not a genuine false positive. If you decide a finding is a false positive, explain why in a reply on the PR thread. That explanation is the evidence that someone thought about it, not evidence that the finding was wrong.

**No technical debt carried forward.** This is the rule that makes the loop work. If you defer a finding to "later", "later" never comes, and the debt accumulates across six phases into something nobody wants to review. Address it in this PR or have a linked issue that tracks the deferral.

The common objection is that running six reviewers on every PR is overkill. It is not. Each reviewer catches something the others miss, and the marginal cost of running them all is about 90 seconds of compute. The marginal cost of shipping a subtle bug to `main` and finding it during peer review six months later is much higher.

---

## 9. Week 4 Preview: CI/CD Adds Automated Gates

Everything in this guide runs on your laptop. Week 4 adds the remote automated gates:

- Pre-commit hooks that run lint and format on every commit (`ruff` for Python, `biome` for JavaScript and TypeScript, language-specific type checkers)
- GitHub Actions that run the test suite on every PR
- Typo linters and documentation checks
- Release automation

CI/CD is leverage, not a prerequisite. The workflow you have now (structured problem definition, `/project:init-project`, epic and sub-issues, worktrees, `/plan`, `/review-pr`) already ships research code. CI/CD makes the checks automatic, not essential. Do not wait to learn CI/CD before starting a project; start with today's workflow and layer CI/CD on once the project has two or three phases under its belt.

---

## 10. The HBN Practicum, End to End

This is what the Week 3 live walkthrough produces, step by step. If you are following along on your own project, substitute your problem for "HBN The Present boy vs puppy ERSP".

1. `git init` the practicum repository locally. Two files land in it immediately: `project_brief.md` (the structured problem definition from Section 1) and `shot_events.tsv` (56 shots from "The Present" with `has_boy`, `has_puppy`, `LLR`, and a `match_diff_s` quality column; after drift filtering, 49 trusted rows).
2. Run `/project:init-project` inside the repo. Review the generated `CLAUDE.md`, prune anything already obvious from the code, keep the project-specific rules. Commit.
3. Push as a fresh **private** repository to `OpenScience-Collective/agentic-research-practicum`:
   ```bash
   gh repo create OpenScience-Collective/agentic-research-practicum \
       --private --source=. --remote=origin --push
   ```
4. Create the epic issue:
   ```bash
   gh issue create --title "Epic: HBN The Present boy vs puppy ERSP" \
       --label "epic,P1" --body-file epic.md
   ```
5. Create six phase sub-issues and link them:
   ```bash
   for n in 1 2 3 4 5 6; do
       gh issue create --title "Phase $n: ..." --label feature
   done
   # link each to the parent
   gh sub-issue add 1 --sub-issue-number 2
   gh sub-issue add 1 --sub-issue-number 3
   # ...etc
   ```
6. Create the epic worktree and the Phase 1 worktree:
   ```bash
   git worktree add ../epic-hbn -b feature/epic-hbn main
   git worktree add ../hbn-phase1 -b feature/phase1-preproc feature/epic-hbn
   cd ../hbn-phase1
   ```
7. Start Claude Code in the Phase 1 worktree. Enter plan mode (`Shift+Tab` until the status line shows "plan mode") and ask it to plan the first MATLAB function, referencing `project_brief.md`, `shot_events.tsv`, and the reference pipeline at `~/Documents/git/HBN_BIDS_analysis/study_handy_scripts.m`. Reshape the plan.
8. Approve the plan. Claude writes `preproc_r3.m`, a command-line entry point, and a minimal integration test on the R3-mini dataset, all through `matlab-mcp`. You watch.
9. Open a PR from `feature/phase1-preproc` to `feature/epic-hbn`. Run `/review-pr`. Address every finding; explain any false positives in-thread.
10. Merge Phase 1 into the epic branch. Close sub-issue #2.

At the end of the session, you have a private repository, a structured brief, an epic, six sub-issues, worktrees for the epic and Phase 1, a merged Phase 1 PR, and a known-working preprocessing function for HBN-EEG Release 3. Phases 2 through 6 are exercises; they follow exactly the same pattern.

---

## Before Next Week

- Pick one of your own projects. Write a `project_brief.md` with the five sections: Goal, Rough steps, Checks, Success criteria, Quality control. Keep it short (one to two pages).
- Run `/project:init-project` inside that project. Prune the generated `CLAUDE.md` to under 200 lines.
- Create an epic issue and at least two phase sub-issues. Link them with `gh sub-issue add`.
- Create a worktree for the epic and one phase. Work one phase end to end: `/plan`, implement, PR, `/review-pr`, address findings, merge.
- Read the [GitHub Actions quickstart](https://docs.github.com/en/actions/quickstart). Week 4 layers CI/CD on top of this workflow.

## References

- [Course site](https://courses.osc.earth/agentic-research/)
- [Week 3 session README](../sessions/week-03/) -- objectives, outline, pre-session prep
- [Session-starter materials](../sessions/week-03/practicum/) -- `project_brief.md` and `shot_events.tsv`
- [`gh sub-issue` extension](https://github.com/agbiotech/gh-sub-issue)
- [Git worktree documentation](https://git-scm.com/docs/git-worktree)
- [Claude Code plan mode](https://code.claude.com/docs/plan-mode) (Anthropic docs)
- [HBN-EEG dataset overview](https://neuromechanist.github.io/data/hbn/)

---

*License: CC-BY-4.0. You are free to share and adapt this guide with attribution. The code examples are released under the same license as the [course repository](https://github.com/OpenScience-Collective/agentic-research-course).*
