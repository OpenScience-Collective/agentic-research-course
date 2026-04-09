# Week 1 Presentation: Git, GitHub, and the Command Line

## Opening: The Landscape (8 min)

### Slide 1: Title
- Agentic Research Course
- Week 1: Git, GitHub, and the Command Line
- Open Science Collective

### Slide 2: What Changed
- AI coding agents exist now: Claude Code, Copilot, Cursor
- They read your project, write code, run commands, create PRs
- This is not autocomplete; this is an autonomous agent

### Slide 3: The Numbers
- [Show contributions graph: 1,052 to 8,563]
- 8x productivity increase from integrating Claude Code
- Not typing faster; working smarter with an agent that understands context

### Slide 4: The Course Map
- 10 sessions, each building on the last
- Practicum: HBN EEG analysis for movie shot changes
- Every session produces something real
- Companion: research-skills plugin (free, open source)

## Why QA and Version Control (5 min)

### Slide 5: The Power Problem
- AI generates code 10x faster
- Without guardrails, bugs accumulate 10x faster too
- "Move fast and break things" does not work in research

### Slide 6: Git is Your Safety Net
- Undo button: `git revert`
- Audit trail: `git log`, `git blame`
- Collaboration: branches, PRs, reviews
- Reproducibility: tag a commit, reproduce the result

## Terminal Basics (7 min)

### Slide 7: The Terminal
- Live demo: open terminal
- `pwd` -- where am I?
- `ls` -- what's here?
- `cd` -- go somewhere
- `mkdir` -- make a directory

### Slide 8: Installing Tools
- macOS: Homebrew (`brew install git`)
- Linux: apt (`sudo apt install git`)
- Windows: WSL recommended

## Git Fundamentals (10 min)

### Slide 9: The Three States
- Working directory -> Staging area -> Repository
- `git add` moves files to staging
- `git commit` saves a snapshot
- Diagram: working -> staged -> committed

### Slide 10: Live Demo
- `git init my-project`
- Create a file, `git add`, `git commit`
- `git log` to see history
- `git diff` to see changes

### Slide 11: Push and Pull
- `git remote add origin <url>`
- `git push` sends to GitHub
- `git pull` fetches updates
- Your local and remote stay in sync

## GitHub Workflow (10 min)

### Slide 12: Creating a Repository
- Live demo on github.com
- README, .gitignore, license

### Slide 13: Branches
- `git checkout -b feature-name`
- Work in isolation, merge when ready
- Diagram: main -> feature -> merge back

### Slide 14: Pull Requests
- A review checkpoint, even for solo work
- Title, description, linked issue
- This is where AI code review will happen (week 3+)

### Slide 15: Issues
- Track what needs to be done
- Link to branches and PRs
- The backbone of project management (week 3)

## Wrap-up (2 min)

### Slide 16: Before Next Week
- Create a GitHub repo, make 3 commits, push
- Install Claude Code
- Next week: we bring AI into the picture
