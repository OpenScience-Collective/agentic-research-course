# Week 1 Setup Guide: Git, GitHub, and the Command Line

*A step-by-step walkthrough for getting your research computing environment ready.*

This guide accompanies [Week 1](../sessions/week-01/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). By the end, you will have a working terminal, git installed, a GitHub account, your first repository pushed to the cloud, and a feel for the issue to branch to pull request to merge loop that the rest of the course is built on.

No prior coding experience is assumed.

---

## Why This Course Starts Here

The rest of this course is about artificial intelligence (AI) coding agents: tools like Claude Code, GitHub Copilot, and Cursor that do not just autocomplete your code, but plan work, write code across many files, run commands, and open pull requests on their own. They are legitimately useful for research. They also change the risk profile of your work.

### What changed

Five years ago, "AI in coding" meant a chat window next to your editor that could draft a function if you asked nicely. That was a marginal productivity boost. It did not change how research code gets written.

Today, an AI coding agent reads your entire repository, understands your conventions, runs your build, reads the error output, and keeps iterating until tests pass. A typical 30-minute task with Claude Code might produce a commit across six files, a new pull request, and a passing test run, without your involvement beyond the first prompt. That is a different category of tool. It is also a different category of risk.

### The power problem

AI generates code an order of magnitude faster than a human does. Without discipline around reviewing, testing, and version control, it also produces bugs an order of magnitude faster. In research this matters more than in most contexts, because a silent bug in a preprocessing pipeline can be three years of results before anyone notices. "Move fast and break things" works for a social network. It does not work for a paper you are about to submit.

The core message of this course is counterintuitive at first: the more powerful your coding tools get, the more you need quality assurance (QA), version control, and structured workflows. Not less. The tool writes the code; the process protects the results.

### Git as a safety net

Everything later in this course (agents, plugins, continuous integration, automated review) is built on top of git. Git gives you:

- **An undo button.** Any commit can be reverted. You can always get back to the state that worked yesterday.
- **An audit trail.** `git log` and `git blame` answer "who wrote this and why" for every line of code, including the lines the AI wrote.
- **A review checkpoint.** Pull requests force a look at the diff before it lands in the main branch. This is where human judgment meets AI output.
- **Reproducibility.** Tag a commit; anyone, including you three years from now, can reproduce the state that produced a figure in your paper.

None of those benefits are new with AI. They became load-bearing with AI.

Week 1 is about installing git and GitHub so that Week 2 can bring in Claude Code on top of a foundation that catches its mistakes. The setup in this guide is one-time. The workflow it enables is what you will use for the next ten weeks, and for every research project after that:

```
Issue  ->  Branch  ->  Commits  ->  Pull Request  ->  Review  ->  Merge  ->  Pull main
```

You will run this loop end to end in section 9.

---

## 1. Open Your Terminal

Every operating system has a built-in terminal. This is where you type commands instead of clicking buttons.

**macOS:**

- Open Spotlight (Cmd + Space), type `Terminal`, press Enter
- Or find it in Applications > Utilities > Terminal

**Linux:**

- Press Ctrl + Alt + T (most distributions)
- Or search for "Terminal" in your application launcher

**Windows:**

- Install [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install)
- Open PowerShell as Administrator and run:

```powershell
wsl --install
```

- Restart your computer, then open "Ubuntu" from the Start menu
- WSL gives you a full Linux terminal inside Windows

Once your terminal is open, try these commands to make sure it works:

```bash
# Where am I?
pwd

# What files are here?
ls

# List with details
ls -la
```

---

## 2. Install a Package Manager

Package managers let you install software from the command line. Think of them as an app store for developer tools.

### macOS: Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

The installer prints a "Next steps" section at the end. On Apple Silicon Macs, that includes adding Homebrew to your shell's `PATH`. Run exactly what the installer tells you (the path differs on Intel and Apple Silicon), which usually looks like:

```bash
# Apple Silicon
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Intel
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

Verify:

```bash
brew --version
```

### Linux (Debian/Ubuntu)

You already have `apt`. Update it:

```bash
sudo apt update
```

### Windows (WSL)

WSL uses Ubuntu's `apt` by default:

```bash
sudo apt update
```

---

## 3. Install Git and the GitHub CLI

You need two command-line tools: `git` for version control and `gh`, GitHub's command-line interface (CLI), for interacting with GitHub. They sound similar but do different things; we will explain the distinction in the next section.

### macOS

```bash
brew install git gh
```

### Linux (Debian/Ubuntu) or WSL

`git` is in the default apt repos. `gh` is not, so add GitHub's apt repo first (the four commands below are the official install from [cli.github.com](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)):

```bash
sudo apt install git

# Add GitHub's apt repo for gh
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
```

If the block above feels heavy, Homebrew also runs on Linux and installs `gh` with a single command (`brew install gh`); see [brew.sh](https://brew.sh) for the installer.

Verify both installations:

```bash
git --version
gh --version
```

You should see version numbers for both.

### Configure git identity

Git needs to know who you are for commit messages:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Use the same email you will use for GitHub.

### Authenticate the GitHub CLI

You will log in to `gh` after creating your GitHub account and adding an SSH key (the next section). The command will be:

```bash
gh auth login
```

Follow the prompts: pick **GitHub.com**, pick **SSH** as the authentication protocol (matches the SSH key you set up in section 4), then authenticate through your browser. Come back to this command after section 4 is done.

---

## 3b. Understanding `git` vs `gh`

These two tools work together but handle different things:

| | `git` | `gh` |
|---|---|---|
| **What it is** | Version control system | GitHub CLI |
| **What it does** | Tracks file changes, manages history | Manages GitHub features (issues, PRs, repos) |
| **Works without GitHub?** | Yes (works with GitLab, Bitbucket, or no remote at all) | No (GitHub-specific) |
| **Installed by default?** | Sometimes (macOS ships a version) | No, always a separate install |

### `git` commands you will use daily

```bash
git init           # Start tracking a folder
git add file.md    # Stage a file
git commit -m ""   # Save a snapshot
git push           # Send to remote
git pull           # Get updates
git log --oneline  # View history
git diff           # See what changed
git clone <url>    # Copy a remote repo locally
```

### `gh` commands for GitHub operations

```bash
gh repo create     # Create a new GitHub repo
gh repo clone      # Clone a GitHub repo (shorthand)
gh issue create    # Open an issue
gh issue develop   # Create a branch from an issue
gh pr create       # Open a pull request
gh pr view         # View PR details
```

### Where they overlap

Both can clone a repository:

```bash
# These do the same thing:
git clone https://github.com/user/repo.git
gh repo clone user/repo
```

That is essentially the only overlap. In practice, you use `git` for all version control (add, commit, push, pull, branch, merge) and `gh` for all GitHub operations (issues, pull requests, repo management). They complement each other.

---

## 4. Create a GitHub Account

If you do not already have one:

1. Go to [github.com](https://github.com)
2. Click **Sign up**
3. Choose a username, enter your email, create a password
4. Verify your email address

### GitHub Education (free upgrades for researchers)

GitHub offers free benefits for students, faculty, and research labs. These are worth setting up before you go further.

**Students:**

Apply for the [GitHub Student Developer Pack](https://education.github.com/pack):

1. Go to [education.github.com/students](https://education.github.com/students)
2. Click **Apply** (the exact button label may be "Apply to GitHub Education" or similar)
3. Verify your academic status (use your `.edu` email or upload proof of enrollment)
4. Once approved, you get GitHub Pro for free, plus access to dozens of developer tools

Benefits include unlimited private repos, GitHub Copilot access, and free domain names.

**Faculty and researchers:**

Apply for the [GitHub Teacher Toolbox](https://education.github.com/teachers):

1. Go to [education.github.com/teachers](https://education.github.com/teachers)
2. Click **Apply**
3. Verify your academic status with your institutional email
4. Once approved, you get a free **GitHub Team** subscription (unlimited collaborators and private repositories), free **GitHub Copilot Pro**, and the ability to create free GitHub Classroom organizations

**Research labs (organizations):**

If your lab or research group has a GitHub organization, you can upgrade it to GitHub Team for free:

1. Visit [education.github.com/globalcampus/teacher](https://education.github.com/globalcampus/teacher) (you must be verified as faculty first)
2. Find the **Upgrade your academic organizations** section
3. Click **Upgrade to GitHub Team**
4. Select your organization and click **Upgrade**

This gives your entire lab access to GitHub Team features for free: protected branches, required reviews, code owners, advanced audit logs, and more. Highly recommended for any research group managing shared code.

### Set up SSH keys (recommended)

Secure Shell (SSH) keys let you push to GitHub without typing your password every time.

```bash
# Generate a new SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"
```

Press Enter to accept the default file location. You can set a passphrase or press Enter for none.

```bash
# Start the SSH agent
eval "$(ssh-agent -s)"

# Add your key
ssh-add ~/.ssh/id_ed25519

# Copy the public key to your clipboard
# macOS:
cat ~/.ssh/id_ed25519.pub | pbcopy

# Linux:
cat ~/.ssh/id_ed25519.pub
# (select and copy the output manually)
```

Then add it to GitHub:

1. Go to [github.com/settings/keys](https://github.com/settings/keys)
2. Click **New SSH key**
3. Paste your key and give it a title (e.g., "My Laptop")
4. Click **Add SSH key**

Test the connection:

```bash
ssh -T git@github.com
```

You should see: `Hi username! You've successfully authenticated...`

---

## 5. Terminal Navigation Basics

Practice these commands in your terminal:

```bash
# Print working directory (where you are)
pwd

# List files and folders
ls

# Change directory
cd Documents

# Go back up one level
cd ..

# Create a new folder
mkdir my-first-project

# Move into it
cd my-first-project
```

**Key concepts:**

- **Absolute path**: starts from the root, e.g., `/Users/jane/Documents`
- **Relative path**: starts from where you are, e.g., `Documents/projects`
- `..` means "one directory up"
- `.` means "this directory"
- `~` means your home directory

---

## 6. Create Your First Repository

A repository (repo) is a project folder tracked by git. Every change you make is recorded.

```bash
# Create a project folder and move into it
mkdir my-research-project
cd my-research-project

# Initialize git tracking
git init
```

You should see: `Initialized empty Git repository in .../my-research-project/.git/`

### Create your first file

```bash
# Create a README file
echo "# My Research Project" > README.md
echo "" >> README.md
echo "This is my first git repository." >> README.md
```

### Make your first commit

```bash
# Check what git sees
git status

# Stage the file (tell git to include it in the next snapshot)
git add README.md

# Commit (save a snapshot with a message)
git commit -m "Add README with project description"
```

### Make a few more commits

```bash
# Add a notes file
echo "## Research Notes" > notes.md
echo "" >> notes.md
echo "- Started project setup" >> notes.md

git add notes.md
git commit -m "Add initial research notes"

# Edit the README
echo "" >> README.md
echo "## Goals" >> README.md
echo "- Learn git and GitHub" >> README.md
echo "- Set up a reproducible workflow" >> README.md

git add README.md
git commit -m "Add project goals to README"
```

> **Commit message style.** Subjects should be atomic (one logical change) and under 50 characters. "Add README with project description" is 35 characters; "Add project goals to README" is 27; both are fine. An anti-pattern: `"updated some stuff and fixed the license thing"`. More on why in Week 3.

### View your history

```bash
git log --oneline
```

You should see three commits, each with a short message. Yours will look something like this (the seven-character hashes will differ from mine):

```
7f3e1c2 Add project goals to README
b04a2d7 Add initial research notes
a9e5f01 Add README with project description
```

---

## 7. How Git Thinks: The Three States

You just used `git add` and `git commit` without much explanation. Now that the commands have worked once, the mental model is easier to absorb.

Before you start this section, make sure `git status` shows a clean working tree (no modified or staged files). If it does not, commit or discard the pending changes first so this exercise starts from a known state.

Every file in a git repository is in one of three places:

```
Working directory  ->  Staging area  ->  Repository
     (edit)             (git add)        (git commit)
```

- **Working directory** is what you see in your file explorer. When you edit `README.md` in a text editor, you are editing the working directory version.
- **Staging area** is a holding pen for the next snapshot. `git add README.md` does not save anything permanent; it says "include this version of README.md in the next commit."
- **Repository** is the permanent history. `git commit` takes whatever is currently in the staging area and writes it as a new snapshot with a message.

### Why three states instead of two?

The staging area exists so you can commit logically, not chronologically. Imagine you are in the middle of editing three files and realize two of them are a bug fix that should be its own commit, and the third is an unrelated cleanup. You can:

```bash
git add file1.md file2.md
git commit -m "Fix the citation formatter"

git add file3.md
git commit -m "Clean up leftover debug prints"
```

Two small, focused commits instead of one sprawling "stuff I did today" commit. Your future self, reviewing history, can understand each change on its own. Your collaborators (human or AI) can revert one without losing the other.

### See it with your own files

Try it:

```bash
# Make two unrelated changes
echo "" >> README.md
echo "## Status" >> README.md
echo "- In progress" >> README.md

echo "## Ideas" >> notes.md
echo "- Look into citation managers" >> notes.md

# See where git thinks things are
git status
```

You should see both files listed as "modified" in the working directory, nothing staged.

```bash
# Stage only the README change
git add README.md
git status
```

Now `README.md` is in "Changes to be committed" (the staging area), while `notes.md` is still "Changes not staged for commit" (working directory only).

```bash
# Commit just the staged change
git commit -m "Add status section to README"

# Now stage and commit the other change
git add notes.md
git commit -m "Add ideas for citation managers"

git log --oneline
```

Two commits, not one. That is the whole point of the staging area.

### Seeing what changed

```bash
# Changes you have not staged yet
git diff

# Changes you have staged but not yet committed
git diff --staged

# What the last commit changed
git show
```

These three commands will become muscle memory. They answer "what have I actually changed" at three different points in the three-state cycle.

### The undo button

The opener promised that git gives you an undo button. Here is how to press it.

To discard a working-directory edit you have not staged yet (back to the last committed version):

```bash
git restore README.md
```

To unstage a file (move it out of the staging area, keeping the working-directory edits):

```bash
git restore --staged README.md
```

To revert an already-committed change safely (creates a new commit that undoes the old one, keeping history honest):

```bash
git revert <commit-hash>
```

`git revert` is the right tool for "this commit broke things, back it out." It does not rewrite history, so it is safe even on commits that have already been pushed and reviewed.

Try it on a throwaway change: edit `README.md`, run `git status` to see it listed as modified, then run `git restore README.md` and confirm the file is back to its committed state.

---

## 8. Push to GitHub

Your commits so far live only on your laptop. Pushing to GitHub puts them on a server where they are backed up, shareable, and accessible to the GitHub workflow features (issues, pull requests) you will use in the next section.

### Create a remote repository

1. Go to [github.com/new](https://github.com/new)
2. Name it `my-research-project`
3. Leave it **public** (or private, your choice)
4. Do **not** check "Add a README" (you already have one)
5. Click **Create repository**

### Connect and push

GitHub will show you commands. Use the SSH version:

```bash
# Connect your local repo to GitHub
git remote add origin git@github.com:YOUR-USERNAME/my-research-project.git

# Push your commits
git branch -M main
git push -u origin main
```

Refresh the GitHub page. Your files and commits are now online.

`-u origin main` sets the default remote (`origin`) and branch (`main`) for this repo, so future pushes and pulls can be shortened to `git push` and `git pull`.

---

## 9. The GitHub Workflow: Issues, Branches, Pull Requests

You now have a repo on GitHub. The rest of this course assumes you work in a specific loop whenever you change anything non-trivial:

```
  Issue  ->  Branch  ->  Commits  ->  Pull Request  ->  Review  ->  Merge
```

That loop looks bureaucratic for a solo project at first. It becomes essential the moment you add an AI agent, a collaborator, or any future self who will forget why you made a change. Practicing the loop now, on a tiny project where nothing is at stake, means it will be automatic by Week 3 when it actually matters.

Let's walk through the loop end to end, using your `my-research-project`.

### 9a. Open an issue

An issue is a short record of "something needs to happen." It gives you a number to reference, a place to jot context, and a way to link the eventual pull request back to the original motivation.

```bash
gh issue create --title "Add a LICENSE file" --body "The repo should have a license so collaborators know the terms of use. Let's add CC-BY-4.0."
```

The command will open an editor if you omit `--body`. You can also create issues in the browser at `github.com/YOUR-USERNAME/my-research-project/issues/new`.

After creation, `gh` prints the issue number and a URL. For this walkthrough, assume the issue is number 1.

### 9b. Create a branch from the issue

Never edit directly on `main`. Always work on a branch, and name the branch after the issue it addresses. This keeps the history readable and makes it easy to see which branches are in flight.

```bash
gh issue develop 1 --checkout
```

This does two things in one step:

1. Creates a branch named something like `1-add-a-license-file` on GitHub, linked to issue 1
2. Checks it out locally

Verify:

```bash
git branch --show-current
```

You should see the new branch name. `main` is untouched.

### 9c. Make the change and commit

We will write a placeholder `LICENSE` for this exercise. For a real repository you would copy the full legal text (for CC-BY-4.0, that lives at [creativecommons.org/licenses/by/4.0/legalcode.txt](https://creativecommons.org/licenses/by/4.0/legalcode.txt) and should be downloaded in full). A placeholder is fine for learning the workflow:

```bash
cat > LICENSE <<'EOF'
CC-BY-4.0 License (placeholder)

This project will be licensed under Creative Commons Attribution 4.0
International (CC-BY-4.0). Replace this file with the full legal text
from https://creativecommons.org/licenses/by/4.0/legalcode.txt before
publishing.

Copyright (c) 2026 Your Name
EOF

git add LICENSE
git commit -m "Add CC-BY-4.0 license placeholder"
```

Atomic commit, under 50 characters in the subject, describing what changed.

### 9d. Push the branch

The branch name was auto-generated by `gh issue develop` from the issue title, so use whatever is currently checked out rather than hard-coding the name:

```bash
git push -u origin "$(git branch --show-current)"
```

If you want to see what branch name that resolves to:

```bash
git branch --show-current
```

### 9e. Open a pull request

A pull request (PR) is a proposal: "I want these commits on my branch to be merged into `main`." It is the review checkpoint. Even on a solo project, opening a PR forces you to look at the diff as an outsider before it lands in the canonical branch.

```bash
gh pr create --title "Add CC-BY-4.0 license" --body "Closes #1"
```

The `Closes #1` line tells GitHub to close issue 1 automatically when this PR merges. You can also use `Fixes #1` or `Resolves #1`; they all do the same thing.

Confirm:

```bash
gh pr view --web
```

This opens the PR page in your browser. You should see the diff (one new `LICENSE` file), the title, the linked issue, and a big green "Merge" button.

### 9f. Review your own PR

On the PR page, click the **Files changed** tab. Read every line as if someone else wrote it. On a real project, this is where you catch:

- Unintended debug prints you forgot to remove
- Files you did not mean to commit (data, credentials, editor backups)
- Commits that should have been split into smaller units
- Copy-paste typos in code or comments

For a one-file license addition there is not much to catch. Still, do the habit. Later in this course, an AI review agent will do this step too, in parallel.

### 9g. Merge

Back on the PR page, click **Merge pull request**, then pick **Create a merge commit** from the dropdown, then confirm. We will compare the three merge styles in Week 3; for now, merge commit is the most faithful representation of what happened.

For reference, GitHub offers three merge styles:

- **Create a merge commit:** keeps all commits from the branch in history, plus a merge commit. Most honest representation of what happened.
- **Squash and merge:** combines all the commits on the branch into a single commit on `main`. Cleaner history if the branch had lots of noisy "fix typo" commits.
- **Rebase and merge:** replays the branch's commits on `main` with no merge commit. Linear history.

After merging, click **Delete branch** (GitHub offers the button right there). The branch has done its job; leaving it around just makes your branch list noisy.

### 9h. Pull the merged change back to your local `main`

Your local `main` does not automatically know about the merge. Update it:

```bash
git checkout main
git pull
```

You should see the new `LICENSE` file and the new commit (merge commit or squashed, depending on which style you picked).

```bash
git log --oneline
```

You should see something like (hashes will differ):

```
d5c9af3 Merge pull request #2 from user/1-add-a-license-file
e8b1a02 Add CC-BY-4.0 license placeholder
7f3e1c2 Add project goals to README
b04a2d7 Add initial research notes
a9e5f01 Add README with project description
```

Issue 1 is now closed automatically. The loop is complete:

```
  Issue #1  ->  Branch  ->  Commit  ->  PR  ->  Review  ->  Merge  ->  Local main
```

### Do it once more for practice

Try another round with a slightly bigger change so the loop sinks in:

```bash
gh issue create --title "Add a CONTRIBUTING.md" --body "Document how collaborators (human or AI) should open PRs."

gh issue develop <issue-number> --checkout

# Make the change
cat > CONTRIBUTING.md <<'EOF'
# Contributing

Open an issue before starting work. Branch from `main` using
`gh issue develop <N>`. Keep commits atomic and under 50 characters.
Open a PR when the branch is ready; link the issue with `Closes #N`.
EOF

git add CONTRIBUTING.md
git commit -m "Add CONTRIBUTING guide"
git push -u origin "$(git branch --show-current)"
gh pr create --title "Add CONTRIBUTING guide" --body "Closes #<issue-number>"
gh pr view --web
```

Merge, delete the branch, pull. You have now run the loop twice. By Week 3 it will be automatic.

---

## 10. Verify Everything Works

Run through this checklist:

```bash
# Git is installed
git --version

# You are in your project
pwd

# Git is tracking the project
git status

# You have commits
git log --oneline

# Your remote is set
git remote -v

# You can list GitHub issues from the terminal
gh issue list

# You can list pull requests from the terminal
gh pr list --state all
```

If all of these work, you are ready for Week 2.

---

## 11. Prepare for Next Week

Before the next session, install [Claude Code](https://claude.ai/claude-code), the AI coding agent we will use for the rest of the course:

```bash
# macOS / Linux
curl -fsSL https://claude.ai/install.sh | bash

# Or via Homebrew on macOS
brew install claude-code

# Windows PowerShell
irm https://claude.ai/install.ps1 | iex
```

Verify:

```bash
claude --version
```

We will walk through the full setup (authentication, `CLAUDE.md`, `.context/` directory, prompting) together in Week 2. If you want to read ahead, the [Week 2 setup guide](./week-02-claude-code-setup.md) has the same material in written form.

---

## Quick Reference

### Terminal

| Command | What it does |
|---------|-------------|
| `pwd` | Print current directory |
| `ls` | List files |
| `cd <dir>` | Change directory |
| `mkdir <name>` | Create a directory |

### Git (version control)

| Command | What it does |
|---------|-------------|
| `git init` | Start tracking a folder |
| `git status` | See what changed |
| `git add <file>` | Stage a file for commit |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |
| `git commit -m "msg"` | Save a snapshot |
| `git push` | Send commits to GitHub |
| `git pull` | Get updates from GitHub |
| `git log --oneline` | View commit history |
| `git show` | Show the last commit |
| `git restore <file>` | Discard working-directory changes (the undo button) |
| `git restore --staged <file>` | Unstage a file, keep the edits |
| `git revert <hash>` | Safely undo a committed change with a new commit |
| `git clone <url>` | Copy a remote repo |
| `git branch --show-current` | Print the current branch name |
| `git checkout <branch>` | Switch to a branch |

### GitHub CLI (`gh`)

| Command | What it does |
|---------|-------------|
| `gh auth login` | Authenticate with GitHub |
| `gh repo create` | Create a new repository |
| `gh repo clone user/repo` | Clone a GitHub repo |
| `gh issue create` | Open a new issue |
| `gh issue list` | List open issues |
| `gh issue develop <n> --checkout` | Create a branch from an issue and check it out |
| `gh pr create` | Open a pull request |
| `gh pr view` | View pull request details |
| `gh pr view --web` | Open the PR page in your browser |
| `gh pr list` | List open pull requests |

### The GitHub workflow loop

```
Issue  ->  Branch  ->  Commits  ->  Pull Request  ->  Review  ->  Merge  ->  Pull main
```

---

## Resources

- [Git documentation](https://git-scm.com/doc)
- [GitHub Skills](https://skills.github.com/) (free interactive courses)
- [Pro Git book](https://git-scm.com/book/en/v2) (free, covers the three states in depth)
- [Course repository](https://github.com/OpenScience-Collective/agentic-research-course)
- [Week 2 setup guide](./week-02-claude-code-setup.md) (Claude Code, CLAUDE.md, prompting)
- [Open Science Collective Discord](https://discord.gg/5dWJCUmUww)
- [research-skills plugin](https://github.com/neuromechanist/research-skills)

---

*Part of the [Agentic Research Course](https://github.com/OpenScience-Collective/agentic-research-course) by the Open Science Collective. Licensed under CC-BY-4.0.*
