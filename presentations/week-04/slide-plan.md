# Week 4 Slide Plan

## Target: 23 slides, ~28 min presentation, then live walkthrough + Q&A

**Core message.** Week 3 built structure inside the repo. Week 4 wires that structure to a remote referee that runs on every push. CI is checks-and-balances at machine speed. Pair it with a deliberately chosen tool chain (UV, ruff, ty, Bun, Biome, typos) because in research, reproducibility starts with the toolchain that produced the result. Either modern or classical chain works -- the point is to pick one and let CI enforce it.

The tone matches Week 3: thesis up front, every theoretical point lands on the HBN practicum, every tool decision is justified by *why it helps research output*, not *why it's fashionable*.

## Slide Inventory

### Opening (3 min)

1. **Title** -- "Week 4: CI/CD and Code Quality." Author, course link, Discord link.
2. **Where we are** -- Week 1 git, Week 2 Claude Code, Week 3 epic + sub-issues + worktrees + plan + review. Today: automated checks **outside** the repo, on every push.

### Why CI/CD (3 min)

3. **The problem CI/CD solves** -- Three failure modes: "works on my machine"; agent breaks an unrelated module and nobody notices; manual checking does not scale under deadline. One callout: research output is only as reproducible as the pipeline that produced it.
4. **CI vs CD plainly** -- Two short definitions on one slide. CI = every push runs lint/type/test; broken `main` becomes mechanically impossible. CD = every passing build can ship (Docker image, paper PDF, docs site, release). For research, CI matters daily; CD usually means publishing docs or tagging releases.

### GitHub Actions Mechanics (6 min)

5. **How GitHub Actions works** -- Diagram: event -> runner (Ubuntu/macOS/Windows VM) -> jobs -> steps. Steps are shell commands or reusable actions from the Marketplace. Make this slide visual; the diagram does the teaching.
6. **YAML anatomy** -- Annotated workflow file. Five required pieces labelled with arrows: `name`, `on`, `jobs`, `runs-on`, `steps`. Sidebar gotcha: indentation is significant, spaces only.
7. **Triggers -- controlling when CI fires** -- Five trigger types as a matrix: `push`, `pull_request`, `schedule` (cron), `workflow_dispatch` (manual button), and the `paths:` filter. Mention: skip a 10-min build when only the README changed.

### Tooling: Why Modern Beats Classical (7 min)

8. **Tools matter, especially in CI** -- Transition slide. Same logic, faster feedback = more iterations per session. Single-binary tools = fewer moving parts in CI. *Both modern and classical chains work; pick one and stick with it.*
9. **Python: UV replaces pip, conda, venv** -- Three benefits: locked deps -> bit-identical envs; 10-100x faster installs (matters per push); one binary, one `uv.lock`, no `requirements.txt` drift. One callout aimed at researchers: lockfiles solve "but it ran on my laptop in 2024."
10. **Python: ruff + ty replace black, flake8, isort, mypy** -- ruff: lint + format in one Rust binary. ty: fast type checker. Result: one config block, sub-second feedback, identical behavior locally and in CI. Show the `pyproject.toml` snippet.
11. **JS/TS: Bun + Biome** -- Bun: package manager + runtime + test runner in one. Biome: lint + format. Same story as Python; fewer tools, faster CI, less config rot.
12. **Spelling: typos vs cspell** -- Both check code, comments, docs. typos (Rust, single config) is fast; cspell (Node) has richer dictionaries. Either is fine. The point: add a typo job to CI so your README stops drifting. Tie to Week 1's recent commit landing typo CI.

### Pre-Commit and Pipeline Shape (4 min)

13. **The core message** -- Single-slide summary of slides 9-12. The chain you pick matters less than picking one and enforcing it. Mixed chains (black + biome + npm + UV) double the surface area for drift. Pick per-language; pin it; let CI enforce it.
14. **Pre-commit hooks** -- A pre-commit hook runs the linters on **staged files only** before each commit. Catch issues in 200 ms locally instead of 2 min on the CI runner. Wire the same tools into `.pre-commit-config.yaml`. One install line: `uv tool install pre-commit && pre-commit install`.
15. **Pipeline shape -- lint, type, test, coverage** -- Horizontal flow of stages. Each stage is a check; failure stops the run. Coverage report uploaded as a build artifact readable from the PR.

### MATLAB in CI (4 min)

16. **matlab-actions/setup-matlab** -- The official GitHub Action. License-free CI mode. Works on Ubuntu/macOS/Windows runners. Companion actions: `run-tests`, `run-command`, `run-build`. This is how MATLAB research code joins the same CI pipeline as your Python.
17. **Limits of MATLAB in CI** -- The matlab-mcp pain point: MATLAB Engine for Python does not install on hosted runners. Other limits: toolbox availability varies, macOS-arm64 only supports recent MATLAB releases, build minutes are precious. Self-hosted runners (your own Mac or workstation) are the escape hatch.
18. **Strategy for matlab-mcp projects** -- Split the pipeline. Python wrapper code (lint, type, unit tests) runs on hosted runners (fast, free, every push). MATLAB analysis runs on a self-hosted runner or as a manual step. Do not gate the cheap stuff on the expensive MATLAB job.

### Security and Bridge (4 min)

19. **Security audits in CI** -- `uv run pip-audit` for Python deps, `bun audit` for JS. GitHub's free secret scanning + a pre-commit hook (gitleaks). Run on every PR, block merge on critical findings. Use sparingly so it does not become the boy who cried wolf.
20. **`/project:setup-ci` scaffolds all of this** -- One command writes `.github/workflows/`, `.pre-commit-config.yaml`, and language config. Templates picked from your repo's languages. Green pipeline on next push.
21. **Walkthrough roadmap** -- Open the practicum repo from Week 3. `/project:setup-ci`. Annotate the produced YAML live. Push. Watch the pipeline. Add a deliberate typo. Watch the typo job catch it.

### Final Handoff (1 min)

22. **What today gives you / what's next** -- Today: every push linted, typed, tested, scanned, recorded. Next: Week 5 literature search with `opencite`. First pure-research week of the course.
23. **What we have / what we do next** -- Two columns.
    - **Have:** Week 3 practicum repo with epic + Phase 1 PR.
    - **Do next, live:** `/project:setup-ci` -> annotate YAML -> push -> watch -> add a typo -> watch CI catch it.
    - Bottom line: "Questions? Ask while CI runs."

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 3 min |
| Why CI/CD | 2 | 3 min |
| GitHub Actions mechanics | 3 | 6 min |
| Tooling rationale | 5 | 7 min |
| Pre-commit + pipeline | 3 | 4 min |
| MATLAB in CI | 3 | 4 min |
| Security + bridge + close | 5 | 4 min |
| **Total** | **23** | **31 min** |

Live walkthrough + Q&A fill the remaining 14 min.

## Assets Needed (produce via `/scientific-figures:scientific-figures` skill)

- `week-04/ci-loop.svg` -- slide 3 or 5. Code -> push -> runner runs lint/test/build -> green or red -> merge. Loop with the agent on the left feeding the cycle.
- `week-04/yaml-anatomy.svg` -- slide 6. A real YAML block with arrows to five labels: `name`, `on`, `jobs`, `runs-on`, `steps`. The single most informative slide of the deck.
- `week-04/triggers.svg` -- slide 7. Five trigger types as labelled icons: push commit, PR arrow, clock (schedule), play button (workflow_dispatch), filter funnel (paths).
- `week-04/tooling-old-vs-new.svg` -- slide 8 or 13. Two stacks side by side: old (pip + venv + black + flake8 + isort + mypy + npm + jest + eslint + prettier) vs new (UV + ruff + ty + Bun + Biome + typos). Visual count: many vs few.
- `week-04/uv-speed.svg` -- slide 9. Bar chart: pip vs UV install times. Numbers from UV docs (cite in speaker notes).
- `week-04/pre-commit-flow.svg` -- slide 14. Staged files -> pre-commit hook -> pass = commit, fail = fix and re-stage.
- `week-04/pipeline-stages.svg` -- slide 15. Horizontal arrow with labelled stops: install -> lint -> type -> test -> coverage. Green check at end.
- `week-04/matlab-ci.svg` -- slide 17. GitHub runner box with a MATLAB icon installed inside (green check) and a Python-engine icon crossed out (red X). Self-hosted-runner box on the right as the escape hatch.
- `week-04/security-shield.svg` -- slide 19. A shield over a dependency tree. Optional; keep simple.
- `week-04/setup-ci-tree.svg` -- slide 20. Folder tree showing what `/project:setup-ci` produces (`.github/workflows/python.yml`, `.pre-commit-config.yaml`, `pyproject.toml` snippet).

Reuse from `assets/icons/`: `github-workflow.svg` (slide 5 if it fits), `terminal.svg` (slide 14 or 21).

No mermaid. Hand-crafted SVGs only. Delegate to `/scientific-figures:scientific-figures`.

## Screenshots Needed

- `week-04/screenshots/ci-pr-checks.png` -- a passing PR's check list on GitHub (slide 15 or 21)
- `week-04/screenshots/ci-failed-typo.png` -- a failed typo run highlighting the misspelled word (slide 12 or 21)
- `week-04/screenshots/coverage-report.png` -- coverage HTML report or the codecov badge (slide 15)

If we cannot capture a custom screenshot before the session, fall back to clean SVG mocks.

## Speaker-Note Themes

- Slide 3 frames the pain. Tell the war story; people remember stories, not lists.
- Slide 6 is the most informative slide. Read each label aloud. Pause on `on:` -- it controls **when** CI fires, which is the single most-asked question from new users.
- Slide 8 frames the tooling bloc. Establish: *both chains work, pick one*. This stops the inevitable "but I use pip and it's fine" objection.
- Slide 9 is where researchers feel the value: lockfiles solve "ran on my laptop in 2024." Land that line.
- Slide 12 is where the cspell-vs-typos question dies in 30 seconds. Either is fine; CI presence matters.
- Slide 13 is the philosophical anchor. Land it with conviction so slides 14-15 feel like execution, not opinion.
- Slide 17 is the boomerang for MATLAB users in the audience. Be honest about the limit, give them the self-hosted-runner workaround, move on. Do not dwell.
- Slide 21 is the bridge. The walkthrough starts the moment it goes up.
