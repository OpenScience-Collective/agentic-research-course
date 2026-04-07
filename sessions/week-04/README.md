# Week 4: CI/CD and Code Quality

## Learning Objectives

By the end of this session, you will:
- Set up GitHub Actions for automated testing and linting
- Configure pre-commit hooks for code quality
- Understand coverage reporting and release automation
- Run security audits on your project
- Containerize a project with Docker

## Outline

### Part 1: Why CI/CD? (5 min)
- The problem: "it works on my machine"
- Automated testing on every push
- Catching issues before they reach main

### Part 2: GitHub Actions (15 min)
- Using `/setup-ci` to scaffold pipelines
- Python pipeline: Ruff + pytest + coverage
- TypeScript pipeline: Biome + bun test
- Typo checking with crate-ci/typos

### Part 3: Pre-commit Hooks (5 min)
- Auto-formatting on commit
- Ruff for Python, Biome for TypeScript
- Checking staged files only

### Part 4: Security and Docker (15 min)
- Dependency auditing: `uv run pip-audit`
- Credential scanning
- Docker packaging with multi-stage builds
- Using `/release-prep` for release automation

### Part 5: Live Demo (5 min)
- Add CI to our practicum project
- Watch it run on GitHub

### Q&A (15 min)

## Key Concepts

- **CI/CD:** Continuous Integration / Continuous Deployment
- **GitHub Actions:** Automated workflows triggered by git events
- **Pre-commit hooks:** Scripts that run before each commit
- **Coverage:** Percentage of code exercised by tests
- **Multi-stage build:** Docker pattern separating build and runtime environments

## Before Next Session

- Set up CI on your project with `/setup-ci`
- Install the pre-commit hook
- Run a security audit on your dependencies
