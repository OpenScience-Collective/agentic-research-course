# Agentic Research Course

## Project Context
**Purpose:** A 10-week live course teaching researchers how to use Claude Code and AI coding agents for academic research workflows, hosted by the Open Science Collective (OSC). The course pairs curriculum with a hands-on practicum analyzing Healthy Brain Network (HBN) EEG data for movie shot-change events using EEGLAB via matlab-mcp.
**Format:** Weekly 30-45 min Discord Stage sessions + 15 min Q&A, recorded to YouTube
**Audience:** Researchers with no prior coding requirement (weeks 1-2), scaling to plugin development (week 10)
**License:** CC-BY-4.0

## Architecture Map
```
sessions/
├── week-01/          # Git, GitHub, CLI + landscape overview
├── week-02/          # Claude Code setup
├── week-03/          # Project management (epics, sprints, worktrees)
├── week-04/          # CI/CD and code quality
├── week-05/          # Literature search (opencite)
├── week-06/          # Grant proposals
├── week-07/          # Manuscript prep
├── week-08/          # Scientific figures
├── week-09/          # Neuroinformatics (BIDS, PsychoPy, LSL)
└── week-10/          # Building plugins
presentations/
├── week-01/          # Slide decks / outlines per session
├── week-02/
└── ...
assets/               # Shared images, diagrams
.context/             # Planning and design docs
.rules/               # Development standards
```

## Related Repositories
- **matlab-mcp-tools** ([GitHub](https://github.com/neuromechanist/matlab-mcp-tools)) -- MCP server for MATLAB/EEGLAB integration with Claude Code
- **research-skills** ([GitHub](https://github.com/neuromechanist/research-skills)) -- Course companion plugin (opencite, grant writing, manuscript prep, neuroinformatics)
- **HEDit** ([GitHub](https://github.com/Annotation-Garden/HEDit)) -- Multi-agent system for Hierarchical Event Descriptor (HED) annotation generation
- **image-annotation** ([GitHub](https://github.com/Annotation-Garden/image-annotation)) -- Web-based annotation tool for static images
- **agentic-presentation-builder** ([GitHub](https://github.com/neuromechanist/agentic-presentation-builder)) -- JSON-based presentation engine used for course slides

## Practicum Project
The live demos use HBN EEG data to analyze neural responses to movie shot changes:
- Data: Healthy Brain Network (HBN) dataset
- Tools: EEGLAB + matlab-mcp-tools (Claude Code drives MATLAB)
- Analysis: Event-related potentials around shot-change events
- This practicum threads through weeks 2-9, building complexity each session

## Development Workflow
1. Check `.context/plan.md` for current tasks and session prep status
2. Review `.context/ideas.md` for pedagogical decisions
3. Branch per session or feature: `feature/issue-N-description`
4. Commit: atomic, <50 chars, no emojis, no AI attribution
5. PR for non-trivial changes; run `/review-pr`

## Content Standards
- Session READMEs: learning objectives, outline, key concepts, pre-session prep
- Presentations: structured outlines or slide content in presentations/week-NN/
- No jargon without definition; define abbreviations on first use
- No em-dashes; use commas or semicolons
- Examples over explanations; show real tool output where possible
- Core message: AI tools are powerful, so quality assurance (QA), version control, and structured workflows matter more than ever

## [NEVER DO THIS]
- Never use pip, conda, virtualenv; use UV for Python
- Never use npm or npx; use Bun for JS/TS
- Never commit secrets or .env files
- Never add TODO without a linked issue
- Never use emojis in commits or PRs
- Never include AI attribution in commits

## Context Files
- `.context/plan.md` -- Current tasks, session prep status, work plan
- `.context/ideas.md` -- Pedagogical decisions, content design
- `.context/research.md` -- Technical investigations, tool evaluations
- `.context/scratch_history.md` -- Failed attempts, lessons learned

## Rules
- `.rules/git.md` -- Version control standards
- `.rules/documentation.md` -- Content and documentation standards
- `.rules/code_review.md` -- PR review process
- `.rules/self_improve.md` -- Evolving course standards from experience

---
Check .context/plan.md for what to work on next.
