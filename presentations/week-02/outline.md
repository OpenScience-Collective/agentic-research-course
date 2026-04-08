# Week 2 Presentation: Setting Up Claude Code for Research

## Opening: Recap and Motivation (3 min)

### Slide 1: Title
- Week 2: Setting Up Claude Code for Research

### Slide 2: Last Week
- Git = safety net (undo, audit, collaborate)
- Today: install the tool that makes the safety net necessary

## Installing Claude Code (7 min)

### Slide 3: What is Claude Code?
- CLI agent that reads your project, writes code, runs commands
- Not autocomplete; it plans, implements, tests, and iterates
- Available as CLI, VS Code extension, desktop app

### Slide 4: Live Install
- `brew install claude-code` (or platform-specific)
- First run, authentication
- Permission model: what it can do without asking vs what requires approval

### Slide 5: The Permission Model
- Read files: always allowed
- Write files: asks permission (unless configured otherwise)
- Run commands: asks permission
- You control the guardrails

## CLAUDE.md Deep Dive (10 min)

### Slide 6: The Most Important File
- CLAUDE.md = your project's instructions to the AI
- Every Claude Code session reads it first
- A good CLAUDE.md turns a generic AI into your domain expert

### Slide 7: What Goes In
- Project purpose and goals
- Tech stack and conventions
- Development workflow
- "Never do this" rules
- Pointers to .context/ and .rules/

### Slide 8: What Stays Out
- Secrets and credentials
- Ephemeral state (current debugging session)
- Things that change every day

### Slide 9: Live Demo
- Create CLAUDE.md for a research project from scratch
- Show how it changes Claude Code's behavior

## The .context/ Directory (5 min)

### Slide 10: Structured Project State
- `plan.md` -- what you're working on now and next
- `ideas.md` -- design decisions and rationale
- `research.md` -- technical investigations
- `scratch_history.md` -- failed attempts (so you don't repeat them)

### Slide 11: Why This Matters
- AI reads these files; they become part of its context
- Your plan.md becomes the AI's task list
- Your scratch_history.md prevents the AI from repeating your mistakes

## Prompting for Research (8 min)

### Slide 12: Writing Good Prompts
- Be specific: "Add a bandpass filter 1-40 Hz to step2.m" not "fix the preprocessing"
- Give context: "This is EEG data from a movie-watching paradigm"
- Voice dictation works: Claude handles "uh", "um", typos

### Slide 13: Plan Mode
- `/plan` -- design before you build
- Claude proposes the approach; you refine before it writes code
- Demo: plan a simple analysis step

### Slide 14: Iterative Prompting
- First response not perfect? Refine, don't restart
- "Change the filter to 0.5-45 Hz instead"
- "Add a figure showing the power spectrum"

## Development Environment (5 min)

### Slide 15: Modern Tooling
- UV for Python (not pip, not conda)
- Bun for JavaScript (not npm)
- Why: faster, more reliable, better dependency management
- Claude Code knows these tools natively

## Practicum: HBN Project Setup (5 min)

### Slide 16: Live Demo
- Create the HBN analysis project
- Generate CLAUDE.md with Claude Code
- First AI-assisted task: set up project structure

## Wrap-up (2 min)

### Slide 17: Before Next Week
- Have Claude Code working
- Create CLAUDE.md and .context/ for your project
- Try one AI-assisted coding task
- Next week: project management with epics, sprints, worktrees
