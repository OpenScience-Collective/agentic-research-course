# Week 7: Manuscript Preparation and Peer Review

A manuscript is not a single prompt; it is a managed pipeline that lives in the same git repo, with the same epic and pull-request rigor, until the moment co-authors need to review it. **GitHub-native while agents and humans collaborate; Overleaf when humans take the wheel.** The single most useful idea in this session: **the agent loop and the human loop are different loops, and they need different tools**. Up to internal sign-off, the manuscript is just another artefact in your repo, with `/manuscript:*` skills writing prose, `/figures:*` skills rendering panels, and `/manuscript:paper-review` running a self-review boomerang. When external co-authors and advisors need to mark up the draft, we package the LaTeX source as a zip, hand it off to Overleaf, and (because Overleaf supports git natively) clone the Overleaf project back into the repo to keep history. There is one critical caveat we treat as a first-class step, not a footnote: **Overleaf inline comments do not travel through git**, so a manual reconciliation pass is always required when the Overleaf round-trip closes.

The pipeline shape is the same as Week 5 (lit review) and Week 6 (grant proposal): a 5-stage flow with a boomerang from review back to drafting. What changes this week is the IMRAD structure, journal-formatting concerns, the figures component, and the Overleaf hand-off.

## Learning Objectives

By the end of this session, you will:

- Frame a manuscript as a **5-stage pipeline** living entirely inside a git repo: lit review, draft, figures, self-review, format and submit
- Run an **epic + sub-issue + worktree** workflow for a manuscript (one sub-issue per section), the same way Week 3 ran it for code
- Use `/manuscript:lit-review`, `/manuscript:manuscript-writing`, `/manuscript:manuscript-formatting`, `/manuscript:paper-review`, and `/manuscript:humanizer` together in one session
- Use `/figures:scientific-figure` and `/figures:svg-figure` to produce publication-grade figures inside the same repo as the manuscript source
- Recognise the **agent loop vs. human loop** boundary: when to stay in the repo and when to hand off to Overleaf
- Run the Overleaf round-trip: package the LaTeX source as a zip, open the Overleaf project, **clone the Overleaf project back to your repo via direct git**, and merge upstream Overleaf edits back into your branch
- Handle the **comment-merge manual pass**: Overleaf inline comments do not sync through git, so a separate transcription step from the Overleaf UI to GitHub issues / PR comments is mandatory
- Write a **point-by-point response-to-reviewers letter** with the same cite-the-card discipline used since Week 5

## The 5-Stage Pipeline

```
[ 1. Lit review ] -> [ 2. Draft ] -> [ 3. Figures ] -> [ 4. Self-review ] -> [ 5. Format & submit ]
        ^                                                       |
        +-------------------------------------------------------+
                              boomerang on findings

  ============================== agent loop ==============================|=== human loop ===
                              ( GitHub-native )                              ( Overleaf )
```

The pipeline is mostly the same shape as Weeks 5 and 6. Two differences:

1. **The figures stage is first-class.** Manuscripts depend on publication-grade figures; the figures skill produces them inside the same repo so the cite-the-card discipline extends to "cite the figure source" as well as "cite the paper-card".
2. **The boundary between agent loop and human loop is explicit.** Stages 1-4 live in the repo; the Overleaf round-trip happens between Stage 4 and Stage 5 (final formatting and submission). The Overleaf clone-back step closes the loop without losing version history.

| Stage | Tool | Output |
|-------|------|--------|
| 1. Lit review | `/manuscript:lit-review`, `/opencite:opencite`, `/manuscript:manuscript-formatting` (picks the structure) | `lit-review/` corpus -- inherits Week 5's paper-card shape; selects mini-review, scoping, narrative, systematic, or IMRAD background |
| 2. Draft | `/manuscript:manuscript-writing`, `/manuscript:humanizer` | `manuscript/intro.tex`, `methods.tex`, `results.tex`, `discussion.tex` with cite-the-card discipline |
| 3. Figures | `/figures:scientific-figure`, `/figures:svg-figure`, `/figures:plot-styling` | `figures/<panel>/source.svg` and rendered `figures/<panel>/figure.pdf` |
| 4. Self-review | `/manuscript:paper-review` | Severity-tagged findings; boomerang back to Stage 1, 2, or 3 |
| 5. Format & submit | `/manuscript:manuscript-formatting`, Overleaf round-trip, manual comment-merge pass | Submission zip + cover letter + response-to-reviewers letter (if revision) |

Order is enforced. Drafting before the lit review produces unsupported claims; formatting before the self-review polishes a draft that may still get cycled.

## Outline (30-45 min talk + 15 min Q&A)

### Part 1: The Two Loops (3 min)

- **Agent loop** -- agents and the author co-write, iterate, and self-review inside the same git repo. Epic, sub-issues per section, worktrees, PRs, `/review-pr`
- **Human loop** -- co-authors, advisors, and external reviewers mark up the draft. This is where Overleaf shines (real-time multi-author editing, tracked changes, comments)
- Each loop has its own tools because the work is structurally different. **The agent loop wants pull requests; the human loop wants comments.** Picking the wrong tool for the wrong loop is the most common Week 7 failure
- Both loops live in the same source-of-truth repo; the Overleaf round-trip keeps Overleaf in sync with the repo without abandoning version history

### Part 2: Reframe -- IMRAD = Aims Expanded (2 min)

- A manuscript's Introduction is structurally the Specific Aims page expanded
- Methods and Results expand the Approach section of a Research Strategy
- Discussion is what Week 6's Expected Impact aspires to be once you have the actual results
- The cite-the-card discipline from Week 5 carries into the manuscript verbatim: every claim cites a paper-card or a figure source by relative path

### Part 3: The 5-Stage Manuscript Pipeline (2 min)

- Hero diagram. Five stages with a boomerang from Stage 4 back to Stages 1, 2, or 3
- Vertical divider in the middle: agent loop on the left (Stages 1-4), human loop on the right (Stage 5 + Overleaf round-trip)

### Part 4: Stage 1 -- Lit Review (3 min)

- Inherits Week 5 verbatim. The corpus produced in Week 5 (psychophysics, action, language, emotion strands on naturalistic movie watching) is the input
- `/manuscript:manuscript-formatting` picks the structure for this manuscript. For the live demo we use the **narrative review** structure (the natural next step after Week 5's mini-review on the same topic)
- Cite-the-card discipline transfers: every claim in the manuscript points to a `card.md` by relative path

### Part 5: Stage 2 -- Draft with `/manuscript:manuscript-writing` (5 min)

- IMRAD section conventions (tense, length, voice) -- table from the skill's reference
- Section-by-section: introduction is a funnel; methods are stepwise and replicable; results are claims with statistics, not narrative; discussion interprets and bounds
- One sub-issue per section, one worktree per sub-issue (the Week 3 pattern applied to prose):
  - `feature/issue-N-intro`, `feature/issue-N-methods`, `feature/issue-N-results`, `feature/issue-N-discussion`
  - Each worktree branches from a long-lived `manuscript/` branch
  - PRs land back into `manuscript/`; `manuscript/` merges to `main` only at submission time
- `/manuscript:humanizer` runs on every section before the PR opens, stripping AI tells

### Part 6: Stage 3 -- Figures (4 min)

- `/figures:scientific-figure` for the main composed figures (panel A is an SVG, panel B is a plot, panel C is a schematic; the skill composes them into one PDF)
- `/figures:svg-figure` for pure-vector schematics (no data)
- `/figures:plot-styling` for the journal-specific style (font sizes, palette, axis tick density)
- The discipline: **figure source lives next to the manuscript, not on someone's laptop**. Every figure is reproducible from the repo
- The figures repo subdirectory is git-ignored on the output PDFs by default; only the source files (SVG, Python script, R script) are tracked

### Part 7: Stage 4 -- Self-Review and Boomerang (4 min)

- `/manuscript:paper-review` plays the peer-reviewer role; same skill used in Week 5 (lit review review)
- Severity tags: Critical, Major, Minor
- Boomerang routing:
  - **Critical -> Stage 1 or 2.** The reviewer surfaced a gap the corpus does not cover or a claim the draft does not support. Revise the lit review or the draft and re-run
  - **Major -> Stage 2 or 3.** Methodological weakness or a figure that does not show what the text claims. Revise the section or the figure source
  - **Minor -> in place.** Prose edits; no cycle needed
- Convergence in one shot is a red flag -- same logic as Week 6's grant review

### Part 8: Stage 5 -- Format and Submit (3 min)

- `/manuscript:manuscript-formatting` produces journal-ready LaTeX (Nature, IEEE, NeuroImage, JOSS templates supported)
- `manuscript/` branch is now a proper LaTeX source tree: `main.tex`, `intro.tex`, `methods.tex`, `results.tex`, `discussion.tex`, `references.bib`, `figures/`
- Submission zip: the skill packages exactly what the journal requires (LaTeX + BibTeX + figures + supplements + cover letter). No `.git`, no scratch files

### Part 9: The Overleaf Round-Trip (4 min)

- **Why Overleaf for co-author review.** Real-time multi-author editing, comments, tracked changes; co-authors and advisors mostly do not want to learn git
- **Step 1: Ship a zip.** The submission zip from Stage 5 doubles as the initial Overleaf payload. Upload to a new Overleaf project (Menu -> New Project -> Upload Project)
- **Step 2: Enable Overleaf git.** Overleaf premium accounts expose a git URL per project (Menu -> Sync -> Git). Co-authors edit in the Overleaf UI; the project history is git history
- **Step 3: Clone Overleaf back.** From your local repo, add Overleaf as a remote and pull:
  ```bash
  git remote add overleaf https://git.overleaf.com/<project-id>
  git fetch overleaf
  git checkout -b overleaf-merge overleaf/master
  ```
  Resolve conflicts the usual way; the Overleaf branch lives alongside `manuscript/` and merges in
- **Step 4: The manual comment-merge pass.** This is the step everyone misses. **Overleaf inline comments do not travel through git.** They live in the Overleaf UI only and get lost the moment you clone back. Before you close the Overleaf round, manually read every open Overleaf comment thread and transcribe each comment as either a GitHub issue (if it requires non-trivial work) or a PR comment on the merge PR (if it's a one-line fix). Mark each Overleaf comment "Resolved" only after the transcription lands in the repo
- The bottom line: **Overleaf is a co-author UI on top of your git history, not a replacement for git history.** Treat it as a peripheral, not the source of truth

### Part 10: Response to Reviewers (3 min)

- When the journal sends reviews back, the response letter is a **point-by-point document** with the same cite-the-card discipline used everywhere else in the course
- The skill drafts a structured response: for each reviewer comment, "Response:" then "Change:" then the relative path to the section / line that changed. Vertical change bars in the LaTeX source
- Tone rule (carried in from Week 6 A1 Introduction): **respond, do not rebut.** Rebut only the genuinely wrong critiques

### Part 11: Three Defences -- One per Stage Pair (1 min)

The pipeline's mechanical defences are deliberately stack-redundant:

- **Cite-the-card and cite-the-figure (Stages 1-3).** Every claim links to a paper-card or a figure source. Carried from Week 5
- **Review boomerang (Stage 4).** Critical findings cycle back, not just prose edits. Carried from Week 6
- **Comment-merge pass (Overleaf round-trip).** Overleaf comments are not history; they must be transcribed before the round closes. New this week

### Part 12: Live Walkthrough (5 min)

Topic: a **narrative review on the neural correlates of naturalistic movie watching**, organised by the four perspectives from Week 5 (psychophysics, action, language, emotion). This is the natural next step from Week 5's mini-review on the same corpus.

Pre-built state:

- The Week-5 corpus addressable by relative path (~12-16 paper-cards across the four perspectives)
- A `manuscript/` branch with a stub `main.tex`, `intro.tex`, and `discussion.tex`. Methods and Results are stub-only for a narrative review
- A figures stub for the science-map panel (the perspective-by-method matrix from Week 5)
- A `manuscript-epic` GitHub issue with sub-issues per section, each ready to be claimed

Three live actions:

1. **`/manuscript:manuscript-writing` drafts the introduction paragraph** that synthesises the four perspectives. Cite-the-card discipline visible in the diff
2. **`/manuscript:paper-review` reviews that paragraph.** Whatever the review surfaces, walk through. We do not manufacture a finding. A likely natural one is **uneven perspective coverage** (the four strands have asymmetric card counts in Week 5), in which case the boomerang re-enters Stage 1 with a follow-on `opencite search` call
3. **The Overleaf hand-off described.** Show the zip command, the Overleaf upload screen, the Overleaf git tab, and the `git remote add overleaf` step. We do not actually round-trip live; the moral is the comment-merge caveat slide

### Q&A (15 min)

## Key Concepts

- **Agent loop vs. human loop:** Two different loops with two different tools. Agent loop = GitHub-native, pull requests, `/manuscript:*`. Human loop = Overleaf, comments, tracked changes. The boundary is between Stages 4 and 5.
- **5-stage manuscript pipeline:** Lit review, draft, figures, self-review, format & submit. Bidirectional boomerang on review findings.
- **IMRAD = Aims expanded:** A manuscript Introduction is the Week-6 Specific Aims page expanded. Methods and Results expand the Approach.
- **Cite-the-card / cite-the-figure:** Every claim links to a paper-card or a figure source by relative path. Carried from Week 5.
- **Section-as-sub-issue:** One sub-issue per IMRAD section, one worktree per sub-issue, parallel branches into `manuscript/`. Same shape as Week 3 code.
- **Overleaf git round-trip:** Overleaf supports git natively (premium); the Overleaf project is a remote alongside `origin`. Clone-back keeps a single version history across the agent loop and the human loop.
- **Comment-merge manual pass:** Overleaf inline comments do not travel through git. Before closing an Overleaf round, every open comment is transcribed to a GitHub issue or PR comment, then marked Resolved in Overleaf.
- **Three defences:** Cite-the-card / figure, review boomerang, comment-merge pass. One per stage pair, deliberately stack-redundant.

## Before Next Session

- Install `research-skills` if not already installed; it bundles `manuscript`, `opencite`, `figures`, and `project`
- Confirm your Overleaf account status. The git round-trip requires premium; free-tier users can still upload zips and download zips, but lose the merge-back convenience. Many institutions provide free Overleaf premium; check yours
- Identify the manuscript you are working on (or pick one from the practicum scaffold). The session works whether you bring an empirical paper, a review, or a methods paper
- Optional: skim the [`research-skills` manuscript plugin SKILL.md files](https://github.com/neuromechanist/research-skills/tree/main/plugins/manuscript/skills) to see the section-by-section conventions before the live session

## Common Pitfalls (Watched For in Live Demo)

- **Treating Overleaf as the source of truth.** Once Overleaf becomes the canonical version, your repo loses figure provenance, branch history, and review traceability. The repo stays canonical; Overleaf is a peripheral
- **Skipping the comment-merge pass.** A round of Overleaf review that closes without transcribing comments into the repo loses the comments the moment you clone back. This compounds: by the third round, you have lost weeks of co-author input. The manual pass is non-negotiable
- **Drafting before the lit review.** Same failure mode as Week 5; produces flowing prose that loses every claim under review
- **Using one giant sub-issue for the manuscript.** Same failure mode as Week 3 code; conflicts everywhere and no parallelism. One sub-issue per section
- **Not running `/manuscript:humanizer`.** AI tells survive into the submission unless explicitly stripped. The humanizer pass runs on every section before the PR opens
- **Submitting figures whose sources live on someone's laptop.** When the journal asks for a reproducible figure pipeline, you need the source. The figures stage exists to make this non-optional

## What This Session Does Not Cover

- Bibliographic management UIs (Zotero, Mendeley, EndNote). The pipeline emits BibTeX; the UI is downstream and personal
- Journal-specific submission portals (ScholarOne, Editorial Manager, AJE Author Services). The skill produces the zip; the portal is downstream
- Word documents. The pipeline is LaTeX-first because Overleaf is LaTeX-first. Word-based journals are supported by `/manuscript:manuscript-formatting` emitting a Word target, but the live demo stays on LaTeX
- Co-author negotiation, authorship order, IRB and ethics statements. These are people problems, not tool problems

## Related Sessions

- **Week 5** -- the lit-review pipeline whose corpus this week consumes. The cite-the-card rule transfers verbatim
- **Week 6** -- the Specific Aims and Strategy whose structure is expanded into IMRAD this week. A manuscript Introduction is structurally the Aims expanded
- **Week 8** -- scientific figure design proper. This week's figures stage uses the figures skills; Week 8 covers composition, palette, and panel layout in depth
- **Week 9** -- BIDS / HED inputs; what the Methods section cites
- **Week 10** -- building your own plugins. Some readers will want their own `/manuscript:my-journal-template` skill after this session; Week 10 is how
