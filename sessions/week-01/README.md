# Week 1: Git, GitHub, and the Command Line

## The Big Picture

This session does double duty: it teaches the foundational tools (git, terminal, GitHub) **and** sets the stage for the entire course. The core argument is simple: AI coding agents like Claude Code are extraordinarily powerful, and that power is exactly why you need version control, quality assurance (QA), and structured workflows. Git is not just a convenience; it is the safety net that lets you move fast without breaking things.

We start by surveying the landscape: what AI tools exist for researchers, what they can do today, and why the combination of agent-driven coding and disciplined version control is a game-changer.

## Learning Objectives

By the end of this session, participants will be able to:

### Landscape and Motivation
- Describe the current landscape of AI coding agents (Claude Code, GitHub Copilot, Cursor) and how they fit into research workflows
- Explain why AI-powered productivity demands stronger quality assurance, not weaker
- Articulate the role of version control as the foundation for safe, reproducible, AI-assisted research
- Recognize the research-skills plugin ecosystem and how it maps to the course syllabus

### Terminal Foundations
- Open a terminal and navigate the filesystem using `cd`, `ls`, `pwd`, `mkdir`
- Understand file paths (absolute vs relative) and directory structure
- Install software using a package manager (Homebrew on macOS, apt on Linux)

### Git Fundamentals
- Initialize a repository (`git init`) and clone an existing one (`git clone`)
- Stage files (`git add`), check status (`git status`), and commit (`git commit`)
- Push to a remote (`git push`) and pull updates (`git pull`)
- Explain the three states: working directory, staging area, committed

### GitHub Workflow
- Create a repository on GitHub
- Create and switch branches (`git checkout -b`)
- Open a pull request and understand why PRs matter even for solo work
- Use GitHub Issues to track work

## Outline

| Time  | Section | Description |
|-------|---------|-------------|
| 0:00  | The Landscape | What AI tools exist for researchers today; what changed in the last 2 years; the 8x productivity story |
| 0:08  | Why This Matters | AI is powerful, so QA and version control are non-negotiable; the "undo button" argument |
| 0:13  | Course Roadmap | 10-week syllabus overview; how the practicum (HBN analysis) threads through every session |
| 0:18  | Terminal Basics | `cd`, `ls`, `pwd`, `mkdir`; installing tools; file paths |
| 0:25  | Git Fundamentals | init, clone, add, commit, push, pull; the three states |
| 0:35  | GitHub Workflow | Create repo, branches, PRs, Issues; live demo |
| 0:43  | Wrap-up | What to install before next week |
| 0:45  | Q&A | Open questions |

## Key Concepts

- **AI coding agent:** Software that can read, write, and reason about code on your behalf (e.g., Claude Code)
- **Quality Assurance (QA):** Practices that ensure your code and analysis are correct, reproducible, and well-documented
- **Repository:** A project folder tracked by git, with full history of every change
- **Commit:** A snapshot of your project at a point in time; your atomic unit of progress
- **Branch:** A parallel version of your project for experimentation without risk
- **Pull request (PR):** A proposal to merge changes; creates a review checkpoint even for solo work
- **Remote:** The copy of your repo on GitHub (vs local on your machine)
- **research-skills:** Open-source Claude Code plugin with tools for literature, grants, manuscripts, figures, project management, and neuroinformatics

## The Landscape (Speaker Notes)

### What's Available Now
- **Claude Code:** CLI and IDE agent that reads your project, writes code, runs commands, creates PRs
- **GitHub Copilot:** Inline code completion in editors
- **Cursor:** AI-native code editor
- **research-skills plugin:** Domain-specific tools for academic workflows (literature search, grant writing, BIDS conversion, etc.)

### Why QA Matters More, Not Less
- AI can generate code 10x faster, which means bugs can accumulate 10x faster without guardrails
- Version control is the undo button: if the AI produces bad code, `git diff` shows what changed and `git revert` brings you back
- Structured workflows (issues, branches, PRs) create checkpoints and review opportunities
- The goal: move fast AND maintain correctness

### The Numbers
- Example from the instructor's own workflow: 1,052 GitHub contributions in 2024, 8,563 the following year; an 8x increase driven by Claude Code integration
- This is not about typing faster; it is about having an agent that understands your project and automates the repetitive parts

## Pre-Session Prep

- [ ] Create a GitHub account if you don't have one
- [ ] Install git on your machine (`git --version` to verify)
- [ ] (macOS) Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- [ ] Open your terminal and practice: `pwd`, `ls`, `cd`

## Before Next Session

- [ ] Create a GitHub repository and make at least 3 commits
- [ ] Push your repository to GitHub
- [ ] Install [Claude Code](https://claude.ai/claude-code) (we'll use it starting Week 2)
- [ ] (Optional) Read the course blog post: neuromechanist.github.io/blog/010-agentic-research-workflows/
