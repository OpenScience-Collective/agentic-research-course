# Week 3: Project Management with AI

## The Big Picture

Week 1 gave us the safety net (git, GitHub). Week 2 gave us the agent (Claude Code). This session is about organizing real work. A one-off script gets committed and forgotten. A study-level EEG analysis, a manuscript, or a grant submission is a project: multiple phases, multiple people, multiple decision points. AI makes it cheap to write code; structure is what makes that code trustworthy.

The core message: the bigger the project, the more structure you need. Epic/sprint workflow, GitHub Issues with sub-issues, git worktrees, plan mode, `/review-pr`. No CI/CD yet; Week 4 adds the automated gates. Today's workflow already ships.

This week is a live walkthrough. We present for ~30 minutes, then we immediately start building a real repository: the HBN "The Present" boy-vs-puppy ERSP analysis.

## Learning Objectives

By the end of this session, participants will be able to:

### Project Initialization
- Run `/project:init-project` and explain what each scaffolded file does (CLAUDE.md, `.rules/`, `.context/`, `.gitignore`, pre-commit stub)
- Drop research input files (project brief, event tables) into a fresh repository as the starting point for `/plan`

### Epic/Sprint Workflow
- Define an epic and its phases
- Create a parent GitHub Issue for the epic; create sub-issues for each phase
- Link sub-issues with `gh sub-issue add`

### Git Worktrees
- Create worktrees for epic branches and phase branches
- Develop one phase while another is in review
- Clean up worktrees after merge

### Plan Mode and Implementation
- Enter plan mode, review the proposed plan, reshape it before any code is written
- Approve the plan and implement a phase end-to-end

### Pull Requests and Code Review
- Create a PR linked to the phase sub-issue
- Run `/review-pr` and interpret the output from six specialized reviewers
- Address every finding or explicitly mark false positives

### Practicum
- Initialize the practicum repository from a fresh `git init` using the two session-starter files (`project_brief.md`, `shot_events.tsv`)
- Push the repository to `OpenScience-Collective/agentic-research-practicum` as private
- Produce a working plan for Phase 1 and begin implementing the preprocessing function for HBN-EEG Release 3 in MATLAB/EEGLAB

## Outline

| Time  | Section | Description |
|-------|---------|-------------|
| 0:00  | Opening | Title + where we are |
| 0:03  | Why structure | AI is powerful; steps + checks unlock it |
| 0:05  | Structured problem definition | Goal, steps, **checks**, success, QC -- our `project_brief.md` |
| 0:08  | `/project:init-project` | What the scaffold gives you |
| 0:11  | Epic = multi-phase feature | Epic / phase / sub-issue / branch / worktree / PR |
| 0:13  | Our epic | HBN "The Present" boy vs puppy ERSP |
| 0:15  | Six phases | Preprocess -> AMICA -> IClabel -> epoch -> ERSP -> stats |
| 0:17  | GitHub issues + sub-issues | `gh sub-issue add` |
| 0:19  | Git worktrees | Parallel phase development |
| 0:22  | `/plan` as check on reasoning | Proposes before code; reshape first |
| 0:25  | `/review-pr` as check on output | Six reviewers, no tech debt |
| 0:27  | Week 4 preview | CI/CD adds automated checks; today already ships |
| 0:29  | Walkthrough roadmap | Next 30 minutes live |
| 0:32  | Final handoff | What we have, what we do next |
| 0:33  | Live walkthrough | Init practicum, push, epic, `/plan`, Phase 1 |
| 1:15  | Q&A | Open questions |

## Key Concepts

- **Epic:** a feature too large for one PR, broken into independently shippable phases
- **Sub-issue:** a GitHub Issue linked to a parent epic issue; tracks phase progress
- **Git worktree:** multiple branches checked out simultaneously in separate directories; no stashing or context switching
- **Plan mode:** interactive planning in Claude Code; designs the approach before generating code (`Shift+Tab` to enter)
- **`/review-pr`:** orchestrated PR review using six specialized agents (code quality, silent failures, comments, test coverage, type design, architecture)
- **No technical debt carried forward:** every review finding is addressed before merge, or the false positive is explained in the PR

## Practicum

This session launches the practicum repository. Session-starter materials live in this course repository:

- `sessions/week-03/practicum/project_brief.md` - the research project description
- `sessions/week-03/practicum/shot_events.tsv` - 56 shots from "The Present" with `has_boy`, `has_puppy`, `LLR`, `match_diff_s` (drift filter: labels for rows with `match_diff_s > 1.0 s` are set to `n/a`; 49 trusted rows remain)

The practicum repository (`OpenScience-Collective/agentic-research-practicum`) starts empty. During the live walkthrough we `git init` locally, copy the two starter files in, run `/project:init-project`, push to GitHub as private, create the epic and six sub-issues, plan Phase 1, and begin implementing the R3 preprocessing function in MATLAB/EEGLAB via `matlab-mcp-tools`.

### Example: HBN Practicum Epic

```
Epic: HBN "The Present" -- Boy vs Puppy ERSP (Release 3)
├── Phase 1: Preprocessing (filter, cleanline, channel rejection)
├── Phase 2: AMICA + dipfit
├── Phase 3: IClabel + brain component selection
├── Phase 4: Expand shot events, epoch around shots
├── Phase 5: ERSP precompute + IC clustering
└── Phase 6: Group statistics + figures
```

Each phase becomes a sub-issue, a worktree, a branch, and a PR.

## Pre-Session Prep

- [ ] Completed Week 2 tasks (Claude Code installed, CLAUDE.md on your own project)
- [ ] Install `gh` CLI: `brew install gh` (macOS) and authenticate with `gh auth login`
- [ ] Install the `gh sub-issue` extension: `gh extension install agbiotech/gh-sub-issue`
- [ ] MATLAB with EEGLAB 2024+ available locally (for the hands-on portion; optional if just watching)
- [ ] `matlab-mcp-tools` connected to Claude Code (see repo README for setup)

## Before Next Session

- [ ] Try the epic + worktree workflow on one of your own projects
- [ ] Practice: branch, plan, commit, PR, `/review-pr`, merge
- [ ] Read about GitHub Actions. Week 4 adds CI/CD and code quality gates on top of this workflow.
