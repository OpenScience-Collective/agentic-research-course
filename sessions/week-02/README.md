# Week 2: Setting Up Claude Code for Research

## Learning Objectives

By the end of this session, you will:
- Install and configure Claude Code
- Understand what CLAUDE.md is and why it matters
- Write effective prompts for code generation
- Set up a development environment with UV (Python) and Bun (JavaScript)
- Complete your first AI-assisted coding session

## Outline

### Part 1: Installing Claude Code (10 min)
- Installation methods (CLI, VS Code extension, desktop app)
- First run and authentication
- Understanding the permission model

### Part 2: CLAUDE.md -- Teaching the AI Your Project (10 min)
- What is CLAUDE.md and where does it live
- What to put in it (project goals, conventions, tooling)
- What not to put in it (ephemeral state, secrets)
- Using `/init-project` to scaffold a project

### Part 3: Prompting for Research (15 min)
- How to write clear, effective prompts
- Voice dictation: Claude handles typos and speech artifacts
- Iterative prompting: building on previous responses
- When to use plan mode (`/plan`)

### Part 4: Development Environment (10 min)
- UV for Python: why not pip/conda
- Bun for JavaScript: why not npm
- Pre-commit hooks with Ruff
- The `.context/` directory: plan, ideas, research, scratch_history

### Q&A (15 min)

## Key Concepts

- **CLAUDE.md:** Project-level instructions that persist across sessions
- **Plan mode:** Interactive planning before implementation
- **UV:** Fast Python package manager (replaces pip/conda)
- **Bun:** Fast JavaScript runtime (replaces npm/node)
- **Context directory:** Structured documentation for project state

## Before Next Session

- Have Claude Code working on your machine
- Create a project with CLAUDE.md and `.context/` directory
- Try asking Claude Code to write a simple script in your research area
