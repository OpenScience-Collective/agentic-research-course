# Week 4 Guide: CI/CD and Code Quality

*How to wire automated checks to every push so the agent cannot ship breakage. Covers GitHub Actions mechanics, YAML anatomy, workflow triggers, the modern Python and JavaScript toolchains (UV, ruff, ty, Bun, Biome, typos), pre-commit hooks, MATLAB in CI, and security audits, ending in `/project:setup-ci`.*

This guide accompanies [Week 4](../sessions/week-04/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). Week 3 built structure inside the repo: epic, sub-issues, worktrees, plan mode, and pull request (PR) review. Week 4 puts a remote referee in front of every push. Continuous Integration / Continuous Deployment (CI/CD) is checks-and-balances at machine speed. Pair it with a deliberately chosen toolchain because in research, reproducibility starts with the toolchain that produced the result.

The walkthrough at the end of this guide adds a CI pipeline to the Healthy Brain Network (HBN) practicum from Week 3 and watches the pipeline catch a deliberate typo and a deliberate type error.

---

## Why CI/CD Matters for Research

There are three failure modes CI/CD prevents.

**"Works on my machine."** Different operating system, different Python version, different MATLAB toolbox license, different conda channel ordering. Code that runs cleanly on your laptop fails on a collaborator's laptop, on the cluster, on the reviewer's laptop two years later. CI gives you one canonical environment that runs every push, recorded forever, identical for everyone.

**Silent breakage.** The agent writes a lot of code. Some of it touches modules you have not looked at in weeks. Without automated tests on every push, a subtle regression in shot-event parsing might land at 2 PM and only surface during peer review three months later. CI is the rope that catches the agent before the fall.

**Manual checking does not scale.** Under deadline, humans skip steps. A linter on every push is not optional discipline; it is a property of the system. If you have to remember to run it, eventually you will not.

Underlying all three: research output is only as reproducible as the pipeline that produced it. Your figure is downstream of code, code is downstream of an environment, and the environment is downstream of a tool chain. CI is where that chain becomes auditable.

---

## CI vs CD, Plainly

Two terms, often conflated.

**Continuous Integration (CI)** runs lint, type checks, and tests on every push. Every PR has a green or red badge before a human reviews it. Broken `main` becomes mechanically impossible because no failing build can merge.

**Continuous Deployment (CD)** is what happens after CI passes. Every successful build can be shipped automatically: a Docker image pushed to a registry, a documentation site rebuilt, a paper PDF regenerated, a release tag cut, a package published.

For research, CI is the part you use every day. CD usually means publishing documentation or tagging release versions of analysis pipelines. The bulk of value is on the CI side; that is where this guide spends its time.

---

## How GitHub Actions Works

GitHub Actions is the CI/CD system built into GitHub. It is not the only one (GitLab CI, CircleCI, Jenkins, and others all work), but it is free for public repositories, has the best research-tool ecosystem, and integrates with the same UI you already use for issues and PRs.

The mental model: a YAML file in `.github/workflows/` is read by GitHub on every event. When the event matches one of your triggers, GitHub spins up a fresh virtual machine (a **runner**) with the operating system you requested, executes your steps top to bottom, captures logs and artifacts, and reports pass or fail back to the PR.

Three things to know about runners as of April 2026:

- `ubuntu-latest` is Ubuntu 24.04
- `macos-latest` is macOS 15 (Apple Silicon, ARM64)
- `windows-latest` is Windows Server 2025

The macOS runner flipping to Apple Silicon is the most common 2025 footgun for research code. If your project depends on x86_64 (some MATLAB releases, some MEX files, some legacy MathWorks toolboxes), pin to `macos-13` explicitly.

A minimal Python workflow looks like this:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: astral-sh/setup-uv@v4
      - run: uv sync
      - run: uv run ruff check .
      - run: uv run pytest
```

That is the shape every workflow follows: install dependencies, run checks, run tests. The `uses:` lines pull reusable **actions** from the GitHub Marketplace; the `run:` lines are shell commands. Indentation is significant and uses spaces only; tabs are not allowed.

---

## YAML Anatomy: Five Parts to Know

Every workflow has five pieces:

- **`name`** -- what shows up in the GitHub UI when the workflow runs.
- **`on`** -- which events fire the workflow (push, pull_request, schedule, manual). This is the most-misunderstood field; the next section unpacks it.
- **`jobs`** -- one or more parallel jobs. Each job gets its own runner and runs in isolation.
- **`runs-on`** -- the operating system the job runs on. `ubuntu-latest` is the default for research.
- **`steps`** -- the actual commands or marketplace actions, executed top to bottom.

A misplaced two-space indent is the number-one reason new workflows fail. If your workflow does not run, suspect indentation before anything else; the GitHub web editor highlights YAML errors but a copy-paste from a blog post often does not.

---

## Triggers: Controlling When CI Fires

The `on:` field is the lever that decides when GitHub burns runner minutes. There are five trigger types worth knowing.

```yaml
on:
  push:
    branches: [main]
    paths:
      - 'src/**'
      - 'pyproject.toml'
  pull_request:
  schedule:
    - cron: '0 6 * * *'   # 06:00 UTC daily
  workflow_dispatch:        # manual button in UI
```

- **`push`** fires on every commit pushed to a branch matching the filter. Most workflows use this for `main` and feature branches.
- **`pull_request`** fires when a PR opens or receives new commits. This is where most CI value lives because it gates merging.
- **`schedule`** uses cron syntax to run periodically. Useful for nightly tests, weekly dependency audits, or scheduled data refresh jobs.
- **`workflow_dispatch`** adds a manual "Run workflow" button to the GitHub UI. Handy for re-running flaky jobs or kicking off long pipelines on demand.
- **`paths:`** filters skip a workflow when only irrelevant files changed. Researchers iterate on README and notebook outputs constantly; you do not want a 10-minute build to run on every documentation typo. Add `paths:` to every workflow that touches code.

For the HBN practicum we run lint and unit tests on every PR; the slow MATLAB job runs only on `workflow_dispatch` and on commits to `main`. That keeps fast feedback fast.

---

## Why Tooling Matters in CI

Same logic, faster feedback, more iterations per session. Single-binary tools mean fewer moving parts in CI and fewer config files in the repo. Lockfiles mean bit-identical environments across collaborators and CI runners.

Both classical and modern toolchains work. The point is to pick one and stick with it. Mixed chains (some pip, some UV, some black, some ruff, some npm, some Bun) double the surface area for drift. The next sections explain why we recommend the modern chain.

### Python: UV Replaces pip, conda, venv

[UV](https://github.com/astral-sh/uv) is a Rust-based Python package manager from Astral. It manages interpreters, virtual environments, and dependencies in a single binary. As of April 2026, UV is at version 0.11.8 and is roughly 8 times faster than pip on a cold install of a typical research environment, and up to ~100 times faster with a warm cache.

Three reasons it matters for research:

- **Locked dependencies.** `uv.lock` pins every transitive package. The same lockfile produces the same environment on your laptop, on a collaborator's machine, on the CI runner, and on a reviewer's machine two years from now. This is the technical answer to "but it ran on my laptop in 2024."
- **Speed.** CI runs a fresh install on every push. The difference between a 60-second `pip install -r requirements.txt` and a 6-second `uv sync` shows up in your iteration cadence.
- **Single binary.** UV replaces pip, venv, pyenv, pip-tools, and often conda. One install, one config block in `pyproject.toml`, one lockfile.

For research projects you will use these UV commands daily:

```bash
uv init                       # scaffold a new project
uv add numpy mne pybids       # add a dependency, lock it
uv sync                       # install/update environment from lockfile
uv run pytest                 # run a command in the project env
uv tool install pre-commit    # install a CLI tool isolated from your env
```

### Python: ruff + ty Replace Black, Flake8, isort, mypy

[ruff](https://github.com/astral-sh/ruff) is a single Rust binary that does both linting and formatting. As of v0.15 it covers ~700 rules from flake8, pyflakes, pycodestyle, isort, pyupgrade, and a dozen smaller tools. Same rules, sub-second feedback, identical behavior locally and in CI.

[ty](https://github.com/astral-sh/ty) is Astral's type checker. Mypy-compatible logic, dramatically faster. As of April 2026 ty is still in beta (v0.0.x); breaking changes are possible before 1.0, but for daily research use it is stable. If you want a 1.0-stable type checker right now, mypy is fine.

A typical Python research project's `pyproject.toml` only needs one config block:

```toml
[tool.ruff]
line-length = 100
target-version = "py312"

[tool.ruff.lint]
select = ["E", "F", "I", "UP", "B"]
fix = true

[tool.ty]
respect-ignore-files = true
```

`ruff check --fix --unsafe-fixes` autofixes most lint issues. The `--unsafe-fixes` flag is misnamed; it actually applies fixes that change behavior in narrow cases (e.g., upgrading deprecated APIs to current ones). Read the diff before committing.

### JavaScript / TypeScript: Bun + Biome

If you only write Python you can skim this section, but most research projects touch JS or TS indirectly through Jupyter extensions, web visualizations, and documentation tooling.

[Bun](https://bun.sh) is a JavaScript runtime, package manager, and test runner in one binary. It is roughly 30 times faster than npm at installs and starts 3 times faster than Node. As of April 2026, Bun is at 1.3.x and is production-ready.

[Biome](https://biomejs.dev) is a linter and formatter for JS, TS, JSX, JSON, CSS, and GraphQL. It is the community fork of Rome (which was abandoned in 2023). Biome 2.4.x covers 450+ rules from ESLint and typescript-eslint, plus 97% Prettier-compatible formatting. Same single-binary story as ruff.

A `biome.json` in your repo is the only config you need:

```json
{
  "$schema": "https://biomejs.dev/schemas/2.4/schema.json",
  "linter": {
    "enabled": true,
    "rules": { "recommended": true }
  },
  "formatter": {
    "enabled": true,
    "indentStyle": "space",
    "lineWidth": 100
  }
}
```

### Spell-check: typos vs cspell

Both [typos](https://github.com/crate-ci/typos) (a Rust binary) and [cspell](https://cspell.org) (Node.js, with rich language packs) check code, comments, and documentation for typos. typos wins on speed and simplicity for small-to-medium repos; cspell wins when you need rich per-language dictionaries (medical terminology, legal jargon, multilingual documentation).

Either works. The actionable point is the same: add a typo job to your CI so your README stops drifting. The course companion repository uses typos; the workflow is six lines:

```yaml
name: typos
on: [push, pull_request]
jobs:
  typos:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: crate-ci/typos@v1
```

---

## The Core Message of the Tooling Block

Pick one chain per language. Pin the versions in `pyproject.toml` or `package.json`. Let CI enforce them.

Mixed chains rot. Some collaborators format with black, some with ruff format. The diffs from re-formatting random files become a constant background noise in PRs. The cure is to delete the alternatives from your dev dependencies the day you adopt the modern chain.

The chain you pick matters less than picking one. Both classical and modern chains produce correct results; modern chains save research time per push and per CI run, and cut the number of config files in the repo.

---

## Pre-Commit Hooks: 200 ms Feedback Locally

A pre-commit hook runs your linters on **staged files only** before each commit. Catch issues in 200 milliseconds locally instead of in 2 minutes on the CI runner.

Install once:

```bash
uv tool install pre-commit
pre-commit install
```

Configure with `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.15.12
    hooks:
      - id: ruff-check
        args: [--fix]
      - id: ruff-format
  - repo: https://github.com/crate-ci/typos
    rev: v1.45.2
    hooks:
      - id: typos
```

The same tools your CI runs are also running on your local commits. Commits that would fail CI fail locally first.

One footgun: if a hook auto-fixes a file, the commit fails because the working tree changed. Run `git add` again and re-commit. This trips up first-timers; warn collaborators when you turn it on.

---

## Pipeline Shape: Lint, Type, Test, Coverage

A standard CI pipeline has the same shape across languages:

```
install -> lint -> type check -> test -> coverage report
```

Each stage is a check; failure stops the run and blocks the PR from merging. The coverage report uploads as a build artifact readable from the PR.

The same shape applies to Python (`uv sync` -> `ruff check` -> `ty` -> `uv run pytest --cov`), JS/TS (`bun install` -> `biome check` -> `tsc` -> `bun test --coverage`), R, Julia, and even MATLAB. Tools change; topology does not.

When you switch languages on a multi-language project, you keep the shape and swap the tools. That is part of why investing in *one* well-engineered chain per language is leverage: the second language costs less than the first.

---

## MATLAB in CI

The HBN practicum runs in MATLAB through EEGLAB and the matlab-mcp tool. CI for MATLAB has historically been awkward (license servers, paid runners), but the official `matlab-actions/setup-matlab` action makes the cheap path possible.

### `matlab-actions/setup-matlab`

The official MathWorks-maintained action installs MATLAB on a GitHub-hosted runner with a license-free CI mode for public repositories. As of April 2026 the action is at v3.0.1 and supports MATLAB R2021a or later on Ubuntu, macOS, and Windows runners. Companion actions:

- `matlab-actions/run-tests` runs MATLAB unit tests
- `matlab-actions/run-command` runs an arbitrary MATLAB command
- `matlab-actions/run-build` runs an MBT build target

A minimal MATLAB job looks like this:

```yaml
jobs:
  matlab-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: matlab-actions/setup-matlab@v3
        with:
          release: R2024b
          products: >
            Signal_Processing_Toolbox
            Statistics_and_Machine_Learning_Toolbox
      - uses: matlab-actions/run-tests@v3
```

License-free CI works for public repositories. Private repositories need a batch licensing token (`MLM_LICENSE_TOKEN` secret) from MathWorks; ask your local MathWorks license administrator if you do not already have one.

### The Limits

There are three limits worth knowing.

**MATLAB Engine for Python is blocked under license-free CI.** This is the matlab-mcp pain point. From the official `matlab-actions/setup-matlab` README:

> Public project and MATLAB batch licensing do not support external language interfaces, including MATLAB Engine APIs for Python, Java, .NET, COM, C, C++, and Fortran.

That means matlab-mcp itself, which uses the Python Engine to drive MATLAB from Claude Code, cannot run on a hosted CI runner. Workaround below.

**Toolbox availability is restricted in CI mode.** Most MathWorks toolboxes work, but transformation products (MATLAB Coder, MATLAB Compiler, Simulink Coder) are excluded. If your analysis depends on one of those, you need a private license, not the free CI mode.

**Apple Silicon support depends on MATLAB release.** R2023b and later run on `macos-14`+ runners; older releases need `macos-13` (x86). Consult [the MathWorks support page](https://www.mathworks.com/support/requirements/apple-silicon.html) for the current matrix; the support landscape moves with each MATLAB release.

### Strategy for matlab-mcp Projects

The clean answer is to split the pipeline.

- **Hosted runner:** lint, type-check, and unit-test the Python wrapper code. Fast, free, runs on every push.
- **Self-hosted runner:** your own Mac or lab workstation, registered to GitHub, runs the MATLAB analysis with your full license and any toolboxes you own.
- **Or:** trigger the MATLAB job manually with `workflow_dispatch` instead of every push, so it runs on intent rather than reflex.

Do not gate the cheap Python checks on the expensive MATLAB job. They are independent; let CI report them as such.

For the HBN practicum specifically: Phase 1-4 (event-table validators, Python wrappers around MATLAB calls) run on hosted runners every PR. Phase 5-6 (ERSP precompute, group statistics) run on a self-hosted Mac when triggered. The setup time for a self-hosted runner is one shell script and a service registration; once it is running, GitHub treats it like any other runner.

Security note: only register self-hosted runners on **private** repositories. Public repos can be forked, and a fork PR can run untrusted code on whichever runner is matched. Self-hosted + public is a remote-code-execution invitation.

---

## Security Audits in CI

Three quick wins:

- **Dependency audits.** `uv run pip-audit` for Python, `bun audit` for JavaScript. Run on every PR; block merge on critical findings.
- **Secret scanning.** GitHub provides free secret scanning for public repositories that catches the well-known patterns (AWS keys, GitHub tokens). For academic API keys (Synapse, OpenNeuro, NEMAR), add `gitleaks` as a pre-commit hook.
- **Pin actions by SHA, not by tag.** When you write `uses: actions/checkout@v4`, you are trusting whoever controls the `v4` tag. The 2024 `tj-actions/changed-files` supply-chain compromise affected approximately 23,000 repositories that were tag-pinned. SHA-pinning would have prevented it. Dependabot updates SHAs automatically; the cost is paranoia, the benefit is one less attack surface.

Use these sparingly. A noisy security scanner becomes the boy who cried wolf. Configure thresholds, review findings, do not just bury them.

---

## `/project:setup-ci` Scaffolds All of This

The course companion plugin includes `/project:setup-ci`. One command writes:

```
my-research/
+-- .github/workflows/
|     +-- ci.yml             # lint + type + test on push/PR
|     +-- typos.yml          # spell-check job
|     L-- release.yml        # tag, build, publish
+-- .pre-commit-config.yaml  # ruff + biome + typos hooks
+-- pyproject.toml           # ruff + ty + pytest config
L-- biome.json               # if the repo has JS/TS
```

The scaffold is opinionated, not rigid. Most researchers leave 90% of the generated config and tweak one or two thresholds. Customize after the green pipeline lands; do not let configuration bikeshedding block the first run.

This pairs with `/project:init-project` from Week 3. Init scaffolds *inside* the repo (CLAUDE.md, .rules, .context). Setup-ci scaffolds the *outside* referee (.github/workflows). Same architecture, different scope.

---

## Live Walkthrough

The Week 4 session ends with a live walkthrough on the practicum from Week 3.

1. Open the practicum repository (the one with the HBN epic and Phase 1 PR open).
2. Run `/project:setup-ci` from inside Claude Code.
3. Walk through the produced YAML, annotating the five parts (`name`, `on`, `jobs`, `runs-on`, `steps`).
4. Commit and push:

```bash
git add .github .pre-commit-config.yaml pyproject.toml
git commit -m "add CI"
git push
gh run watch     # streams the run in your terminal
```

5. Introduce a deliberate typo in the README. Watch the typo job fail.
6. Introduce a deliberate type error in a Python wrapper. Watch ty fail.
7. Fix both. Push. Watch the pipeline turn green and the Phase 1 PR become mergeable.

The most useful moment of the walkthrough is the failing run with a clear error. A red CI run is more reassuring for a first-time CI user than ten passing runs because it proves the system actually catches things.

---

## Before Next Week

- Run `/project:setup-ci` on one of your own projects.
- Install pre-commit (`uv tool install pre-commit && pre-commit install`).
- Push a deliberately broken commit. Watch CI catch it.
- If you work in MATLAB: try `matlab-actions/setup-matlab` on a small public repo and confirm the license-free path works for your toolbox set.

Week 5 is the first pure-research week of the course: literature search with the `opencite` skill, the foundation for grant writing (Week 6) and manuscript preparation (Week 7). The engineering scaffolding fades into the background; CI keeps running on every push regardless.
