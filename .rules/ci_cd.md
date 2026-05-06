# CI/CD Workflow Standards

## Current Pipelines

### Typo Check (`typos.yml`)
Runs on every push/PR. Catches spelling errors in all Markdown and text files.
Config: `.typos.toml` (custom overrides for technical terms).

## Adding New Workflows

### Triggers
- `on: [push, pull_request]` for quality gates
- `on: push: branches: [main]` for deploy/publish steps
- Always pin action versions: `actions/checkout@v4` (not `@master`)

### Pipeline Order (fail fast, cheap first)
1. Lint/typo check
2. Link validation (broken URLs)
3. Build (if applicable)
4. Deploy (main branch only)

## Markdown/Content Checks to Add

```yaml
# Example: broken link check
- name: Check links
  uses: lycheeverse/lychee-action@v1
  with:
    args: --verbose --no-progress '**/*.md'
```

## Key Practices
- Never commit secrets; use GitHub Secrets
- Deploy (osc-docs publish) only from protected main branch
- Document required environment setup in session READMEs

## Week 4 Reference
Week 4 of the course covers CI/CD in depth. Use this repo's workflows
as live examples during that session.

---
*Every workflow failure is a production bug prevented.*
