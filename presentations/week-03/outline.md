# Week 3 Presentation: Project Management with AI

## Opening: Recap (3 min)

### Slide 1: Title
- Week 3: Project Management with AI

### Slide 2: Where We Are
- Week 1: Git (safety net)
- Week 2: Claude Code (the agent)
- Today: How to organize real work

## Project Initialization (5 min)

### Slide 3: The `/init-project` Scaffold
- CLAUDE.md -- AI instructions
- .rules/ -- development standards (git, docs, review, testing)
- .context/ -- project state (plan, ideas, research, scratch_history)
- One command sets up the whole structure

### Slide 4: Why Structure Matters
- A single script: just commit and push
- A multi-step pipeline: you need phases, tracking, review
- AI can generate code fast; structure ensures correctness

## Epic/Sprint Workflow (12 min)

### Slide 5: What is an Epic?
- A large feature broken into phases
- Each phase is independently completable, reviewable, mergeable
- Example: "Analyze HBN EEG data" is an epic with 6 phases

### Slide 6: The HBN Epic
```
Epic: HBN Movie Shot-Change ERP Analysis
├── Phase 1: Data import and BIDS structure
├── Phase 2: Preprocessing
├── Phase 3: ICA decomposition
├── Phase 4: Epoch extraction
├── Phase 5: Statistical analysis
└── Phase 6: Figures and manuscript sections
```

### Slide 7: GitHub Issues Structure
- Parent issue: the epic (describes the goal, lists phases)
- Sub-issues: one per phase (linked with `gh sub-issue add`)
- Each sub-issue becomes a branch, a worktree, a PR

### Slide 8: Live Demo -- Creating the Epic
- `gh issue create --title "Epic: HBN Shot-Change Analysis"`
- Create sub-issues for each phase
- Link them: `gh sub-issue add <parent> --sub-issue-number <child>`

## Git Worktrees (5 min)

### Slide 9: What is a Worktree?
- Multiple branches checked out simultaneously in separate directories
- No more stashing, no more switching
- Develop Phase 2 while Phase 1 is in review

### Slide 10: Live Demo -- Worktrees
```bash
git worktree add ../epic-hbn -b feature/epic-hbn develop
git worktree add ../hbn-phase1 -b feature/phase1-import feature/epic-hbn
cd ../hbn-phase1
```

## Plan Mode and Implementation (10 min)

### Slide 11: Planning Before Coding
- `/plan` enters plan mode
- Claude proposes: files to create, functions to write, data flow
- You review, adjust, approve
- Then Claude implements the approved plan

### Slide 12: Live Demo -- Phase 1
- Enter plan mode for "Data import and BIDS structure"
- Review the plan
- Approve and watch Claude implement
- Commit the result

## PR Workflow (5 min)

### Slide 13: Creating the PR
- `gh pr create` with title, description, issue reference
- Run `/review-pr` for automated review
- Six specialized agents check different aspects

### Slide 14: No Technical Debt
- Address ALL findings, not just critical
- Only skip genuine false positives
- If you skip something, explain why
- This discipline is what makes AI-assisted development trustworthy

## Wrap-up (2 min)

### Slide 15: The Full Workflow
1. Create epic issue with phases
2. Create worktrees
3. Plan each phase with `/plan`
4. Implement, commit, PR
5. Review with `/review-pr`
6. Merge phase to epic branch
7. When all phases done: epic PR to main

### Slide 16: Before Next Week
- Try the epic workflow on your project
- Practice: branch, commit, PR, review, merge
- Next week: CI/CD and automated code quality
