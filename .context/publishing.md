# Publishing Week N to the Course Website

How to publish session content to [courses.osc.earth/agentic-research](https://courses.osc.earth/agentic-research/) after a session is complete.

## Repositories

| Repo | Purpose | Path |
|------|---------|------|
| `agentic-research-course` | Source material (slides, research docs, session READMEs) | `/Users/yahya/Documents/git/osc/agentic-research-course` |
| `osc-docs` (documentation) | Public website, MkDocs Material | `/Users/yahya/Documents/git/osc/osc-docs` |
| `agentic-presentation-builder` | Slide engine (Vite + Reveal.js) | `/Users/yahya/Documents/git/osc/agentic-presentation-builder` |

The course repo is the canonical source. The docs repo copies the built slides plus the session content into a publishable form.

## Directory Layout in osc-docs

```
osc-docs/
├── courses/
│   ├── agentic-research/
│   │   ├── index.md          # Course overview and schedule
│   │   ├── week-01.md         # Week 1 session page
│   │   └── week-02.md         # Week 2 session page (add this)
│   └── slides/
│       └── agentic-research/
│           ├── week-01/       # Bundled Reveal.js slides (built output)
│           │   ├── presentation.html
│           │   ├── week-01.json
│           │   └── assets/
│           │       ├── icons/ # SVG icons referenced by slides
│           │       └── *.js   # Reveal.js bundle
│           └── week-02/       # Same structure for Week 2
```

## Publishing Workflow

For every session week, follow this pattern.

### 1. Build the Presentation Bundle

From the presentation builder:

```bash
cd ~/Documents/git/osc/agentic-presentation-builder
bun run build
# Output goes to dist/
```

This produces a static bundle with an updated `presentation.html` and hashed asset files. If the engine has not changed since Week 1, you can reuse the existing bundled `assets/` (Reveal.js JS/CSS) and only swap the JSON + icons.

### 2. Copy the Slides into osc-docs

Create the week-specific slide directory:

```bash
WEEK=week-02
mkdir -p ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets/icons
mkdir -p ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets/screenshots

# If the engine bundle is unchanged, reuse Week 1 assets:
cp -r ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/week-01/assets/*.js \
      ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets/
cp -r ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/week-01/assets/*.css \
      ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets/
cp -r ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/week-01/assets/source-sans-pro-* \
      ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets/
cp ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/week-01/presentation.html \
   ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/presentation.html

# Copy the week's JSON
cp ~/Documents/git/osc/agentic-research-course/presentations/$WEEK/presentation.json \
   ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/$WEEK.json

# Copy only the icons this week actually references
# (check presentation.json for "./assets/icons/*.svg" references)
cp ~/Documents/git/osc/agentic-research-course/assets/icons/claude-*.svg \
   ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets/icons/
# ...etc. Copy only what the JSON references.

# Copy screenshots if slides reference them
cp ~/Documents/git/osc/agentic-research-course/assets/screenshots/*.png \
   ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets/screenshots/
```

If the engine has changed (new agentic-presentation-builder release), copy the full `dist/assets/` fresh:

```bash
cd ~/Documents/git/osc/agentic-presentation-builder
bun run build
rm -rf ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/assets
cp -r dist/assets ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/
cp dist/index.html ~/Documents/git/osc/osc-docs/courses/slides/agentic-research/$WEEK/presentation.html
```

### 3. Create the Week Page

Use `courses/agentic-research/week-01.md` as a template. Required structure:

```markdown
# Week N: Session Title

## Overview
1-2 paragraph framing of why this session matters.

!!! abstract "Learning Objectives"
    - Bullet list matching the session README learning objectives

<div class="embed-container">
  <iframe src="https://www.youtube.com/embed/VIDEO_ID"
          title="Week N: Title"
          ...>
  </iframe>
</div>

## Slides

<div class="embed-container">
  <iframe src="../../slides/agentic-research/week-N/presentation.html?presentation=./week-N.json"
          title="Week N Slides"
          allowfullscreen>
  </iframe>
</div>

<p class="slide-hint">Use arrow keys to navigate. Press <kbd>F</kbd> for fullscreen, <kbd>?</kbd> for shortcuts.</p>

---

## Main Content

[Detailed walkthrough, step-by-step guides, code snippets, tabs for macOS/Linux/Windows]

---

## Before Next Session
[Homework checklist, next week preview]

---

## Quick Reference
[Tables of commands, shortcuts]

---

## Resources
[Links to docs, repos, Discord, related plugins]

<style>
/* Copy the embed-container and slide-hint styles from week-01.md */
</style>
```

### 4. Update the Course Index

Edit `courses/agentic-research/index.md`. Change the week row from bare text to a link:

```markdown
| Wed April 15 | [Week 2](week-02.md) | Setting Up Claude Code for Research |
```

### 5. Test Locally

```bash
cd ~/Documents/git/osc/osc-docs
uv run mkdocs serve -f mkdocs-courses.yml
# Open http://127.0.0.1:8000/agentic-research/week-02/
```

Verify:
- Slides iframe loads and navigates
- Icons/screenshots render (check browser console for 404s)
- OS-specific tabs sync (use exactly `"macOS"`, `"Linux"`, `"Windows"` labels)
- No em-dashes in copy; no emojis

### 6. Commit, PR, Merge

Follow standard git workflow:

```bash
cd ~/Documents/git/osc/osc-docs
gh issue create --title "Add Week N to agentic-research course site"
gh issue develop <issue-number> --checkout

# Commit slide bundle + week page + index update
git add courses/slides/agentic-research/week-N/
git commit -m "Bundle Week N presentation slides"

git add courses/agentic-research/week-N.md courses/agentic-research/index.md
git commit -m "Add Week N session page"

git push -u origin <branch>
gh pr create --title "Add Week N to agentic-research course" --body "Closes #<issue>"
```

After the video recording goes up on YouTube, update the video iframe `src` to the actual video ID.

## Content Guidelines

- **Theme consistency:** Mirror Week 1's structure exactly. Users should feel they are in the same course, not a new site.
- **Tabs:** Use `=== "macOS"`, `=== "Linux"`, `=== "Windows"` labels verbatim so tab syncing works across the page.
- **Plugin mentions:** Reference `research-skills`, `matlab-mcp-tools`, and other OSC tools naturally inside walkthroughs. Do not dedicate promotional blocks. Link from the Resources section and weave in where relevant to the practicum.
- **Screenshots:** Reuse the ones bundled in slides. Reference them with standard Markdown image syntax relative to the page.
- **No em-dashes:** Use commas or semicolons. Global repo rule.
- **No emojis** in commits, PRs, or copy.
- **Admonitions:** Use `!!! note`, `!!! tip`, `!!! abstract`, `!!! info` the same way Week 1 does.
- **Command blocks:** Show commands for all three OSes where setup differs. Use `bash` fence for Unix; `powershell` for Windows-native steps.

## Sharing the Presentation Before the Session

You can share the slide deck publicly once it is published to courses.osc.earth. The link format is:

```
https://courses.osc.earth/agentic-research/slides/agentic-research/week-N/presentation.html?presentation=./week-N.json
```

This works from Discord, email, or social. The Reveal.js controls (arrow keys, F for fullscreen, ? for shortcuts) are all client-side.

For pre-session teaser posts:
- Share the slide link plus the course page link
- Include the Discord invite for live Q&A
- Mention the Zoom/Nextcloud link from the course index

## Video Integration

After the YouTube upload:

1. Get the video ID from the URL (e.g., `https://www.youtube.com/watch?v=VIDEO_ID`)
2. Update the iframe `src` in `week-N.md`:

```html
<iframe src="https://www.youtube.com/embed/VIDEO_ID" ...>
```

3. Commit directly to main or via a small PR.

## Known Gotchas

- **Slide iframe breaks on mobile Safari** if the Reveal.js bundle is missing even one hashed asset. Always copy the complete `assets/` directory.
- **MkDocs tab sync** requires exact label match across the whole page. One mismatched label breaks every tab group.
- **Relative paths in JSON:** The slide JSON uses `./assets/icons/*.svg`. Those paths are relative to the slide `presentation.html` location, not the markdown page.
