# Week 5: Literature Search and Review

A literature review is not a single prompt; it is a managed pipeline. This session shows how to drive that pipeline with the same epic, sub-issue, and pull-request rigor introduced in Week 3, plus citation grounding at every step. The goal is a review that reaches its conclusion through evidence, irrespective of whether the evidence is favorable or unfavorable to the working hypothesis.

## Learning Objectives

By the end of this session, you will:

- Frame a literature review as a **5-stage pipeline**: direction, collect, synthesize, draft, review
- Use `/project:epic-dev` to scope a review into parallel **strand briefs** (sub-issues) before any paper is read
- Search and retrieve papers with `/opencite:opencite` and the `opencite` CLI: canonical works, recent work, citation graphs, batched PDF download, PDF-to-markdown conversion
- Build a **paper-card corpus** with a uniform schema (one folder per paper, license-aware archival, BibTeX index, INDEX.md)
- Produce **synthesis artifacts** before any prose: taxonomies, hierarchies, gap analysis
- Draft a grounded review with `/manuscript:manuscript-formatting` and `/manuscript:manuscript-writing`, where every claim cites a paper-card by relative path
- Run `/manuscript:paper-review` and treat reviewer findings as a **boomerang**: gaps surfaced in review re-enter the pipeline at the direction or collect stage
- Recognise the failure modes that make AI-assisted reviews look credible but are not (string-of-pearls citation, recency bias, hallucinated references, opinion-as-evidence) and the disciplines that prevent each

## The 5-Stage Pipeline

```
[ 1. Direction ] -> [ 2. Collect ] -> [ 3. Synthesize ] -> [ 4. Draft ] -> [ 5. Review ]
        ^                                                                       |
        +-----------------------------------------------------------------------+
                              boomerang on gaps
```

| Stage | Tool | Output |
|-------|------|--------|
| 1. Direction | `/project:epic-dev`, plan mode | Epic issue + per-strand briefs (sub-issues) defining scope, per-entry deliverable, acceptance criteria, out-of-scope |
| 2. Collect | `/opencite:opencite`, `opencite` CLI | `research/collection/<strand>/<slug>/` folders: `card.md`, `source.pdf` (when redistributable), `source.md`, `meta.json`; per-strand `INDEX.md` and `.bib` |
| 3. Synthesize | `/opencite:literature-review`, manual cross-reference | `research/synthesis/`: taxonomy, hierarchy, science map, gap analysis, scope diagram. Still no prose review |
| 4. Draft | `/manuscript:manuscript-formatting`, `/manuscript:manuscript-writing` | Mini-review or full literature review with cite-the-card discipline (every claim links to a paper-card relative path) |
| 5. Review | `/manuscript:paper-review` | Reviewer-style critique with severity-tagged findings; gaps boomerang back to Stage 1 or 2 |

The order is enforced. Drafting before synthesizing produces narrative without evidence; collecting before defining direction produces breadth without focus.

## Outline (30-45 min talk + 15 min Q&A)

### Part 1: Why Structured Literature Reviews (4 min)

- Three failure modes of unstructured reviews: **string-of-pearls** citation, **recency bias**, **hallucinated references**
- AI raises stakes: agents will fabricate a plausible citation unless they are forced to ground claims in a corpus they have actually read
- Reframe: a literature review is a **managed pipeline**, not a long prompt. Same epic and pull-request rigor as Week 3, plus citation grounding at every step

### Part 2: The 5-Stage Pipeline (3 min)

- Diagram with bidirectional arrows. The boomerang from Stage 5 back to Stage 2 or 1 is the rigor signal: a review that never updates the corpus has either nothing to say or is hiding what it found

### Part 3: Stage 1 -- Direction and Strand Briefs (3 min)

- `/project:epic-dev` scopes the review as an epic with parallel strand sub-issues
- A **strand brief** is a contract: scope, per-entry deliverable, acceptance criteria, what is out of scope. It prevents scope drift in Stage 2
- Reference: AGI epic `Annotation-Garden/management#3` and `research/_briefs/strand-A-tools.md`

### Part 4: Stage 2 -- Collect with `opencite` (5 min)

- Three search strategies: **canonical** (foundational), **search** (recent or specific), **cite** (citation graph traversal). Combine them
- Two interfaces: the `/opencite:opencite` skill (preferred, drives the workflow with judgement) and the `opencite` CLI (`uv pip install opencite` or `uvx opencite`); the skill calls the CLI under the hood
- Batch retrieval: `opencite batch-fetch --from-json results.json --convert -o ./papers --summary report.json`
- The **paper-card schema** is the rigor discriminator: front-matter (slug, type, year, doi, license, agi_relevance, pdf_status), required sections (TL;DR, Summary, Relevance, Notable details, Open questions, Citations)
- License-aware archival: open-access PDFs commit; paywalled do not; markdown extractions always commit
- Calibration anchors prevent thumb-on-scale: if more than ~40% of entries land in `agi_relevance: high`, the field has lost discriminative power

### Part 5: Stage 3 -- Synthesize (3 min)

- No prose yet. The artefacts are **structured tables and maps**: tool ontology, dataset hierarchy, science map, gap analysis, scope diagram
- Cross-strand references (a tool used by a dataset, a method enabled by a standard) emerge here
- Gap analysis is the bridge to Stage 4: it names the claims that the prose review will defend

### Part 6: Stage 4 -- Draft Grounded Prose (3 min)

- `/manuscript:manuscript-formatting` picks the structure (mini lit review, scoping review, narrative review, systematic review, IMRAD background section)
- `/manuscript:manuscript-writing` enforces prose discipline: thematic over chronological organisation, citation weaving (integral, non-integral, synthesis, contrast), abbreviations defined on first use, no em-dashes
- The hard rule: **every claim cites a paper-card by relative path.** If the agent cannot point to a card, the claim does not appear in the draft

### Part 7: Stage 5 -- Review and Boomerang (3 min)

- `/manuscript:paper-review` plays the peer-reviewer role: methodological rigor, statistical validity, balance, scope creep
- Findings are tagged by severity. Critical and major findings boomerang: back to Stage 2 if the gap is missing evidence, back to Stage 1 if the gap is mis-scoped direction
- The bias-and-rigor point: a review of a hypothesis you wanted to confirm should still surface findings against it. Calibration anchors and the boomerang make that mechanically possible

### Part 8: Live Demo (5 min)

Topic: literature review on the neural correlates of naturalistic movie watching, organised by four analytical perspectives -- **psychophysics**, **action**, **language**, **emotion**. This extends the Week 3 HBN movie-watching practicum and matches a long-running framing in naturalistic-stimulus neuroscience. The repository ships with a pre-built epic, four strand briefs (one per perspective), and 3 to 5 seed paper-cards per strand. **Live actions:**

1. `/opencite:opencite` add one new paper by DOI: produce `card.md`, `source.md`, `meta.json`; append BibTeX and INDEX line
2. `/manuscript:manuscript-writing` weave the new paper into one synthesis paragraph
3. `/manuscript:paper-review` critique that paragraph; whatever the review surfaces, we handle it on the fly. We do not manufacture a gap. If a natural one appears -- a recurring candidate is the **age-effect / developmental** angle, since HBN is a developmental cohort and the seed cards trend toward adult studies -- we walk it through the boomerang back to Stage 2

### Q&A (15 min)

## Key Concepts

- **5-stage pipeline:** Direction, Collect, Synthesize, Draft, Review. Order enforced; bidirectional boomerang on findings.
- **Strand brief:** Sub-issue contract for a parallel collection strand. Defines scope, per-entry deliverable, acceptance criteria, out-of-scope.
- **Paper-card:** A folder per paper with `card.md` (front-matter + 6 required sections), `source.pdf` when redistributable, `source.md` always, `meta.json` provenance.
- **License-aware archival:** Open-access PDFs commit; paywalled do not. Markdown extraction always commits. `redistribution_ok` flag is the single source of truth.
- **Calibration anchors:** Explicit anchor examples for relevance ratings (high / medium / low) so the rating remains discriminative; if too many entries cluster at one level, recalibrate.
- **Synthesis artefacts:** Taxonomies, hierarchies, science maps, gap analysis, scope diagram. Still no prose.
- **Citation weaving:** Integral (Smith found that...), non-integral (... has been demonstrated [cite]), synthesis (multiple papers converge on a finding), contrast (X reports A, Y reports the opposite).
- **Cite-the-card rule:** Every claim in the draft cites a paper-card by relative path. No card, no claim.
- **Boomerang:** Reviewer findings re-enter the pipeline at the appropriate stage. The signal of a rigorous review is that it cycles, not that it converges in one shot.

## Canonical Real-World Reference

The Annotation Garden Initiative (AGI) research foundation epic ([`Annotation-Garden/management#3`](https://github.com/Annotation-Garden/management/issues/3)) is the worked example referenced throughout this session. Its structure:

- Epic and three phase sub-issues (collection, synthesis, white paper and direction drafts)
- Three strand briefs ([`research/_briefs/strand-A-tools.md`](https://github.com/Annotation-Garden/management/blob/main/research/_briefs/strand-A-tools.md) and siblings)
- ~99 paper-cards across the three strands ([`research/collection/{tools,data,science}/`](https://github.com/Annotation-Garden/management/tree/main/research/collection))
- Five Phase 2 synthesis docs ([`research/synthesis/`](https://github.com/Annotation-Garden/management/tree/main/research/synthesis))
- Three direction documents ([`direction-papers/`](https://github.com/Annotation-Garden/management/tree/main/direction-papers))

The course practicum is a smaller-scope reproduction of the same shape, sized so that one new paper can be added live in five minutes.

## Before Next Session

- Install `opencite` either as a one-off (`uvx opencite --version`) or persistent (`uv pip install opencite`)
- Add the `research-skills` plugin if not already installed (it bundles the `opencite`, `manuscript`, and `project` plugins)
- Pick a topic in your own research area where a focused mini lit review (15-30 papers) would actually move your work forward
- Optional: skim two of the AGI direction papers ([`science-direction.md`](https://github.com/Annotation-Garden/management/blob/main/direction-papers/science-direction.md) and [`tools-direction.md`](https://github.com/Annotation-Garden/management/blob/main/direction-papers/tools-direction.md)) to see what the end of the pipeline looks like
- Make sure your repo has a `develop` branch (or the equivalent) so the lit review can land on a long-lived branch separate from `main`

## Common Pitfalls (Watched For in Live Demo)

- **Skipping the strand brief.** Without it, Stage 2 collects whatever the agent's first search surfaces, and Stage 3 cannot decide what to keep.
- **Drafting before synthesising.** Produces flowing prose that loses every argument under review.
- **Letting the agent invent citations.** Caught by the cite-the-card rule and by `/manuscript:paper-review`.
- **Recency bias.** Mitigated by combining `opencite canonical` (high-citation foundational works) with `opencite search --sort date`.
- **Confirmation bias.** The boomerang must run at least once before declaring a draft final, even if the first draft looks good.

## What This Session Does Not Cover

- Systematic reviews requiring full PRISMA protocols. The pipeline supports them, but PRISMA flow diagrams, registered protocols, and risk-of-bias tooling are an extension, not the default.
- Reference manager integration with Zotero or Mendeley. The pipeline emits BibTeX; the manager is downstream and out of scope.
- Citation typesetting in LaTeX or Word, which Week 7 (Manuscript Preparation) covers.

## Related Sessions

- **Week 3** introduced epic, sub-issue, worktree, and `/review-pr` rigor. Week 5 reuses all of it for research output.
- **Week 6** (Grant Proposals) starts from a literature review; this session is the prerequisite.
- **Week 7** (Manuscript Preparation) consumes the cards and bibliography produced here.
