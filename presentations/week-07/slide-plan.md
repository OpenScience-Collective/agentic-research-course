# Week 7 Slide Plan

## Target: 22 slides, ~30 min presentation, then ~5 min live walkthrough + 15 min Q&A

**Core message.** A manuscript is a managed pipeline that stays GitHub-native while agents and humans co-write, and moves to Overleaf only when external co-authors take the wheel. Two loops, two tools: agent loop = pull requests; human loop = comments. The Overleaf round-trip closes via direct git clone-back; the manual comment-merge pass is non-negotiable because Overleaf inline comments do not travel through git.

The pipeline shape is the same as Week 5 (lit review) and Week 6 (grant proposal): 5 stages with a boomerang from review back to drafting. What is new this week: IMRAD structure; journal-formatting concerns; the figures component; the Overleaf hand-off.

The tone matches Weeks 3-6: thesis up front, every theoretical point lands on the worked example (a narrative review on the neural correlates of naturalistic movie watching, building on the Week-5 corpus).

## Slide Inventory

### Opening (3 min)

1. **Title** -- "Week 7: Manuscript Preparation and Peer Review." Author, course / Discord / recording links.
2. **Where we are** -- Weeks 1-6 recap with one bullet each. Today: full IMRAD manuscript, GitHub-native end-to-end except the human-review pass.

### The two loops (3 min)

3. **Two loops, two tools** -- Agent loop = GitHub-native, pull requests, `/manuscript:*` skills. Human loop = Overleaf, comments, tracked changes. Different work, different tools. Asset: `two-loops.svg` (left side: PR with diff and CI; right side: Overleaf editor with comment threads).
4. **Where the loops meet** -- Both loops live in the same source-of-truth repo. The boundary is between Stages 4 and 5. The Overleaf round-trip keeps Overleaf in sync without abandoning version history. Asset: `loops-meet.svg` (a Venn or a handshake between the two icons from slide 3).

### Reframe and pipeline (2 min)

5. **IMRAD = Aims expanded** -- A manuscript Intro is the Week-6 Specific Aims expanded; Methods and Results expand the Approach; Discussion is what Expected Impact aspires to. Cite-the-card transfers verbatim. Asset: `imrad-as-aims.svg` (a Week-6 Aims page on the left fanning out into IMRAD blocks on the right).
6. **The 5-stage manuscript pipeline (hero)** -- Lit review -> Draft -> Figures -> Self-review -> Format & submit, with boomerang from Stage 4 back to Stages 1-3, and a vertical divider between Stages 4 and 5 labelled "agent loop | human loop." Asset: `manuscript-pipeline.svg`.

### Stage 1: Lit review (2 min)

7. **Stage 1 -- Lit review (inherits Week 5)** -- Week-5 corpus is the input. `/manuscript:manuscript-formatting` picks the structure; live demo uses narrative review. Cite-the-card transfers. Asset: `stage-1-lit-review.svg` (a corpus folder feeding into a structure-picker).

### Stage 2: Draft (4 min)

8. **IMRAD section conventions** -- Table by section: tense, length guide, voice. Highlight Methods (past, replication detail) and Results (past, statistics-led). Asset: `imrad-conventions.svg` (a 4x4 table-as-graphic).
9. **Section-as-sub-issue** -- One sub-issue per IMRAD section, one worktree per sub-issue. Same shape as Week 3 code. Asset: `section-as-subissue.svg` (an epic at top branching into intro/methods/results/discussion worktrees, each pointing to a PR into `manuscript/`).
10. **/manuscript:manuscript-writing** -- Drafts each section with IMRAD conventions; `/manuscript:humanizer` runs before the PR opens. Asset: `manuscript-writing-skill.svg` (mock terminal showing skill output + a diff hunk).

### Stage 3: Figures (3 min)

11. **Figures live in the repo** -- `/figures:scientific-figure` for composed figures, `/figures:svg-figure` for vector schematics, `/figures:plot-styling` for journal style. Figure source lives next to the manuscript. Asset: `figures-skills.svg` (three icons: composer, schematic, palette).
12. **Figures directory layout** -- `figures/<panel>/source.svg` tracked; `figures/<panel>/figure.pdf` built on demand, gitignored. Text cites `figure.pdf`; caption cites the source script. Asset: `figures-tree.svg` (a tree view with tracked / gitignored badges).

### Stage 4: Self-review (3 min)

13. **/manuscript:paper-review and the boomerang** -- Severity tags (Critical, Major, Minor); boomerang routes by severity to Stage 1 / 2 / 3. Convergence in one shot is a red flag. Asset: `manuscript-boomerang.svg` (the five-stage pipeline with severity-tagged findings flowing along the boomerang arrow).

### Stage 5 and Overleaf round-trip (5 min)

14. **Stage 5 -- Format and submit** -- `/manuscript:manuscript-formatting` produces journal-ready LaTeX; submission zip packages what the journal requires. Asset: `stage-5-submit.svg` (a LaTeX tree compressing into a `submission.zip`).
15. **Overleaf round-trip step 1 -- Ship a zip** -- Co-authors and advisors want Overleaf, not git. The Stage-5 zip doubles as the Overleaf payload. Asset: screenshot `archive-zip-tree.png`.
16. **Overleaf round-trip step 2 -- Enable Overleaf git** -- Overleaf premium exposes a git URL per project. The Overleaf project history is git history. Asset: screenshot `overleaf-git-tab.png`.
17. **Overleaf round-trip step 3 -- Clone back** -- `git remote add overleaf ...`, `git fetch overleaf`, `git checkout -b overleaf-merge overleaf/master`. Asset: `overleaf-clone-back.svg` (terminal mock + a branch graph showing `manuscript/` and `overleaf-merge` converging).
18. **Overleaf round-trip step 4 -- The comment-merge manual pass** -- Overleaf inline comments do NOT travel through git. Transcribe every open comment to a GitHub issue or PR comment before closing the round. Asset: screenshot `overleaf-comments-ui.png` + `comment-merge-flow.svg` (Overleaf comment arrow -> issue / PR comment, mark Resolved).

### Response to reviewers (1 min)

19. **Response to reviewers -- point by point** -- Same shape as Week 6's A1 Introduction. For each comment: Response then Change then a relative path. Vertical change bars in the LaTeX source. Tone rule: respond, do not rebut. Asset: `response-letter.svg` (a two-column layout: reviewer comments on the left, point-by-point responses on the right).

### Three defences and close (3 min plus 5 min live)

20. **Three defences -- one per stage pair** -- Cite-the-card / figure (Stages 1-3), review boomerang (Stage 4), comment-merge pass (Overleaf round-trip). Deliberately stack-redundant. Asset: `three-defences-manuscript.svg` (three shields stacked, one labelled new-this-week).
21. **Live demo roadmap** -- Topic: narrative review on naturalistic movie watching, four perspectives. Pre-built: Week-5 corpus + manuscript stubs + figures stub + manuscript epic. Three live actions; Overleaf round-trip is described with screenshots, not run live. Asset: `demo-roadmap.svg` (three steps with timing badges).
22. **What today gives you / what's next** -- Today: a manuscript pipeline GitHub-native through the agent loop, surviving the Overleaf round-trip with version history. Next: Week 8 scientific figure design proper.

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 3 min |
| Two loops | 2 | 3 min |
| Reframe + pipeline | 2 | 2 min |
| Stage 1 | 1 | 2 min |
| Stage 2 | 3 | 4 min |
| Stage 3 | 2 | 3 min |
| Stage 4 | 1 | 3 min |
| Stage 5 + Overleaf round-trip | 5 | 5 min |
| Response letter | 1 | 1 min |
| Three defences + close | 3 | 3 min |
| **Total** | **22** | **~30 min** |

Live walkthrough (~5 min) + Q&A (~15 min) fill the remaining time.

## Animation Discipline

Same as Weeks 5 and 6. Every multi-bullet slide and every multi-line code block uses **fragment animations** so a single concept is on screen at a time:

- Bullets stagger in (one per click)
- Code blocks reveal line by line
- Diagrams use **build-on-click**: stage labels before arrows; the agent-loop / human-loop divider appears last on the hero
- Side callouts appear after main content

Reference: `presentations/week-05/presentation.json` and `presentations/week-06/presentation.json`.

## Assets Produced (via `/figures:scientific-figure` and `/figures:svg-figure`, hand-crafted SVG)

All ship in [`assets/icons/`](../../assets/icons/) unless noted. Hand-crafted SVG, no mermaid. Where icon composition needs creative work, the figures skill delegates to codex / OpenAI image generation, then the result is converted to an SVG composition.

- `two-loops.svg` -- slide 3. Two columns: left side a pull-request mock with diff and CI checks; right side an Overleaf editor mock with inline comment threads. Title bar at top labelled "agent loop | human loop".
- `loops-meet.svg` -- slide 4. The two icons from slide 3 facing inward across a vertical divider, with a curved arrow showing the boundary between Stages 4 and 5 of the pipeline.
- `imrad-as-aims.svg` -- slide 5. A Week-6 Aims page rendering on the left fanning out into four IMRAD blocks (Intro, Methods, Results, Discussion) on the right. Same headline sentence highlighted in both.
- `manuscript-pipeline.svg` -- slide 6, the hero. Five labelled stages in a horizontal flow with a curved boomerang arrow returning from Stage 4 to Stages 1-3. Vertical divider between Stages 4 and 5 labelled "agent loop | human loop".
- `stage-1-lit-review.svg` -- slide 7. A corpus folder (paper-cards from Week 5) feeding into a structure-picker (mini / scoping / narrative / systematic / IMRAD background) with "narrative" highlighted.
- `imrad-conventions.svg` -- slide 8. A 4-row by 4-column table-as-graphic: rows are sections (Intro, Methods, Results, Discussion); columns are Tense, Length, Voice, Anti-pattern. Methods and Results rows highlighted.
- `section-as-subissue.svg` -- slide 9. An epic at top branching into four parallel sub-issues (intro / methods / results / discussion), each leading to a worktree branch, each merging into a `manuscript/` branch.
- `manuscript-writing-skill.svg` -- slide 10. Two panels: mock terminal showing `/manuscript:manuscript-writing` output on the left; a diff hunk with cite-the-card relative links highlighted on the right.
- `figures-skills.svg` -- slide 11. Three icons in a row: composer (multi-panel figure), schematic (single-panel SVG), palette (journal style). Each icon has its skill name below.
- `figures-tree.svg` -- slide 12. A folder tree view of `figures/`, with tracked badges on `source.svg` / `source.py` / `source.R` and gitignored badges on `figure.pdf`.
- `manuscript-boomerang.svg` -- slide 13. The five-stage pipeline with severity-tagged findings (Critical / Major / Minor chips) flowing along the boomerang arrow.
- `stage-5-submit.svg` -- slide 14. A LaTeX source tree compressing into a `submission.zip` icon with a cover-letter and a figures-folder badge.
- `overleaf-clone-back.svg` -- slide 17. A terminal mock showing `git remote add overleaf ...` and the resulting branch graph with `manuscript/`, `overleaf-merge`, and the merge PR.
- `comment-merge-flow.svg` -- slide 18 sidebar. An Overleaf comment icon with an arrow pointing to a GitHub issue / PR comment icon; the Overleaf comment is then marked Resolved.
- `response-letter.svg` -- slide 19. A two-column page: reviewer comment on the left, point-by-point response on the right (Response: ..., Change: ..., relative path). Vertical change bar in the right column.
- `three-defences-manuscript.svg` -- slide 20. Three shields stacked: cite-the-card / figure (Stages 1-3), review boomerang (Stage 4), comment-merge pass (Overleaf round-trip; new this week, marked with a "new" badge).
- `demo-roadmap.svg` -- slide 21. Three steps in a horizontal flow with timing badges (1:30, 2:30, 1:00 for the three live actions); a fourth "described, not run" badge for the Overleaf round-trip.

## Screenshots Needed (3, all from the user)

The user provides these because they are UI-bound and cannot be SVG-mocked credibly:

- `assets/screenshots/archive-zip-tree.png` -- slide 15. The Stage-5 submission zip moment: Finder showing `paper-submission.zip` with the file tree expanded, OR terminal showing the `zip` command + `unzip -l` listing.
- `assets/screenshots/overleaf-git-tab.png` -- slide 16. The Overleaf project Menu -> Sync -> Git panel showing the project's git URL. Blur the token.
- `assets/screenshots/overleaf-comments-ui.png` -- slide 18. Overleaf editor with a few inline review comments visible in the right panel. The "comments do not travel through git" moral.

All other UI moments (skill outputs, PR comments, worktree views, response letter, manuscript PDF) ship as hand-crafted SVG mocks via the asset list above.

## Live-Demo Pre-Built State

In `sessions/week-07/practicum/` ship:

- `README.md` restating the practicum topic (narrative review on naturalistic movie watching, four perspectives) and the three live actions
- `manuscript/` branch with stubs: `main.tex`, `intro.tex` (one stub paragraph), `discussion.tex` (one stub paragraph). Methods and Results are intentionally absent for a narrative review
- `lit-review/` symlink (or relative path) back to `sessions/week-05/practicum/collection/` so the four-perspective corpus is addressable
- `figures/science-map/source.svg` -- the perspective-by-method matrix from Week 5, ready to be cited from the intro
- `manuscript-epic.md` -- the epic-issue body with four sub-issues per section
- `references.bib` aggregated from the four Week-5 strand `.bib` files

Three live actions:

1. **`/manuscript:manuscript-writing` drafts the introduction paragraph** that synthesises the four perspectives. Cite-the-card discipline visible in the diff (one link per claim, all to `lit-review/<perspective>/<slug>/card.md`).
2. **`/manuscript:paper-review` critiques that paragraph.** Whatever the review surfaces, walk through. Likely natural finding: uneven perspective coverage (Week 5 strands have asymmetric card counts) -- if it surfaces, we describe the boomerang back to Stage 1 with a follow-on `opencite search` call. We do not run the follow-on on stage.
3. **The Overleaf hand-off described.** Show the zip command output, the Overleaf upload screen, the Overleaf git tab, and the `git remote add overleaf` step. Do not run the round-trip live; the moral is the comment-merge caveat (slide 18).

## Open Decisions -- Resolved

- **Live-demo topic:** narrative review on naturalistic movie watching, four perspectives. Chosen because the empirical HBN ERSP paper is not yet ready (parked in [`/Users/yahya/Documents/git/paper-ideas/hbn-ersp-animacy.md`](../../../paper-ideas/hbn-ersp-animacy.md)) and a methods paper on `matlab-mcp` is also parked there. The review-paper demo continues the Week-5 corpus cleanly.
- **Response-to-reviewers scope:** light coverage (~1 min, slide 19). Same point-by-point shape as Week 6's A1 Introduction beat.
- **Overleaf round-trip demo style:** described with screenshots, not run live. Reasons: premium Overleaf is not universal; the comment-merge caveat is the moral, and that is best made on a slide rather than in a live demo where the comment thread distracts from the point.
- **Slide 1 housekeeping:** confirmed. Title + course / Discord / recording links on slide 1. Slide 2 recaps Weeks 1-6.
