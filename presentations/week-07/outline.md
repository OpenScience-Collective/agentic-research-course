# Week 7 Presentation: Manuscript Preparation and Peer Review

22-slide deck. ~30 min presentation, then ~5 min live walkthrough, then 15 min Q&A.

**Thesis.** A manuscript is a managed pipeline that stays GitHub-native while agents and humans co-write, and moves to Overleaf only when external co-authors and advisors take the wheel. Two loops, two tools: **the agent loop wants pull requests; the human loop wants comments**. The Overleaf round-trip closes via direct git clone-back. There is one critical caveat we treat as a first-class step, not a footnote: Overleaf inline comments do not travel through git, so a **manual comment-merge pass** is mandatory.

The pipeline shape is the same as Week 5 (lit review) and Week 6 (grant proposal): 5 stages with a boomerang from review back to drafting. New this week: IMRAD structure, journal-formatting concerns, the figures component, and the Overleaf hand-off.

The tone matches Weeks 3-6. Every theoretical point lands on a worked example: a narrative review on the neural correlates of naturalistic movie watching, organised by the four perspectives from Week 5 (psychophysics, action, language, emotion). The live demo continues the same corpus.

## Opening

### Slide 1: Title

- Week 7: Manuscript Preparation and Peer Review
- Author, course link, Discord link, recording link

### Slide 2: Where we are

- Week 1: git + GitHub (safety net)
- Week 2: Claude Code (the agent)
- Week 3: epic + sub-issues + worktrees + plan + `/review-pr`
- Week 4: CI/CD
- Week 5: literature review pipeline (today's lit-review stage)
- Week 6: grant pipeline (today's Aims and Strategy structure expanded)
- Today: same pipeline shape applied to a full IMRAD manuscript, GitHub-native end-to-end except the human-review pass

## The Two Loops

### Slide 3: Two loops, two tools

- **Agent loop** -- agents and the author co-write, iterate, and self-review inside the git repo. Pull requests, branches, `/review-pr`
- **Human loop** -- co-authors, advisors, external reviewers mark up the draft. Real-time editing, comments, tracked changes
- Each loop has its own tool because the work is structurally different
- **The agent loop wants pull requests; the human loop wants comments.** Picking the wrong tool for the wrong loop is the Week 7 failure mode

### Slide 4: Where the loops meet

- Both loops live in the same source-of-truth repo
- The boundary is between Stages 4 and 5 of the manuscript pipeline (after self-review, before format and submit)
- The Overleaf round-trip keeps Overleaf in sync with the repo without abandoning version history

## Reframe and Pipeline

### Slide 5: IMRAD = Aims expanded

- A manuscript Introduction is structurally the Week-6 Specific Aims expanded
- Methods and Results expand the Approach section of the Research Strategy
- Discussion is what Week 6's Expected Impact aspires to be once the results exist
- Cite-the-card discipline from Week 5 transfers verbatim: every claim points to a paper-card or a figure source by relative path

### Slide 6: The 5-stage manuscript pipeline (hero)

- Stages: Lit review -> Draft -> Figures -> Self-review -> Format & submit
- Boomerang from Stage 4 back to Stages 1, 2, or 3
- Vertical divider in the middle: agent loop (Stages 1-4) on the left, human loop (Stage 5 + Overleaf round-trip) on the right

## Stage 1: Lit Review

### Slide 7: Stage 1 -- Lit review (inherits Week 5)

- Week-5 corpus is the input
- `/manuscript:manuscript-formatting` picks the structure: mini-review, scoping, narrative, systematic, IMRAD background
- Live demo uses the **narrative review** structure (natural next step after Week 5's mini-review on the same corpus)

## Stage 2: Draft

### Slide 8: Stage 2 -- IMRAD section conventions

- Tense + length + voice table per section: Title, Abstract, Intro, Methods, Results, Discussion, Conclusion
- Introduction is a funnel (broad context -> narrow focus -> gap -> objective)
- Methods are stepwise and replicable; Results report findings with statistics; Discussion interprets and bounds

### Slide 9: Section-as-sub-issue -- Week 3 pattern for prose

- One sub-issue per IMRAD section, one worktree per sub-issue
- `feature/issue-N-intro`, `feature/issue-N-methods`, `feature/issue-N-results`, `feature/issue-N-discussion`
- Each worktree branches from a long-lived `manuscript/` branch
- PRs land into `manuscript/`; `manuscript/` merges to `main` only at submission

### Slide 10: /manuscript:manuscript-writing

- Drafts each section with the IMRAD conventions
- Cite-the-card visible in the diff (every claim is a relative link to `lit-review/<perspective>/<slug>/card.md`)
- `/manuscript:humanizer` runs on every section before the PR opens (strips AI tells: em-dashes, rule-of-three, "delve", "tapestry", certainty hedges)

## Stage 3: Figures

### Slide 11: Stage 3 -- Figures live in the repo

- `/figures:scientific-figure` for composed multi-panel figures
- `/figures:svg-figure` for pure vector schematics
- `/figures:plot-styling` for the journal-specific style (font sizes, palette, axis ticks)
- The discipline: **figure source lives next to the manuscript**. Every figure is reproducible from the repo

### Slide 12: Figures directory layout

- `figures/<panel>/source.svg` (or `source.py`, `source.R`) tracked
- `figures/<panel>/figure.pdf` built on demand, gitignored
- The text cites `figures/<panel>/figure.pdf` by relative path; the figure caption cites the source script

## Stage 4: Self-Review

### Slide 13: /manuscript:paper-review and the boomerang

- Same skill used in Week 5; same severity tagging (Critical, Major, Minor)
- Boomerang routing:
  - Critical -> Stage 1 or 2 (corpus gap or unsupported claim)
  - Major -> Stage 2 or 3 (methodological weakness or figure that does not show what the text claims)
  - Minor -> in place (prose edits)
- Convergence in one shot is a red flag -- same logic as Week 5 and Week 6

## Stage 5 and the Overleaf Round-Trip

### Slide 14: Stage 5 -- Format and submit (still in the repo)

- `/manuscript:manuscript-formatting` produces journal-ready LaTeX (Nature, IEEE, NeuroImage, JOSS, etc.)
- `manuscript/` branch is now a proper LaTeX source tree
- Submission zip packages exactly what the journal requires; no `.git`, no scratch files

### Slide 15: The Overleaf round-trip -- step 1, ship a zip

- Co-authors and advisors mostly do not want to learn git. They want Overleaf
- The Stage 5 submission zip doubles as the initial Overleaf payload
- Overleaf: Menu -> New Project -> Upload Project
- Screenshot: `archive-zip-tree.png` -- the zip file with its expanded contents

### Slide 16: The Overleaf round-trip -- step 2, enable Overleaf git

- Overleaf premium accounts expose a git URL per project (Menu -> Sync -> Git)
- The Overleaf project history is git history
- Screenshot: `overleaf-git-tab.png` -- the Sync -> Git panel showing the project URL

### Slide 17: The Overleaf round-trip -- step 3, clone back

- From your local repo, add Overleaf as a remote:
  ```bash
  git remote add overleaf https://git.overleaf.com/<project-id>
  git fetch overleaf
  git checkout -b overleaf-merge overleaf/master
  ```
- Resolve conflicts the usual way
- The Overleaf branch lives alongside `manuscript/` and merges in via a PR

### Slide 18: The Overleaf round-trip -- step 4, the manual comment-merge pass

- **Overleaf inline comments do not travel through git.** They live in the Overleaf UI only
- Before closing the Overleaf round, manually read every open comment thread and transcribe each as either a GitHub issue (non-trivial) or a PR comment (one-line fix). Mark Overleaf comments "Resolved" only after the transcription lands
- Screenshot: `overleaf-comments-ui.png` -- a few inline comments in the Overleaf right panel
- Punchline: **Overleaf is a co-author UI on top of your git history, not a replacement for git history.** Treat it as a peripheral, not the source of truth

## Response to Reviewers

### Slide 19: Response to reviewers -- point by point

- Same shape as Week 6's A1 Introduction (one page, point-by-point)
- For each comment: "Response:" then "Change:" then a relative path to the section / line that changed
- Vertical change bars in the LaTeX source
- Tone rule (carried from Week 6): **respond, do not rebut**

## Three Defences and Close

### Slide 20: Three defences -- one per stage pair

- Cite-the-card / cite-the-figure (Stages 1-3): carried from Week 5
- Review boomerang (Stage 4): carried from Week 6
- Comment-merge pass (Overleaf round-trip): **new this week**
- Deliberately stack-redundant; none alone is sufficient

### Slide 21: Live demo roadmap

- Topic: narrative review on the neural correlates of naturalistic movie watching, organised by the four perspectives from Week 5
- Pre-built: Week-5 corpus + manuscript stubs (`main.tex`, `intro.tex`, `discussion.tex`) + a figures stub + a manuscript epic with sub-issues per section
- Three live actions: `/manuscript:manuscript-writing` drafts the intro paragraph; `/manuscript:paper-review` critiques it; the Overleaf round-trip is **described** with screenshots, not run live, because the moral is the comment-merge caveat slide
- We do not manufacture a finding. A likely natural one is uneven perspective coverage (the four strands have asymmetric card counts), in which case the boomerang re-enters Stage 1 aloud

### Slide 22: What today gives you / what's next

- Today: a manuscript pipeline that stays GitHub-native through the agent loop and survives the Overleaf round-trip with version history intact
- Next: Week 8 -- scientific figure design proper. Composition, palette, panel layout
