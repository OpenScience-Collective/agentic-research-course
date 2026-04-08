# Week 2: Setting Up Claude Code for Research

## The Big Picture

Last week we established the foundation: git and GitHub are the safety net. This week we install the tool that makes the safety net necessary. Claude Code is an AI coding agent that can read your entire project, write code, run terminal commands, create pull requests, and iterate on its own work. It is the most powerful research productivity tool available today, and setting it up correctly determines how useful it will be for the rest of this course.

The key insight: Claude Code is only as good as the context you give it. A well-written CLAUDE.md file turns a generic AI into a domain-aware research assistant.

## Learning Objectives

By the end of this session, participants will be able to:

### Installation and Configuration
- Install Claude Code via CLI, VS Code extension, or desktop app
- Authenticate and configure permissions
- Understand the permission model: what Claude Code can and cannot do without asking

### CLAUDE.md and Project Context
- Explain why CLAUDE.md exists and how it shapes every AI interaction in the project
- Write an effective CLAUDE.md with project goals, tech stack, conventions, and never-do rules
- Create the `.context/` directory structure: `plan.md`, `ideas.md`, `research.md`, `scratch_history.md`
- Understand when to use `.rules/` for reusable development standards

### Prompting and Interaction
- Write clear, specific prompts that produce useful results
- Use voice dictation effectively (Claude handles speech artifacts)
- Use plan mode (`/plan`) to design before implementing
- Iterate on responses: refine, correct, extend

### Development Environment
- Set up UV for Python projects (replacing pip/conda)
- Set up Bun for JavaScript/TypeScript (replacing npm)
- Understand why modern tooling matters for AI-assisted workflows

### Practicum Kickoff
- Scaffold the HBN analysis project with CLAUDE.md
- Connect the concept of CLAUDE.md to the HBN practicum
- Run a first AI-assisted task on real research data

## Outline

| Time  | Section | Description |
|-------|---------|-------------|
| 0:00  | Recap | Week 1 review; git as the safety net |
| 0:03  | Installing Claude Code | CLI install, auth, first run; permission model |
| 0:10  | CLAUDE.md Deep Dive | What goes in it, what doesn't; live creation for a research project |
| 0:20  | The .context/ Directory | plan.md, ideas.md, research.md, scratch_history.md; when to use each |
| 0:25  | Prompting for Research | Writing effective prompts; voice dictation; plan mode demo |
| 0:33  | Development Environment | UV for Python, Bun for JS; pre-commit hooks |
| 0:38  | Practicum: HBN Project Setup | Live: create CLAUDE.md for HBN analysis, first AI-assisted task |
| 0:43  | Wrap-up | What to practice before next week |
| 0:45  | Q&A | Open questions |

## Key Concepts

- **CLAUDE.md:** Project-level instructions that persist across Claude Code sessions; the most important file for AI-assisted development
- **Plan mode:** Interactive planning where Claude Code designs the approach before writing code; activated with `/plan`
- **UV:** Fast, reliable Python package manager and virtual environment tool; replaces pip, conda, and virtualenv
- **Bun:** Fast JavaScript runtime and package manager; replaces npm and node for many tasks
- **Context directory (`.context/`):** Structured documentation for project state: current plan, design ideas, research notes, failed attempts
- **Rules directory (`.rules/`):** Reusable development standards (git conventions, testing policy, documentation standards)
- **research-skills plugin:** Claude Code plugin providing academic workflow tools (install with Claude Code plugin system)

## Pre-Session Prep

- [ ] Completed Week 1 tasks (GitHub account, git installed, repository created)
- [ ] Install Claude Code: `brew install claude-code` (macOS) or see docs
- [ ] Have a terminal open and ready
- [ ] (Optional) Think about a research project you'd like to use as your course project

## Before Next Session

- [ ] Have Claude Code working on your machine
- [ ] Create a project with CLAUDE.md and `.context/` directory
- [ ] Ask Claude Code to write a simple script related to your research
- [ ] Review the CLAUDE.md it generated and refine it manually
- [ ] (Optional) Install the research-skills plugin
