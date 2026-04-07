# Week 3: Project Management with AI

## Learning Objectives

By the end of this session, you will:
- Initialize projects with structured templates and standards
- Break complex features into phases using the epic/sprint workflow
- Use git worktrees for parallel development
- Manage GitHub Issues and sub-issues for tracking progress
- Create and review pull requests with AI assistance

## Outline

### Part 1: Project Initialization (10 min)
- Using `/init-project` to scaffold structure
- Templates: CLAUDE.md, `.rules/`, `.context/`, config files
- Core principles: no mocks, atomic commits, documentation-driven

### Part 2: Epic/Sprint Workflow (15 min)
- When to use epics vs single-phase features
- Creating epic issues with phase breakdown
- Git worktrees: working on multiple phases simultaneously
- The state file: `.claude/epic.local.md`

### Part 3: Live Demo -- Building a Feature (15 min)
- Define a multi-phase feature for our practicum project
- Create the epic issue, sub-issues, and worktree structure
- Implement Phase 1 with plan mode
- Create a PR and review it

### Part 4: PR-Driven Development (5 min)
- Why PRs matter even for solo projects
- Using `/review-pr` for automated code review
- Addressing review findings

### Q&A (15 min)

## Key Concepts

- **Epic:** A large feature broken into phases, each with its own branch and PR
- **Worktree:** A git feature that lets you have multiple branches checked out simultaneously
- **Sub-issues:** GitHub issues linked to a parent issue for tracking phase progress
- **Plan mode:** Designing the implementation before writing code

## Before Next Session

- Try creating a multi-phase feature using `/epic-dev`
- Practice the PR workflow: branch, commit, PR, review, merge
