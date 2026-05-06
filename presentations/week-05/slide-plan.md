# Week 5 Slide Plan

## Target: 20 slides, ~30 min presentation, then ~5 min live walkthrough + 15 min Q&A

**Core message.** A literature review is a managed pipeline, not a long prompt. Five stages in enforced order; bidirectional boomerang on review findings; every claim cites a stored paper-card. The goal is a review whose conclusion is reachable through evidence, irrespective of whether the evidence supports the working hypothesis or contradicts it. Drift is what an agentic workflow makes easy and what disciplined structure prevents.

The tone matches Weeks 3 and 4: thesis up front, every theoretical point lands on the HBN movie-EEG practicum, every tool decision is justified by *why it improves research output*. The Annotation Garden Initiative (AGI) research foundation epic is the canonical full-scale worked example referenced throughout; the practicum is a smaller-scope reproduction sized for a five-minute live demo.

## Slide Inventory

### Opening (3 min)

1. **Title** -- "Week 5: Literature Search and Review." Author, course link, Discord link, recording link.
2. **Where we are** -- Week 1 git, Week 2 Claude Code, Week 3 epic + sub-issues + worktrees + plan + review, Week 4 CI/CD. Today: same rigor applied to research output, starting with literature.

### Why structured literature reviews (4 min)

3. **Three failure modes** -- string-of-pearls citation, recency bias, hallucinated references. Each fragment animates in. Sidebar callout: "AI accelerates each of these by an order of magnitude." Tie the third bullet to a screenshot of a fabricated DOI in the wild if available.
4. **AI raises the stakes** -- Agents will fabricate plausible cites unless grounded in a corpus they have read. Confirmation bias is mechanical. The fix is structural: a pipeline where every claim is mechanically traceable to a stored artefact, not "ask the agent to cite better."
5. **Reframe -- a literature review is a managed pipeline** -- Same shape as Week 3 (epic, sub-issues, branches, PRs, review). Plus: cite-the-card rule. Plus: a boomerang from review back to direction or collection. Single-line punch: "Lit review = research with a Definition of Done."

### The pipeline (2 min)

6. **The 5-stage pipeline** -- The hero diagram. Direction -> Collect -> Synthesize -> Draft -> Review with a curved boomerang arrow from Stage 5 back to Stages 1 and 2. Each stage is a labelled icon. Order is enforced. Drafting before synthesising is a structural error, not a style choice.

### Stage 1: Direction (3 min)

7. **Direction with `/project:epic-dev`** -- Plan-mode the topic into an epic + parallel strand sub-issues. Strands are concurrent collection passes. Each strand has its own brief, branch, and PR. Concrete example: AGI epic `Annotation-Garden/management#3` with three phases. Show the issue title and label set screenshot.
8. **Strand brief anatomy** -- Five fields, every brief: goal, scope, per-entry deliverable, acceptance criteria, out-of-scope. Annotated snippet from `research/_briefs/strand-A-tools.md`. Sidebar: "Without the brief, Stage 2 collects whatever the first search surfaces."

### Stage 2: Collect with opencite (5 min)

9. **`opencite` -- three search strategies** -- canonical (foundational), search (recent/specific), cite (citation graph traversal). Combine. Two interfaces: skill (preferred, drives with judgement) and CLI (`uv pip install opencite` or `uvx opencite`). CLI repo: `github.com/neuromechanist/opencite`. Code block animates line by line.
10. **Batched retrieval and conversion** -- `opencite batch-fetch --from-json results.json --convert -o ./papers --summary report.json`. Output tree: `papers/pdf/`, `papers/markdown/`, `papers/markdown/img/`. License-aware: PDFs only commit when redistribution is allowed; markdown always commits.
11. **The paper-card schema -- the rigor discriminator** -- Folder per paper: `card.md`, `source.pdf` (if redistributable), `source.md` (always), `meta.json`. Front-matter (slug, type, year, doi, license, agi_relevance, pdf_status). Six required sections (TL;DR, Summary, Relevance, Notable details, Open questions, Citations). Annotated `card.md` snippet.
12. **Calibration anchors** -- Anchor examples for high / medium / low. If >40% land at one level, the field has lost discriminative power; recalibrate. Same logic applies to any rated field. The cheapest defence against thumb-on-scale.

### Stage 3: Synthesize (3 min)

13. **Synthesis artefacts -- structure before prose** -- AGI Phase 2 produced five docs (tool ontology, dataset hierarchy, science map, gap analysis, scope diagram). All structured tables and maps. **No prose yet.** Cross-strand references emerge here. Gap analysis is the bridge to Stage 4. Show one row of the AGI gap-analysis table.

### Stage 4: Draft (3 min)

14. **`/manuscript:manuscript-formatting`** -- Picks the structure: mini-review, scoping, narrative, systematic, IMRAD background. Today we use mini-review. Week 7 revisits this skill for full IMRAD. One slide, four columns of structure choices, one row highlighted.
15. **`/manuscript:manuscript-writing` -- the cite-the-card rule** -- Thematic over chronological. Citation weaving: integral, non-integral, synthesis, contrast. Abbreviations on first use; no em-dashes. The hard rule: **every claim cites a paper-card by relative path. No card, no claim.** Snippet from AGI `direction-papers/science-direction.md` showing the cite trail in line.

### Stage 5: Review and the boomerang (3 min)

16. **`/manuscript:paper-review`** -- Plays the peer-reviewer role. Findings tagged by severity. Critical/major findings cycle back: -> Stage 2 (missing evidence), -> Stage 1 (mis-scoped direction). Show three example findings with severity tags.
17. **Bias and rigor -- the favorable / unfavorable point** -- Calibration anchors at scoring; cite-the-card at drafting; boomerang at review. Three defences against thumb-on-scale, one at each stage. Punchline: "A review that converges in one shot has either nothing to say or is hiding what it found." This slide is the moral of the session.

### Live demo and close (4 min plus 5 min live)

18. **Demo roadmap** -- Topic: neural correlates of naturalistic movie watching, organised by four perspectives -- **psychophysics**, **action**, **language**, **emotion**. Extends Week 3 HBN movie-watching practicum. Pre-built: epic + 4 strand briefs (one per perspective) + 3-5 seed paper-cards per strand + synthesis stub. Three live actions listed with timestamps, fragments animating in. Closing note: if the review surfaces a real gap, we walk the boomerang back to Stage 2 (the age-effect / developmental angle is a likely natural one given HBN's cohort, but we do not manufacture it).
19. **What today gives you / what's next** -- Today: a defensible literature review where every claim points to a stored, retrievable paper and reviewer feedback updates the corpus instead of being argued away. Next: Week 6 grants, starting from a review like the one just built.
20. **What we have / what we do next** -- Two columns.
    - **Have:** the pipeline shape; the AGI canonical example link; the practicum scaffold with strand briefs and seed cards.
    - **Do next, live:** add one paper -> weave one paragraph -> review that paragraph -> show the boomerang.
    - Bottom line: "Questions? Ask while opencite searches."

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 3 min |
| Why structured | 3 | 4 min |
| Pipeline overview | 1 | 2 min |
| Stage 1 -- direction | 2 | 3 min |
| Stage 2 -- collect | 4 | 5 min |
| Stage 3 -- synthesise | 1 | 3 min |
| Stage 4 -- draft | 2 | 3 min |
| Stage 5 -- review + boomerang | 2 | 3 min |
| Demo + close | 3 | 4 min |
| **Total** | **20** | **30 min** |

Live walkthrough (~5 min) + Q&A (~15 min) fill the remaining time.

## Animation Discipline

Every multi-bullet slide and every multi-line code block uses **fragment animations** so a single concept is on screen at a time. Specifically:

- Bullets stagger in (one per click)
- Code blocks reveal line by line, with the active line briefly highlighted
- Diagrams use **build-on-click**: stage labels appear before arrows; boomerang arrow appears last
- Side callouts (rationale, gotcha) appear after the main content, not simultaneously

This is the same discipline established in Week 4 (presentations/week-04/presentation.json).

## Assets to Produce (via `/scientific-figures:scientific-figures`)

Every diagram is hand-crafted SVG. No mermaid. Where icons need creative composition, the figures skill is allowed to delegate to codex / OpenAI image tools.

- `week-05/lit-review-pipeline.svg` -- slide 6, the hero. Five labelled stages in a horizontal flow with a curved boomerang arrow returning from Stage 5 to Stages 1 and 2. Each stage has its own icon (epic-tree for direction, search-funnel for collect, taxonomy-tree for synthesise, document for draft, magnifier for review).
- `week-05/failure-modes.svg` -- slide 3. Three icons in a row: pearls (string-of-pearls), clock-tilted-recent (recency bias), ghost-paper (hallucinated reference) with crossed-out DOI.
- `week-05/strand-fanout.svg` -- slide 7. One epic at top branching into three parallel strand sub-issues, each leading to a per-strand collection folder.
- `week-05/strand-brief-anatomy.svg` -- slide 8. A document silhouette with five labelled regions: goal, scope, per-entry deliverable, acceptance criteria, out-of-scope.
- `week-05/opencite-strategies.svg` -- slide 9. Three labelled paths from a query node: canonical (high-citation foundational layer), search (recent layer), cite (citation graph). Show layered concentric arcs.
- `week-05/opencite-output-tree.svg` -- slide 10. Folder tree: `papers/`, `pdf/`, `markdown/`, `markdown/img/`. License flags (open vs paywalled) shown as small badges.
- `week-05/paper-card-anatomy.svg` -- slide 11. A `card.md` page rendering with annotated callouts to front-matter fields and to the six required sections.
- `week-05/calibration-anchors.svg` -- slide 12. A horizontal scale (low / medium / high) with anchor-example chips placed on each level, plus a histogram overlay showing a healthy spread vs an over-concentrated one.
- `week-05/synthesis-artifacts.svg` -- slide 13. Five small thumbnails arranged on a board: ontology, hierarchy, science map, gap analysis, scope diagram. The gap analysis is highlighted as the bridge to Stage 4.
- `week-05/cite-the-card.svg` -- slide 15. A draft paragraph with arrows pointing from each claim to a `card.md` icon in a sidebar corpus. One claim has no arrow and is crossed out (the "no card, no claim" example).
- `week-05/review-boomerang.svg` -- slide 16 or 17. The five-stage pipeline with a prominent boomerang arrow from Stage 5 back to Stage 2; severity-tagged findings shown along the arrow.
- `week-05/three-defences.svg` -- slide 17. Three labelled shields stacked: calibration anchors at Stage 2, cite-the-card at Stage 4, boomerang at Stage 5. Each shield has a one-word label.
- `week-05/agi-case-callout.svg` -- slide 6 or 13 sidebar. Small badge with AGI logo, the words "Real-world example", and a link icon to `Annotation-Garden/management#3`.

Reuse from `assets/icons/` if present: `github-issue.svg`, `pull-request.svg`, `branch.svg`, `document.svg`. Otherwise commission new ones via `/scientific-figures:scientific-figures`. The figures skill is allowed to call codex / OpenAI image generation for creative icons (pearls metaphor, ghost-paper, boomerang) where vector-from-prompt would be slow.

## Screenshots Needed

- `week-05/screenshots/opencite-canonical.png` -- terminal showing `opencite canonical "naturalistic stimuli EEG" --max 5` output (slide 9)
- `week-05/screenshots/batch-fetch-tree.png` -- `tree papers/` after `batch-fetch --convert` (slide 10)
- `week-05/screenshots/paper-card-rendered.png` -- a `card.md` rendered in GitHub or VS Code preview, with the front-matter and six sections visible (slide 11)
- `week-05/screenshots/agi-issue-3.png` -- the `Annotation-Garden/management#3` GitHub issue page, top section visible (slide 7)
- `week-05/screenshots/paper-review-feedback.png` -- a `/manuscript:paper-review` output with severity-tagged findings (slide 16)
- `week-05/screenshots/cite-trail.png` -- a paragraph from `direction-papers/science-direction.md` rendered with the relative-path links visible (slide 15)

If a screenshot is not capturable before the session, fall back to a clean SVG mock matching the same layout.

## Live-Demo Pre-Built State

In `sessions/week-05/practicum/` ship:

- `README.md` -- restating the practicum topic ("neural correlates of naturalistic movie watching: psychophysics, action, language, emotion") and how to run the live actions
- `epic-brief.md` -- the epic-issue body
- `_briefs/strand-A-psychophysics.md`, `strand-B-action.md`, `strand-C-language.md`, `strand-D-emotion.md` -- four strand briefs, one per perspective; each mirrors the AGI strand-brief shape scaled to ~10 entries
- `collection/<strand>/<slug>/` -- 3-5 seed paper-cards per strand fetched and converted via `opencite` (open-access only; paywalled cards present without `source.pdf`). Suggested seed anchors per strand:
  - Psychophysics: Hasson 2004 *intersubject correlation*; Honey 2012 *slow timescales*; Dmochowski 2012 *correlated components in EEG during movies*
  - Action: Hasson 2008 *neurocinematics*; Bartels 2004 *natural viewing fMRI*; recent action-observation in naturalistic viewing
  - Language: Huth 2016 *semantic maps*; Lerner 2011 *topographic mapping of a hierarchy of timescales*; Brennan 2016 *EEG narrative comprehension*
  - Emotion: Saarimaki 2016 *discrete emotions in naturalistic stimuli*; Nummenmaa 2012 *emotion synchronization*; Kragel 2019 *fMRI emotion classifiers*
- `synthesis/gap-analysis-stub.md` -- a starter gap analysis with one row per strand, so the live boomerang has somewhere to write to
- `INDEX.md` per strand and per-strand `.bib` files
- `paper-card-template.md` symlinked from `_schema/paper-card.md` (mirrors AGI schema verbatim)

The demo adds **one** new paper-card live (Stage 2), weaves it into **one** new synthesis paragraph live (Stage 4), and runs `/manuscript:paper-review` on that paragraph live (Stage 5). Whatever the review surfaces, we handle on the fly -- the agent's reaction is the point. We do not script a gap. A likely natural gap given HBN's developmental cohort is **age-effect coverage** (most seed papers are adult), in which case the boomerang re-enters Stage 2 with a follow-on `opencite search "naturalistic movie EEG developmental"` call described aloud to stay in the time box.

## Open Decisions -- Resolved

- **Demo paper to add live:** a 2024-2026 open-access paper from one of the four perspectives, ideally HBN-adjacent, with a clean DOI so `opencite pdf` succeeds on stage. Final selection during dry-run.
- **Boomerang gap:** not manufactured. Whatever the review surfaces is what we walk through. Age-effect / developmental coverage is the most likely natural appearance given HBN's cohort and the seed-card distribution.
- **Slide 1 housekeeping:** confirmed. Slide 1 carries the title plus housekeeping links (course, Discord, recording). Slide 2 recaps Weeks 1-4 -- this *is* the "use what we learned from prev weeks" beat; treat it as a teaching device, not a courtesy line.
