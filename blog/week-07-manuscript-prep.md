# Week 7 Guide: Manuscript Preparation and Peer Review

*A manuscript is not a single prompt; it is a managed pipeline that lives in the same git repository, with the same epic and pull-request rigour, until the moment co-authors take the wheel. Five stages, enforced order, bidirectional boomerang on review findings, then a hand-off to Overleaf and a clone-back into git. The single most useful idea in this guide: **the agent loop and the human loop are different loops, and they need different tools**. The agent loop wants pull requests; the human loop wants comments. Picking the wrong tool for the wrong loop is the Week 7 failure mode.*

This guide accompanies [Week 7](../sessions/week-07/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). The session builds directly on Week 5 (literature review) and Week 6 (grant proposals); the corpus from Week 5 is the input, and the Specific Aims structure from Week 6 expands into the full Introduction, Methods, Results, and Discussion (IMRAD) shape this week. One new defence is introduced: a **comment-merge manual pass** that closes the Overleaf round-trip without losing co-author input.

---

## Two Loops, Two Tools

The work splits cleanly into two loops with two different rhythms.

The **agent loop** is where agents and the author co-write, iterate, and self-review inside a single git repository. The artefacts are pull requests, diffs, continuous integration (CI) checks, and the `/manuscript:*` skills bundled in the `research-skills` plugin. Every claim points to a paper-card by relative path; every figure points to its source by relative path. The agent loop is GitHub-native end-to-end.

The **human loop** is where co-authors, advisors, and external reviewers mark up the draft. The artefacts are inline comments, tracked changes, and real-time multi-author editing. This is where Overleaf shines: most co-authors and advisors mostly do not want to learn git, and they should not have to.

Both loops live in the same source-of-truth repo. The boundary lives between Stages 4 (self-review) and 5 (format and submit) of the pipeline. The Overleaf round-trip keeps Overleaf in sync without abandoning version history.

---

## Reframe: IMRAD = Specific Aims Expanded

The whole talk hinges on this reframe. Today's work is not a new shape; it is Week 6's Aims expanded.

- **Introduction** = the **Opening** + the **Overarching goal** sentence from a Specific Aims page, expanded into 4-6 paragraphs.
- **Methods + Results** = the **Approach** section of a Research Strategy, expanded into the methodological detail and the empirical findings.
- **Discussion** = the **Expected Impact** block of an Aims page, refined once you actually have the results to claim it.

The cite-the-card discipline from Week 5 transfers verbatim: every claim in the manuscript points to a `card.md` by relative path. A reader who paid attention in Week 6 has already done 70% of the manuscript Introduction.

---

## The 5-Stage Manuscript Pipeline

```text
[ 1. Lit review ] -> [ 2. Draft ] -> [ 3. Figures ] -> [ 4. Self-review ] -> [ 5. Format & submit ]
        ^                                                       |
        +-------------------------------------------------------+
                              boomerang on findings

  ============================== agent loop ==============================|=== human loop ===
                              ( GitHub-native )                              ( Overleaf )
```

Five stages, enforced order. Drafting before the lit review produces unsupported claims; formatting before the self-review polishes a draft that may still get cycled. Stages 1-4 are the agent loop; Stage 5 invites the human loop in.

| Stage | Tool | Output |
|-------|------|--------|
| 1. Lit review | `/manuscript:lit-review`, `/opencite:opencite`, `/manuscript:manuscript-formatting` (picks the structure) | `lit-review/` corpus + a chosen review structure (mini-review, scoping, narrative, systematic, or IMRAD background) |
| 2. Draft | `/manuscript:manuscript-writing`, `/manuscript:humanizer` | `manuscript/intro.tex`, `methods.tex`, `results.tex`, `discussion.tex` with cite-the-card discipline |
| 3. Figures | `/figures:scientific-figure`, `/figures:svg-figure`, `/figures:plot-styling` | `figures/<panel>/source.svg` and rendered `figures/<panel>/figure.pdf` |
| 4. Self-review | `/manuscript:paper-review` | Severity-tagged findings; boomerang back to Stage 1, 2, or 3 |
| 5. Format & submit | `/manuscript:manuscript-formatting`, Overleaf round-trip, manual comment-merge pass | Submission zip + cover letter + response-to-reviewers letter (if revision) |

---

## Stage 1: Lit Review (Inherits Week 5)

The Week-5 corpus is the input. No new collection step today. What is new is the structure-picker: `/manuscript:manuscript-formatting` reads the corpus and offers five review-type options (mini-review, scoping review, narrative review, systematic review, or IMRAD background paragraph), each with its own outline scaffold.

For the live demo we use **narrative review** -- the natural next step after Week 5's mini-review on the same naturalistic-movie corpus, organised by the four perspectives (psychophysics, action, language, emotion). For trainees writing methods papers or empirical papers, the same picker offers IMRAD background.

The cite-the-card discipline transfers: every claim in the manuscript points to a `card.md` by relative path. No card, no claim.

---

## Stage 2: Draft -- IMRAD Section Conventions

The `manuscript-writing` skill enforces section conventions that are not arbitrary; they make reviewers' jobs faster.

| Section | Tense | Length (rough) | Anti-pattern |
|---------|-------|---------------|--------------|
| Title | -- | <= 15 words | Question-mark titles unless rhetorical |
| Introduction | Present (lit), past (claims) | 4-6 paragraphs | Generic openings ("Recent advances...") |
| Methods | Past | As long as needed for replication | Hedging ("we tried...") |
| Results | Past, statistics-led | One paragraph per claim | **Interpretation in Results** |
| Discussion | Mixed | 5-8 paragraphs | Restating Results without new framing |

The hardest convention to internalise: **no interpretation in Results.** That belongs in the Discussion, paragraph 1. The skill catches the most common failure mode and flags it before the pull request opens.

---

## Section-as-Sub-Issue: The Week 3 Pattern for Prose

Trainees who learned the epic-plus-sub-issue-plus-worktree pattern from Week 3 will recognise the shape instantly. One sub-issue per IMRAD section, one worktree per sub-issue:

- `feature/issue-N-intro`, `feature/issue-N-methods`, `feature/issue-N-results`, `feature/issue-N-discussion`
- Each worktree branches from a long-lived `manuscript/` branch
- Pull requests land back into `manuscript/`
- `manuscript/` merges to `main` only at submission time

The four section worktrees mean four people (or four passes by one person) can work concurrently without merge-conflict roulette. `main` only sees the submitted version, which makes the history easy to audit.

---

## /manuscript:manuscript-writing -- Cite-the-Card in the Diff

The skill is a workflow, not a one-shot draft. It drafts paragraphs section-by-section, inserts cite-the-card relative links inline as it writes, and runs `/manuscript:humanizer` on the section before the pull request opens.

```bash
$ /manuscript:manuscript-writing

# writes (per worktree):
manuscript/intro.tex
manuscript/methods.tex
manuscript/results.tex
manuscript/discussion.tex
```

Every claim points to a paper-card. No card, no claim. The humanizer pass at the end is non-optional; it strips AI fingerprints (em-dashes, rule-of-three patterns, AI-tell vocabulary) and ensures abbreviations are defined on first use. The same humanizer pass is used in Week 6 for grant prose and applies identically here.

---

## Stage 3: Figures Live in the Repo

Three skills, one discipline. The discipline is: **figure source lives next to the manuscript**, not on someone's laptop, not in a Dropbox.

- `/figures:scientific-figure` composes multi-panel figures at exact journal dimensions (Nature 89/183 mm, Science 55/120 mm, Cell 85/174 mm, PNAS 87/180 mm). It validates font sizes against journal minima before export.
- `/figures:svg-figure` produces vector schematics with aligned text and arrows -- the same skill that drew most of this week's slide icons.
- `/figures:plot-styling` applies journal-specific palette, typography, and axis tick density to matplotlib or ggplot output.

Week 8 is figure design proper (composition, palette, panel layout, narrative); today is the workflow. The directory layout:

```text
manuscript/
  figures/
    panel-a/
      source.svg          # tracked in git
      caption.tex         # tracked in git
      figure.pdf          # gitignored (build artefact)
    panel-b/
      source.py           # tracked in git
      caption.tex         # tracked in git
      figure.pdf          # gitignored
```

Sources commit. Builds do not (they would bloat the repo and rot under format changes). Captions ship next to figures so when a figure moves between manuscripts, the caption moves with it. The LaTeX `\includegraphics{figures/panel-a/figure.pdf}` resolves at build time; the caption file is `\input`ed.

**Cite-the-figure is cite-the-card for figures.** When the journal asks for a reproducible figure pipeline, you have it. When a reviewer challenges a panel, the script that built it is one click away.

---

## Stage 4: /manuscript:paper-review and the Boomerang

`/manuscript:paper-review` plays the peer-reviewer role on the manuscript draft. It is the same skill used in Week 5 (lit review review) and shares the severity tagging.

The skill scores the draft against IMRAD conventions, statistical reporting standards (Consolidated Standards of Reporting Trials (CONSORT) where applicable, the American Psychological Association (APA) Journal Article Reporting Standards (JARS), the Strengthening the Reporting of Observational studies in Epidemiology (STROBE) checklist), and basic ethics, then tags findings by severity:

- **Critical findings -> Stage 1 or 2.** The reviewer surfaced a corpus gap or an unsupported claim. Revise the lit review or the draft and re-run the pipeline.
- **Major findings -> Stage 2 or 3.** Methodological weakness or a figure that does not show what the text claims. Revise the section or the figure source.
- **Minor findings -> in place.** Prose edits; no cycle needed.

**Convergence in one shot is a red flag.** First-draft convergence means the review is shallow or the draft is hiding something. Run a second pass with adversarial framing if the first converges too cleanly.

---

## Stage 5: Format and Submit (Still in the Repo)

`/manuscript:manuscript-formatting` packages the LaTeX source tree into a journal-ready zip. Nature, IEEE, NeuroImage, eLife, the Journal of Open Source Software (JOSS), PLOS, and a handful of generic templates are supported out of the box; adding a new journal is a small skill PR.

```text
paper-submission.zip
  main.tex
  intro.tex
  methods.tex
  results.tex
  discussion.tex
  references.bib
  figures/
    panel-a/figure.pdf
    panel-b/figure.pdf
  cover-letter.tex
  supplements/
```

The zip is a deliberate contract: it includes exactly what the journal asked for, nothing else. `.git`, scratch directories, and figure source files (SVG, Python scripts) are excluded by design. **One artefact, two destinations.** The same zip ships to the journal portal at submission time, or to Overleaf when co-authors take the wheel.

---

## Overleaf Round-Trip Step 1: Ship a Zip

Co-authors and advisors mostly do not want to learn git. They want Overleaf. The Stage-5 submission zip doubles as the initial Overleaf payload.

In Overleaf: **Menu -> New Project -> Upload Project**, drag the zip. One artefact you already built. Zero new tooling. No fresh formatting.

Frame this for your co-authors: your advisor does not have to clone your repository. They open Overleaf, they see your draft. Friction removed.

---

## Overleaf Round-Trip Step 2: Enable Overleaf Git

Overleaf premium exposes a **per-project git URL** (Menu -> Sync -> Git). The Overleaf project history IS git history; every save in the Overleaf editor is a commit on the Overleaf `master` branch.

Many institutions provide free Overleaf premium through site licences -- the University of California system, MIT, Stanford, EPFL, and many EU universities are on the list. Check yours before paying out of pocket.

Without the git URL, Overleaf becomes an island and the round-trip degenerates to manual copy-paste. The git URL is the slide that makes the round-trip possible.

---

## Overleaf Round-Trip Step 3: Clone Back

Overleaf is a **remote alongside `origin`**. From your local repository:

```bash
git remote add overleaf https://git.overleaf.com/<project-id>
git fetch overleaf
git checkout -b overleaf-merge overleaf/master
```

The `overleaf-merge` branch sits in the same repository. Reviews, conflict resolution, and merge happen exactly like any other pull request. The branch merges back into `manuscript/`; `manuscript/` merges to `main` only at submission time.

---

## Overleaf Round-Trip Step 4: The Comment-Merge Manual Pass

This is the new defence introduced this week. Overleaf inline comments are inline, threaded, and tied to a text selection in the LaTeX. They feel natural to use, which is why co-authors leave a lot of them.

**These comments do NOT travel through git.** They live in the Overleaf UI only and disappear the moment you clone back.

The fix is a manual pass at the end of every Overleaf round:

1. For each open Overleaf comment, decide whether the response is a one-line fix or non-trivial work.
2. **One-line fix -> PR comment** on the `overleaf-merge` pull request, with the same anchor in the LaTeX source so the reviewer can see it.
3. **Non-trivial work -> GitHub issue** linked from the `overleaf-merge` pull request, with the Overleaf thread quoted verbatim.
4. **Mark each Overleaf comment "Resolved" only after the transcription lands in the repo.**

A round of Overleaf review that closes without transcribing comments into the repository loses the comments the moment you clone back. By the third round, you have lost weeks of co-author input. The manual pass is non-negotiable.

---

## Response to Reviewers -- Point by Point

When the journal sends reviews back, the response letter is a **point-by-point document** with the same cite-the-card discipline used everywhere else in the course. The same shape as Week 6's A1 Introduction page.

Structure (per reviewer comment):

```text
Reviewer 1, Comment 2 (page 4, lines 112-118):
  > [verbatim reviewer comment]

Response: [one-paragraph response, no rebuttal unless the critique is wrong]
Change:   [one-sentence description of what changed and where]
          [relative path: e.g., manuscript/methods.tex:42]
```

Vertical change bars run alongside the response column in the rendered PDF so the reviewer can see at a glance what moved. The skill drafts the structure and inserts the change bars automatically.

**Tone rule:** respond, do not rebut. Rebut only the genuinely wrong critiques. Reviewers see defensive rebuttals more critically than they see corrected manuscripts.

---

## Three Defences -- One per Stage Pair

The pipeline's mechanical defences against thumb-on-scale are deliberately stack-redundant. **None alone is sufficient.**

- **Cite-the-card and cite-the-figure (Stages 1-3).** Every claim links to a paper-card or a figure source. Guards against hallucinated citations and against figures that do not show what the text claims. Carried from Week 5.
- **Review boomerang (Stage 4).** Critical findings cycle back to lit review or draft, not just to prose edits. Guards against one-shot convergence. Carried from Week 6.
- **Comment-merge pass (Overleaf round-trip).** Overleaf comments are not history; they must be transcribed before the round closes. New this week.

The Overleaf round closes only after the comments land in the repository.

---

## Live Walkthrough -- The Practicum

The Week 7 session ends with a live walkthrough using the Week-5 corpus as the input. Topic: a **narrative review on the neural correlates of naturalistic movie watching**, organised by the four perspectives from Week 5 (psychophysics, action, language, emotion).

Pre-built state in [`sessions/week-07/practicum/`](https://github.com/OpenScience-Collective/agentic-research-course/tree/main/sessions/week-07):

- The Week-5 corpus addressable by relative path (~12-16 paper-cards across the four perspectives)
- A `manuscript/` branch with a stub `main.tex`, `intro.tex`, and `discussion.tex`. Methods and Results are stub-only for a narrative review
- A figures stub for the science-map panel (the perspective-by-method matrix from Week 5)
- A `manuscript-epic` GitHub issue with sub-issues per section, each ready to be claimed

Three live actions:

1. **`/manuscript:manuscript-writing` drafts the synthesis paragraph** that ties the four perspectives together. Cite-the-card discipline visible in the diff (~1:30 on stage).
2. **`/manuscript:paper-review` reviews that paragraph.** Whatever the review surfaces, walk through. We do not manufacture a finding. A likely natural one is **uneven perspective coverage** -- the four strands have asymmetric card counts in Week 5, so the review may flag the language strand as under-supported. If that surfaces, the boomerang re-enters Stage 1 with a follow-on `/opencite:opencite` call (~2:30 on stage).
3. **The Overleaf hand-off described.** We show the zip command, the Overleaf upload screen, the Overleaf git tab, and the `git remote add overleaf` step. We do not actually round-trip live; the moral is the comment-merge caveat (~1:00 on stage).

The Overleaf round-trip is described with screenshots, not run live -- the moral is the comment-merge slide, not a demo.

---

## Before Next Week

- Install [`research-skills`](https://github.com/neuromechanist/research-skills) if not already installed; it bundles `manuscript`, `opencite`, `figures`, `grant`, `neuroinformatics`, `project`, and `presentation`.
- Confirm your Overleaf account status. The git round-trip requires Overleaf premium; free-tier users can still upload zips and download zips, but lose the merge-back convenience. Many institutions provide free Overleaf premium through site licences; check yours.
- Identify the manuscript you are working on (or pick one from the practicum scaffold). The workflow works whether you bring an empirical paper, a review, or a methods paper.
- Bring an existing manuscript draft (any section, any state) if you have one; the Week 7 office hours pass it through `/manuscript:paper-review` in real time.

Week 8 starts where this week's Stage 3 left off: composition, palette, panel layout, and scientific narrative for figures -- the things this week's figures stage used but did not teach.
