# Week 3: Project Management with AI

## The Big Picture

You have git (week 1) and Claude Code (week 2). Now the question becomes: how do you organize non-trivial work? A single script is easy. A multi-step analysis pipeline with preprocessing, artifact rejection, Independent Component Analysis (ICA), and statistical analysis is not. This session teaches the epic/sprint workflow: breaking complex research projects into phases, tracking each phase with GitHub Issues, developing in parallel with git worktrees, and using Claude Code to plan and review every step.

The core principle: the bigger the project, the more structure you need. AI makes it easy to generate code; project management makes it possible to trust that code.

## Learning Objectives

By the end of this session, participants will be able to:

### Project Initialization
- Use `/init-project` to scaffold a project with CLAUDE.md, `.rules/`, `.context/`, and config files
- Customize templates for their specific research domain
- Understand the role of each file in the project structure

### Epic/Sprint Workflow
- Define an "epic" as a large feature broken into sequential phases
- Create a parent GitHub Issue for the epic with phase descriptions
- Create sub-issues for each phase and link them to the parent
- Explain when to use epics (multi-phase) vs single branches (small tasks)

### Git Worktrees
- Explain what a worktree is and why it matters for parallel development
- Create worktrees for epic branches and phase branches
- Develop in one phase while another is in review
- Clean up worktrees after merge

### Plan Mode and Implementation
- Use `/plan` to design an implementation before writing code
- Review and refine plans before execution
- Implement a phase following the approved plan

### Pull Requests and Code Review
- Create PRs with clear titles, descriptions, and issue references
- Run `/review-pr` for automated code review
- Address all review findings (no technical debt carried forward)
- Understand the merge workflow: phase PRs to epic branch, epic PR to main

### Practicum Application
- Define the HBN analysis as a multi-phase epic
- Create the epic issue structure for the practicum
- Begin Phase 1 of the HBN practicum

## Outline

| Time  | Section | Description |
|-------|---------|-------------|
| 0:00  | Recap | Weeks 1-2 review; from single scripts to real projects |
| 0:03  | Project Initialization | `/init-project` demo; what each template file does |
| 0:08  | Epic/Sprint Concepts | When and why to use epics; phase decomposition |
| 0:13  | GitHub Issues and Sub-Issues | Creating epics, phases, linking with `gh sub-issue add` |
| 0:18  | Git Worktrees | Creating and managing worktrees; parallel development demo |
| 0:25  | Live Demo: HBN Epic | Define the HBN analysis epic; create issues, worktree, plan Phase 1 |
| 0:35  | PR Workflow | Create PR, run `/review-pr`, address findings |
| 0:40  | Wrap-up | The workflow in summary; what to practice |
| 0:45  | Q&A | Open questions |

## Key Concepts

- **Epic:** A large feature (e.g., "HBN movie shot-change analysis") broken into phases, each with its own branch, sub-issue, and PR
- **Sprint/Phase:** One step of an epic; small enough to complete, review, and merge in a focused session
- **Git worktree:** A git feature that lets you check out multiple branches simultaneously in separate directories; no more stashing or switching
- **Sub-issue:** A GitHub Issue linked to a parent issue; tracks phase progress within an epic
- **Plan mode:** Claude Code's interactive planning feature; designs the approach before generating code
- **`/review-pr`:** Automated code review using specialized agents (code quality, error handling, test coverage, type design)
- **No technical debt carried forward:** Every PR review finding is addressed before merge, not deferred

## Example: HBN Practicum Epic

```
Epic: HBN Movie Shot-Change ERP Analysis
├── Phase 1: Data import and BIDS structure
├── Phase 2: Preprocessing (filtering, artifact rejection)
├── Phase 3: ICA decomposition and component classification
├── Phase 4: Epoch extraction around shot-change events
├── Phase 5: ERP computation and statistical analysis
└── Phase 6: Figures and manuscript sections
```

Each phase becomes a sub-issue, a worktree, a branch, and a PR.

## Pre-Session Prep

- [ ] Completed Week 2 tasks (Claude Code installed, CLAUDE.md created)
- [ ] Install the `gh` CLI: `brew install gh` (macOS) or see docs
- [ ] Authenticate: `gh auth login`
- [ ] Have your course project repository ready

## Before Next Session

- [ ] Try creating a multi-phase feature using the epic workflow
- [ ] Practice: branch, commit, PR, review, merge
- [ ] (Optional) Set up the HBN practicum project with the epic structure above
- [ ] Read about GitHub Actions (we'll set up CI/CD in Week 4)
