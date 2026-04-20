# Week 3 Presentation: Project Management with AI

15-slide cap. ~30 min presentation, then live walkthrough + Q&A.

**Thesis:** AI is powerful. Structure (starting with a written problem definition, continuing through epic + sub-issues + worktrees + plan-mode + PR review) turns that power into trustworthy research output. Every theoretical point is anchored to the HBN Practicum: boy-vs-puppy ERSP on "The Present" in Release 3. Session-starter files live at `sessions/week-03/practicum/`.

## Opening

### Slide 1: Title
- Week 3: Project Management with AI

### Slide 2: Where we are
- Week 1: git and GitHub (the safety net)
- Week 2: Claude Code (the agent)
- Today: structure that makes the agent trustworthy at research scale

## Why Structure

### Slide 3: AI is powerful; structure turns power into results
- Without structure: speed compounds into technical debt
- With steps + checks + balances: speed compounds into output
- Contrast diagram: tangled vs pipelined

### Slide 4: Structured problem definition
- The most undervalued artifact in AI-assisted research
- Write the problem down *before* the agent plans anything
- Five sections, every time: **Goal**, **Rough steps**, **Checks**, **Success criteria**, **Quality control**
- Markdown file or user-scope `CLAUDE.md`; conversational works, markdown is better because it is versioned
- Show `sessions/week-03/practicum/project_brief.md` as the working example

## Initialize the Project

### Slide 5: `/project:init-project`
- Consumes your structured definition
- Scaffolds: `CLAUDE.md` (AI context), `.rules/` (team standards), `.context/` (working state), `.gitignore`
- Local scaffold; Week 4 adds remote CI/CD

## The Epic/Sprint Workflow

### Slide 6: Epic = multi-phase feature
- A feature too large for one PR
- Phase = sub-issue = branch = worktree = PR

### Slide 7: Our epic -- HBN "The Present" boy vs puppy ERSP
- Compare 0-500 ms ERSP between boy-shots and puppy-shots
- HBN-EEG Release 3, task `ThePresent`, EEGLAB + matlab-mcp
- Input files: `project_brief.md`, `shot_events.tsv`
- 49 trusted shots after drift filter: 23 boy, 18 puppy, 3 both, 7 neither

### Slide 8: Six phases
1. Preprocess R3 (filter, cleanline, channel rejection)
2. AMICA + dipfit
3. IClabel + brain component selection
4. Expand shot events + epoch around shots
5. ERSP precompute + IC clustering
6. Group statistics + figures
- Each phase is itself a check on the previous one

### Slide 9: GitHub Issues + sub-issues
- Parent epic issue; sub-issues per phase
- `gh sub-issue add <parent> --sub-issue-number <child>`
- Sub-issue status = phase status

### Slide 10: Git worktrees
- Parallel phase development without stashing
- `git worktree add ../epic-hbn -b feature/epic-hbn main`
- `git worktree add ../hbn-phase1 -b feature/phase1-preproc feature/epic-hbn`
- Work Phase 2 while Phase 1 is in review

## Plan-Mode and Review Are Checks

### Slide 11: `/plan` is a check on your reasoning
- Plan mode proposes files, functions, tests, open questions before any code is written
- You reshape the plan; then Claude implements
- Self-check: is the problem defined tightly enough for the plan to be short?

### Slide 12: `/review-pr` is a check on the output
- Six reviewers per PR: code quality, silent failures, comments, tests, types, architecture
- Address every finding; explain false positives in the PR
- No technical debt carried forward

## Bridge to Hands-On

### Slide 13: What's next vs what today gives you
- Week 4 adds CI/CD (pre-commit, GitHub Actions, linters, type checks)
- Today's workflow already ships without any of that
- CI/CD is leverage, not prerequisite

## Final Handoff

### Slide 14: Walkthrough roadmap
- `git init` the practicum locally
- Copy `project_brief.md` + `shot_events.tsv`
- `/project:init-project`
- Push a fresh private repo to `OpenScience-Collective`
- Create epic + six sub-issues
- `/plan` Phase 1 preprocessing
- Approve and implement with matlab-mcp

### Slide 15: What we have / what we do next
- **Have**
  - `project_brief.md` -- goal, steps, checks, success, QC
  - `shot_events.tsv` -- 56 shots, has_boy, has_puppy, LLR, match_diff_s
- **Do next (live)**
  - Init practicum, push private
  - Epic + six sub-issues
  - `/plan` Phase 1
  - Implement Phase 1 preprocessing for HBN Release 3 in MATLAB/EEGLAB

## Before Next Week

- Try the epic + worktree workflow on one of your own projects
- Week 4 layers CI/CD and code quality gates on top of this workflow
