# Git & Version Control Standards

## Commit Messages
- **Format:** `<type>: <description>`
- **Length:** <50 characters
- **No emojis** in commits or PR titles
- **No AI attribution** (no "Co-Authored-By: Claude" or similar)
- **Types:**
  - `feat:` New feature or session content
  - `fix:` Bug fix or content correction
  - `docs:` Documentation or README updates
  - `refactor:` Restructuring existing content
  - `chore:` Maintenance tasks

## Branch Strategy
- **Feature branches:** `feature/issue-N-short-description`
- **Session content:** `feature/issue-N-week-NN-topic`
- **Use `gh issue develop`** to create branches from issues
- **Delete after merge**

## Commit Practice
- **Atomic commits** -- one logical change per commit
- **No broken commits** -- each commit should leave the repo in a valid state

## Pull Request Process
1. Create issue first (for significant changes)
2. Use `gh issue develop` to create branch
3. Make atomic commits
4. Create PR with `gh pr create`
5. Run `/review-pr` and address ALL findings
6. Merge when CI is green

---
*Atomic commits, clear messages, clean history. No emojis, no AI attribution.*
