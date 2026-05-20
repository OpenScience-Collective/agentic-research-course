# Week 6 Slide Plan

## Target: 22 slides, ~30 min presentation, then ~5 min live walkthrough + 15 min Q&A

**Core message.** A grant proposal is a managed pipeline, not a long prompt. Five stages (NOFO, Aims, Strategy, Self-review, Figure QA), enforced order, bidirectional boomerang on review findings. The Week-5 corpus is the input; the obligation today is deliverables on the page and defending them against a simulated reviewer panel. Three new beats: agent-agnostic plugins (Claude Code, Codex CLI, Copilot in VS Code), `/grant:grant-review` for calibrated self-review, and `/grant:grant-figure-qa` that reads the rendered PDF visually.

The tone matches Weeks 3-5: thesis up front, every theoretical point lands on the HBN movie-EEG practicum, every tool decision is justified by *why it improves research output*. The worked example is an R21 NIMH naturalistic-stimuli proposal built from the Week-5 corpus.

## Slide Inventory

### Opening (3 min)

1. **Title** -- "Week 6: Grant Proposal Writing." Author, course link, Discord link, recording link.
2. **Where we are** -- Weeks 1-5 recap with one bullet each. Today: same pipeline shape, new artefact, deliverables on the page.

### Agent-agnostic and accessibility (4 min)

3. **research-skills is now agent-agnostic** -- Three runtimes (Claude Code, Codex CLI, Copilot in VS Code); same seven plugins; same slash commands, prompts, outputs. Asset: `agent-agnostic-trio.svg` showing three runtime logos converging into the same plugin set.
4. **Why this matters -- accessibility** -- A first-year doctoral student with a free GitHub Education pack can now run `/grant:grant-writing` without a paid Claude Pro subscription. Asset: `agent-accessibility.svg` (three doors into the same room).

### Reframe and pipeline (3 min)

5. **Aims = 1-page lit review + deliverables** -- Week-5 corpus is the input; cite-the-card transfers verbatim. The new obligation: measurable deliverables on a timeline. Definition of Done shifts. Asset: composition built into the slide layout.
6. **The 5-stage grant pipeline (hero)** -- NOFO -> Aims -> Strategy -> Self-review -> Figure QA with boomerang from Stage 4 to Stages 2 and 3. Asset: `grant-pipeline.svg`.

### Mechanism and scoring (3 min)

7. **Pick the mechanism first** -- Cheatsheet table: R01, R21, R03, K99/R00, F31/F32, NSF CAREER. Audience, page budgets, dollar caps, cycles. Asset: `mechanism-cheatsheet.svg`. Punchline: "Submitting a K-award as an R-award gets returned without review."
8. **What reviewers score** -- Five NIH criteria on 1-9 plus integrated impact (not the mean). Most rejections land on Approach. Asset: `nih-scoring.svg`.

### Step 0 and Step 1 (3 min)

9. **Step 0 -- Parse the NOFO** -- `/grant:grant-writing` writes `NOFO.md`, the scope contract. Every aim, methods choice, and budget line points back. Asset: `nofo-contract.svg` with an annotated `NOFO.md` snippet.
10. **Step 1 -- Page budget allocation** -- R01 vs R21 vs F31 / F32 starting allocations. Trim content, never spacing. Asset: `page-budget.svg`.

### Step 2: Specific Aims page (5 min)

11. **Anatomy of a Specific Aims page** -- Six blocks in order, ~650 words on one page. Reviewers spend ~10 minutes on this one page. Asset: `aims-anatomy.svg` -- a one-page rendering with the six blocks annotated.
12. **/grant:grant-writing -- what the skill does** -- Workflow, not one-shot. Parses NOFO, allocates pages, drafts Aims (6-block), drafts Significance / Innovation / Approach with cite-the-card, calls `manuscript:humanizer`. Output tree on slide.
13. **Style rules the skill enforces** -- Bold strategically, italicise hypothesis labels, active voice with quantification, no em-dashes, define abbreviations on first use. Asset: `style-rules.svg`.

### Step 3: Research Strategy (5 min)

14. **Research Strategy = Significance / Innovation / Approach** -- Fixed order; the agent will not draft them out of order. Page proportions on slide. Asset: `strategy-three-parts.svg`.
15. **Approach -- every aim has the same 6-block anatomy** -- Rationale, Methods, Hypothesis, Analyses, Expected outcomes, Problems & alternatives. Block 6 is what reviewers look for first. Asset: `approach-aim-block.svg`.
16. **Rigor, preliminary data, timeline** -- Rigor & reproducibility cites Week 9 content; preliminary data shows feasibility + effect-size estimate; timeline Gantt with milestone diamonds. Asset: `rigor-timeline.svg`.

### Step 4 and resubmission (4 min)

17. **/grant:grant-review -- simulated study section** -- Scores all five criteria on 1-9 + integrated impact. Boomerang routing by severity (Critical -> Aims, Major -> Strategy, Minor -> in place). Renders PDF pages to PNG for visual review. Asset: `grant-boomerang.svg`.
18. **Resubmissions (A1) -- the Introduction page** -- Separate 1-page Introduction; respond, do not rebut. Skill drafts and inserts vertical change bars in the Strategy LaTeX. Asset: `resubmission-a1.svg`.

### Step 5: Figure QA (2 min)

19. **/grant:grant-figure-qa -- compliance pass** -- Converts each PDF page to PNG, reads visually. Checks resolution >= 300 dpi, embedded fonts, colour-blind safe palette, axis legibility at 50%, statistical reporting, caption tightness, whitespace economy. Asset: `figure-qa.svg`.

### Three defences and close (3 min plus 5 min live)

20. **Three defences -- one per stage** -- NOFO contract, cite-the-card, review boomerang. Deliberately stack-redundant; none alone is sufficient. Asset: `three-defences-grant.svg`. Punchline: "A grant that passes on the first self-review either has nothing to say or is hiding what it found."
21. **Live demo roadmap** -- Topic: R21 Specific Aims page for the HBN naturalistic-movie practicum (animacy-of-opening-shot ERSP question from Week 3). Pre-built: NOFO + four anchor cards + draft stub. Three live actions; we do not manufacture a finding.
22. **What today gives you / what's next** -- Today: an Aims page where every claim points at a Week-5 paper-card and the self-review has cycled at least once. Next: Week 7 manuscript prep -- the Introduction is the Aims expanded; Methods and Results expand the Approach.

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 3 min |
| Agent-agnostic + accessibility | 2 | 4 min |
| Reframe + pipeline | 2 | 3 min |
| Mechanism + scoring | 2 | 3 min |
| Step 0 + Step 1 | 2 | 3 min |
| Step 2 Aims page | 3 | 5 min |
| Step 3 Strategy | 3 | 5 min |
| Step 4 review + resubmission | 2 | 4 min |
| Step 5 Figure QA | 1 | 2 min |
| Three defences + close | 3 | 3 min |
| **Total** | **22** | **~30 min** |

Live walkthrough (~5 min) + Q&A (~15 min) fill the remaining time.

## Animation Discipline

Same as Week 5. Every multi-bullet slide and every multi-line code block uses **fragment animations** so a single concept is on screen at a time:

- Bullets stagger in (one per click)
- Code blocks and YAML snippets reveal line by line
- Diagrams use **build-on-click**: stage labels appear before arrows; the boomerang appears last
- Side callouts (rationale, warnings) appear after main content, not simultaneously

Reference: `presentations/week-05/presentation.json`.

## Assets Produced (via `/figures:scientific-figure`, hand-crafted SVG)

All ship in [`assets/icons/`](../../assets/icons/). Hand-crafted SVG, no mermaid. Where icon composition needs creative work, the figures skill delegates to codex / OpenAI image generation, then the result is converted to an SVG composition.

- `agent-agnostic-trio.svg` -- slide 3. Three runtime logos (Claude Code, Codex CLI, Copilot in VS Code) converging into one plugin set.
- `agent-accessibility.svg` -- slide 4. Three doors into the same room; a student with a GitHub Education badge walks through any of them.
- `grant-pipeline.svg` -- slide 6, the hero. Five stages with NOFO contract icon, Aims page icon, Strategy three-part icon, review-with-boomerang icon, figure-QA magnifier. Boomerang curve from Stage 4 to Stages 2 / 3.
- `mechanism-cheatsheet.svg` -- slide 7. Table-as-graphic with six rows (R01, R21, R03, K99/R00, F31/F32, NSF CAREER) and four columns (audience, page budget, dollar cap, cycle).
- `nih-scoring.svg` -- slide 8. The 1-9 scale with anchor labels (1 Exceptional, 5 Good, 9 Poor) and the five criteria as labelled chips. Sidebar: integrated impact is not the mean.
- `nofo-contract.svg` -- slide 9. Document silhouette with extracted clauses pulled out into a checklist (mechanism, agency, deadline, page limits, budget cap, required areas, special clauses).
- `page-budget.svg` -- slide 10. Two horizontal bar charts (R01 12 p, R21 6 p) with the Significance / Innovation / Approach proportions colour-coded.
- `aims-anatomy.svg` -- slide 11. A one-page rendering of a Specific Aims page with the six blocks called out (Opening, Goal, Aim 1, Aim 2, Aim 3, Expected Impact).
- `style-rules.svg` -- slide 13. Four-up grid: bold rule, italics rule, active-voice rule, no-em-dash rule, each with a do/don't pair.
- `strategy-three-parts.svg` -- slide 14. Three vertical columns labelled Significance, Innovation, Approach with page-count badges (~2 p, ~1.5 p, ~8.5 p for R01).
- `approach-aim-block.svg` -- slide 15. A vertical six-block stack: Rationale, Methods, Hypothesis, Analyses, Expected outcomes, Problems & alternatives. Block 6 highlighted.
- `rigor-timeline.svg` -- slide 16. Three thumbnails: rigor checklist, preliminary-data figure stub, Gantt chart with milestone diamonds.
- `grant-boomerang.svg` -- slide 17. The five-stage pipeline with severity-tagged findings flowing along the boomerang arrow from Stage 4 back to Stages 2 / 3.
- `resubmission-a1.svg` -- slide 18. A two-page strip: the 1-page Introduction with point-by-point bullets on the left; the Strategy body with vertical change bars on the right.
- `figure-qa.svg` -- slide 19. A magnifier hovering over a PDF page with compliance flags (dpi badge, embedded-font badge, CB-safe palette badge, axis-legibility ruler).
- `three-defences-grant.svg` -- slide 20. Three shields stacked: NOFO contract (Stage 0), cite-the-card (Stages 2-3), boomerang (Stage 4). Each shield has a one-word label.

## Screenshots Needed

- `claude-code.png` -- slide 3, Claude Code interface.
- `codex-cli.png` -- slide 3, Codex CLI interface.
- `copilot-vscode.png` -- slide 3, GitHub Copilot in VS Code.

All three live in [`assets/screenshots/`](../../assets/screenshots/).

## Live-Demo Pre-Built State

In `sessions/week-06/practicum/` ship:

- `README.md` restating the practicum topic (R21 NIMH naturalistic stimuli; animacy-of-opening-shot ERSP) and the three live actions
- `NOFO.md` written by `/grant:grant-writing` Step 0 against a real R21 NIMH naturalistic-stimuli NOFO
- `specific-aims.md` -- a 6-block scaffold with the opening, goal, and Aim 1 stub; Aims 2 and 3 left empty
- Symlinks back to `sessions/week-05/practicum/collection/` so the Week-5 anchor cards (Hasson 2004 psychophysics, Hasson 2008 action, Huth 2016 language, Saarimaki 2016 emotion) are addressable by relative path
- `figures/preliminary-pipeline-checkpoint.svg` -- the BIDS + ICA + ERSP checkpoint figure carried in from Week 3 (or a stand-in if the practicum is run in isolation)

Three live actions:

1. `/grant:grant-writing` -- draft the overarching goal and Aim 1 from the corpus and `NOFO.md`. The agent fills in the cite-the-card links to the Week-5 anchor cards.
2. `/grant:grant-review` -- run the simulated study section on the draft. Walk through whatever findings surface, in real time. Do not manufacture a finding; the most likely natural one is that the preliminary data shows the pipeline runs end-to-end on a subset but does not yet show the animacy effect.
3. `/grant:grant-figure-qa` -- run on the preliminary-pipeline-checkpoint figure. The likely compliance flag is a missing colour-blind safe palette or a sub-300-dpi rasterisation.

If the review surfaces a critical finding, we describe the boomerang back to Aim 1 aloud (we do not run it on stage, to stay in the time box).

## Open Decisions -- Resolved

- **Worked-example mechanism:** R21 (6 p strategy; 2 aims; NIH); chosen so the demo can show the full Aims page on one slide and so the figure-QA pass has a concrete preliminary-data figure to check.
- **Slide 1 housekeeping:** confirmed. Title + course / Discord / recording links on slide 1. Slide 2 recaps Weeks 1-5; this is the "use what we built so far" beat, not a courtesy line.
- **Live-demo finding:** not manufactured. Most likely natural finding given the corpus and the practicum is "preliminary data shows pipeline runs end-to-end but does not yet show the animacy effect"; if it surfaces, the boomerang is described aloud.
