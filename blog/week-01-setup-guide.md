# Week 1 Setup Guide: Git, GitHub, and the Command Line

*A step-by-step walkthrough for getting your research computing environment ready.*

This guide accompanies [Week 1](../sessions/week-01/) of the Agentic Research Course course by the [Open Science Collective](https://osc.earth). By the end, you will have a working terminal, git installed, a GitHub account, and your first repository pushed to the cloud.

No prior coding experience is assumed.

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

Follow the on-screen instructions. After installation, verify it works:

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

You need two command-line tools: `git` for version control and `gh` (the GitHub CLI) for interacting with GitHub. They sound similar but do different things; we will explain the distinction in the next section.

### macOS

```bash
brew install git gh
```

### Linux (Debian/Ubuntu) or WSL

```bash
sudo apt install git gh
```

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

After creating your GitHub account (next section), log in to `gh`:

```bash
gh auth login
```

Follow the prompts: select GitHub.com, choose HTTPS or SSH, and authenticate through your browser. This lets you create repos, issues, and pull requests from the terminal.

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

That is essentially the only overlap. In practice, you use `git` for all version control (add, commit, push, pull, branch, merge) and `gh` for all GitHub operations (issues, PRs, repo management). They complement each other.

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
2. Click **Join Global Campus**
3. Verify your academic status (use your `.edu` email or upload proof of enrollment)
4. Once approved, you get GitHub Pro for free, plus access to dozens of developer tools

Benefits include unlimited private repos, GitHub Copilot access, and free domain names.

**Faculty and researchers:**

Apply for the [GitHub Teacher Toolbox](https://education.github.com/teachers):

1. Go to [education.github.com/teachers](https://education.github.com/teachers)
2. Click **Join Global Campus**
3. Verify your academic status with your institutional email
4. Once approved, you get GitHub Pro and can create free GitHub Classroom organizations

**Research labs (organizations):**

If your lab or research group has a GitHub organization, you can upgrade it to GitHub Team for free:

1. Visit [education.github.com/globalcampus/teacher](https://education.github.com/globalcampus/teacher) (you must be verified as faculty first)
2. Find the **Upgrade your academic organizations** section
3. Click **Upgrade to GitHub Team**
4. Select your organization and click **Upgrade**

This gives your entire lab access to GitHub Team features for free: protected branches, required reviews, code owners, advanced audit logs, and more. Highly recommended for any research group managing shared code.

### Set up SSH keys (recommended)

SSH keys let you push to GitHub without typing your password every time.

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

### View your history

```bash
git log --oneline
```

You should see three commits, each with a short message.

---

## 7. Push to GitHub

Now let's put your local repo on GitHub so it is backed up and shareable.

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

---

## 8. Verify Everything Works

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
```

If all of these work, you are ready for Week 2.

---

## 9. Prepare for Next Week

Before the next session, install [Claude Code](https://claude.ai/claude-code), the AI coding agent we will use for the rest of the course:

```bash
# macOS / Linux
brew install claude-code

# Or via the official installer
curl -fsSL https://claude.ai/install-cli | sh
```

Verify:

```bash
claude --version
```

We will walk through the full setup together in Week 2.

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
| `git commit -m "msg"` | Save a snapshot |
| `git push` | Send commits to GitHub |
| `git pull` | Get updates from GitHub |
| `git log --oneline` | View commit history |
| `git diff` | Show uncommitted changes |
| `git clone <url>` | Copy a remote repo |

### GitHub CLI (`gh`)

| Command | What it does |
|---------|-------------|
| `gh auth login` | Authenticate with GitHub |
| `gh repo create` | Create a new repository |
| `gh repo clone user/repo` | Clone a GitHub repo |
| `gh issue create` | Open a new issue |
| `gh issue develop <num>` | Create a branch from an issue |
| `gh pr create` | Open a pull request |
| `gh pr view` | View pull request details |

---

## Resources

- [Git documentation](https://git-scm.com/doc)
- [GitHub Skills](https://skills.github.com/) (free interactive courses)
- [Course repository](https://github.com/OpenScience-Collective/agentic-research-course)
- [Open Science Collective Discord](https://discord.gg/5dWJCUmUww)
- [research-skills plugin](https://github.com/neuromechanist/research-skills)

---

*Part of the [Agentic Research Course](https://github.com/OpenScience-Collective/agentic-research-course) course by the Open Science Collective. Licensed under CC-BY-4.0.*
