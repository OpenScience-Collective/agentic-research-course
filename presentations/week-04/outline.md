# Week 4 Presentation: CI/CD and Code Quality

23-slide cap. ~28 min presentation, then live walkthrough + Q&A.

**Thesis.** Week 3 gave you structure inside the repo (epic, sub-issues, worktrees, plan-mode, PR review). Week 4 puts a remote referee in front of every push so the agent cannot ship breakage. CI/CD is the automated extension of the same checks-and-balances logic. We pair it with a deliberately chosen tool chain (UV, ruff, ty, Bun, Biome, typos) because in research, reproducibility starts with the toolchain that produced the result.

## Opening

### Slide 1: Title
- Week 4: CI/CD and Code Quality

### Slide 2: Where we are
- Week 1: git + GitHub (safety net)
- Week 2: Claude Code (the agent)
- Week 3: epic + sub-issues + worktrees + plan + review (structure inside the repo)
- Today: CI/CD (automated checks **outside** the repo, on every push)

## Why CI/CD

### Slide 3: The problem CI/CD solves
- "Works on my machine"
- Agent commits a change that breaks an unrelated module; nobody notices for two weeks
- Manual testing every push does not scale -- humans skip it under deadline
- Research output is only as reproducible as the pipeline that produced it

### Slide 4: CI vs CD, plainly
- **Continuous Integration** -- every push runs lint, type check, tests; broken `main` becomes mechanically impossible
- **Continuous Deployment** -- every passing build can ship (a Docker image, a paper PDF, a docs site, a release tag)
- For research: CI matters every day; CD usually means publishing docs or tagged releases

## GitHub Actions Mechanics

### Slide 5: How GitHub Actions works
- A YAML file in `.github/workflows/` is read on every event
- GitHub spins up a runner (Ubuntu/macOS/Windows VM) and executes your steps
- Steps are shell commands or reusable **actions** from the Marketplace (`actions/checkout`, `actions/setup-python`, etc.)

### Slide 6: YAML anatomy
- Five required pieces: `name`, `on`, `jobs`, each job's `runs-on`, and `steps`
- Show one annotated workflow side-by-side with labels
- Indentation is significant -- spaces, not tabs

### Slide 7: Triggers -- controlling **when** a workflow fires
- `push` -- on every commit pushed (filter by branch or path)
- `pull_request` -- on PR open/sync (the most common research trigger)
- `schedule` -- cron, e.g. nightly tests
- `workflow_dispatch` -- manual button in the GitHub UI
- `paths:` filter -- only run when relevant files change (skip a 10-min build when only the README changed)

## Tooling: Why Modern Beats Classical

### Slide 8: Tools matter, especially in CI
- Same logic, faster feedback = more iterations per session
- Single-binary tools = fewer moving parts in CI = fewer config files in your repo
- We keep classical tools listed because **either chain works**; the point is to pick one and stick with it

### Slide 9: Python -- UV replaces pip, conda, venv
- Locked dependencies -> bit-identical environments across collaborators and CI
- 10-100x faster installs (matters when CI runs on every push)
- One binary, one `uv.lock`, no `requirements.txt` drift

### Slide 10: Python -- ruff + ty replace black, flake8, isort, mypy
- ruff: lint + format in one Rust binary, with `--fix --unsafe-fixes`
- ty: fast type checker (mypy-compatible logic, much faster)
- Result: one config block, sub-second feedback, identical behavior locally and in CI

### Slide 11: JS/TS -- Bun + Biome
- Bun: package manager + runtime + test runner in one (replaces npm, node, jest)
- Biome: linter + formatter (replaces ESLint + Prettier)
- Same story as Python: fewer tools, faster CI, less config rot

### Slide 12: Spelling -- typos vs cspell
- Both check code, comments, and docs for typos
- typos (Rust binary, single config file) is fast; cspell (Node) has richer dictionaries
- Either is fine; the point is **add it to CI** so your README stops drifting

## Pre-Commit and the Pipeline Shape

### Slide 13: The core message
- The chain you pick matters less than picking one and enforcing it
- Mixed chains (black + biome + npm + UV) double the surface area for drift
- Pick a chain per language; pin it in `pyproject.toml` / `package.json`; let CI enforce it

### Slide 14: Pre-commit hooks
- A pre-commit hook runs the linters on **staged files only** before each commit
- Catch issues in 200 ms locally instead of in 2 min on the CI runner
- Same tools (`ruff`, `biome`, `typos`) wired into `.pre-commit-config.yaml`

### Slide 15: Pipeline shape -- lint, type check, test, coverage
- A standard CI pipeline: install -> lint -> type check -> test -> coverage report
- Each stage is a check; failure stops the run
- Coverage report uploaded as a build artifact you can read in the PR

## MATLAB in CI

### Slide 16: matlab-actions/setup-matlab
- Official GitHub Action: installs MATLAB on the runner with a license-free CI mode
- Works on `ubuntu-latest`, `macos-latest`, `windows-latest`
- `matlab-actions/run-tests`, `run-command`, `run-build` for actually exercising MATLAB code

### Slide 17: Limits of MATLAB in CI
- MATLAB Engine for Python does **not** install on hosted runners (this is the matlab-mcp pain point)
- Toolbox availability varies by license; not every toolbox runs in CI mode
- macOS-arm64 runners only support recent MATLAB releases
- Self-hosted runners are the escape hatch (your own Mac or workstation)

### Slide 18: Strategy for matlab-mcp projects
- Run Python wrapper code (lint, type check, unit tests) on hosted runners -- fast and free
- Run MATLAB-driven analysis on a self-hosted runner or treat the MATLAB run as a manual step
- Don't gate the whole pipeline on MATLAB; let the cheap stuff run on every push

## Security and Bridge

### Slide 19: Security audits in CI
- `uv run pip-audit` for Python deps; `bun audit` for JS deps
- Secret scanning: GitHub's free secret scanning + a pre-commit hook (gitleaks, detect-secrets)
- Run on every PR; block merge on critical findings

### Slide 20: `/project:setup-ci` scaffolds all of this
- One command writes `.github/workflows/`, `.pre-commit-config.yaml`, and language config
- Generates the right templates from your repo's languages
- You get a green pipeline on your next push

### Slide 21: Walkthrough roadmap
- Open the practicum repo we built in Week 3
- `/project:setup-ci` -- generate workflows
- Walk through the YAML it produced (annotate live)
- Push and watch the pipeline run on GitHub
- Add a typo on purpose; watch the typo job catch it

## Final Handoff

### Slide 22: What today gives you / what's next
- Today: every push gets linted, type-checked, tested, scanned, and the run is recorded
- Next: Week 5 -- literature search with `opencite`, the first pure-research week

### Slide 23: What we have / what we do next
- **Have:** the practicum repo from Week 3, with epic + Phase 1 PR
- **Do next, live:** `/project:setup-ci` -> annotate the YAML -> push -> watch -> introduce a deliberate failure -> watch CI catch it
- "Questions? Ask while CI runs."

## Before Next Week

- Run `/project:setup-ci` on your own project
- Install the pre-commit hook (`uv tool install pre-commit && pre-commit install`)
- Push a commit and watch the workflow run
