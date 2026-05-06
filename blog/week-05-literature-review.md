# Week 5 Guide: Literature Search and Review

*A literature review is not a single prompt; it is a managed pipeline. Five stages, enforced order, bidirectional boomerang on review findings, citation grounding at every step. Same epic, sub-issue, and pull request rigor introduced in Week 3, plus a "cite-the-card" rule that makes hallucinated references mechanically impossible. The walkthrough at the end builds a working mini lit review on the neural correlates of naturalistic movie watching, organised by four perspectives: psychophysics, action, language, emotion.*

This guide accompanies [Week 5](../sessions/week-05/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). Weeks 1-4 built infrastructure: git, the agent, project structure, and continuous integration. Week 5 is the first time we point that infrastructure at a research output. The artefact under construction is a literature review, but the discipline transfers to every later research artefact in the course (grants, manuscripts, figures).

The single most useful idea in this guide: **a literature review has a Definition of Done.** Same way a feature branch is not "done" until continuous integration (CI) is green, a literature review is not "done" until every claim points at a stored paper-card and the review boomerang has run at least once. Convergence in one shot is a red flag, not a green flag.

---

## Why Structured Literature Reviews

Three failure modes that unstructured reviews fall into. They were already common in manual reviews; agentic workflows accelerate each by an order of magnitude.

**String-of-pearls citation.** One paper, then the next paper, then the next paper. The text reads as well-cited from a distance and has no thematic spine when you actually read it. Each paragraph could be deleted without changing the argument. The review documents the literature instead of synthesising it.

**Recency bias.** The top of the search-result page becomes the field. Foundational work from 2010 is below the fold and never makes it into the draft. Agents make this worse because they accept the result-list ordering as the canonical ordering unless explicitly told to sort by citations or to call a `canonical` query first.

**Hallucinated references.** Plausible author, plausible year, plausible journal, plausible-sounding title, no such paper. Manual reviewers catch these in their own writing because they cited the paper themselves; agents cannot, because they did not. Reviewers downstream catch them only if the citation is verifiable in real time, which is not the case for most embedded BibTeX.

The fix is not "ask the agent to cite better." The fix is **structural**: a pipeline where every claim is mechanically traceable to a stored, retrievable artefact.

---

## The 5-Stage Pipeline

```text
[ 1. Direction ] -> [ 2. Collect ] -> [ 3. Synthesize ] -> [ 4. Draft ] -> [ 5. Review ]
        ^                                                                       |
        +-----------------------------------------------------------------------+
                              boomerang on gaps
```

Five stages, enforced order. Drafting before synthesising is a structural error, not a style choice. Each stage has its own tools.

| Stage | Tool | Output |
|-------|------|--------|
| 1. Direction | `/project:epic-dev`, plan mode | Epic issue + per-strand briefs (sub-issues) defining scope, per-entry deliverable, acceptance criteria, out-of-scope |
| 2. Collect | `/opencite:opencite`, `opencite` CLI | `collection/<strand>/<slug>/` folders with `card.md`, `source.pdf` (if redistributable), `source.md`, `meta.json`; per-strand `INDEX.md` and `.bib` |
| 3. Synthesize | `/opencite:literature-review`, manual cross-reference | `synthesis/`: taxonomies, hierarchies, gap analysis, scope diagram. Still no prose review |
| 4. Draft | `/manuscript:manuscript-formatting`, `/manuscript:manuscript-writing` | Mini-review or full literature review, where every claim cites a paper-card by relative path |
| 5. Review | `/manuscript:paper-review` | Reviewer-style critique with severity-tagged findings; gaps boomerang back to Stage 1 or 2 |

The boomerang is the rigor signal. A review that never updates the corpus has either nothing to say or is hiding what it found.

---

## Stage 1: Direction

The pattern is the same as Week 3: an epic issue with parallel sub-issues. The sub-issues here are called **strands**. Each strand is a concurrent collection pass with its own brief, branch, and pull request (PR). Strands let you parallelise work across analytical perspectives without losing track of scope.

The canonical real-world example is the Annotation Garden Initiative (AGI) research foundation epic at `Annotation-Garden/management#3`. Three strands (tools, data, science), three sub-issues, three branches, three PRs, ~99 paper-cards across the corpus. The epic ran over three weeks; this Week 5 practicum is a smaller-scoped reproduction sized to fit in one teaching session.

A **strand brief** has five fields. Treat each as a contract:

```markdown
## Goal
One sentence. The strand's main claim or coverage area.

## Scope
3-5 sub-areas the strand covers. Aim for breadth first, depth where it matters.

## Per-entry deliverable
What every paper-card folder must contain.

## Acceptance criteria
How we know the strand is done.

## Out-of-scope
What *not* to chase.
```

Out-of-scope is the most under-used field. It tells the agent which adjacent rabbit-hole *not* to follow. Without it, Stage 2 collects whatever the first search surfaces.

For the practicum we use four strands organised by analytical perspective: psychophysics (low-level neural tracking of image and motion statistics), action (action observation under naturalistic viewing), language (speech and narrative comprehension), emotion (affective dynamics across viewers). The full strand briefs ship in [`sessions/week-05/practicum/_briefs/`](https://github.com/OpenScience-Collective/agentic-research-course/tree/main/sessions/week-05/practicum/_briefs).

---

## Stage 2: Collect with `opencite`

Three search strategies. Combine them deliberately.

```bash
# Foundational, high-citation works (antidote to recency bias)
uvx opencite canonical "naturalistic stimuli EEG" --max 10

# Recent or specific
uvx opencite search "movie-watching EEG developmental" \
  --max 20 --sort citations

# Citation graph traversal (both directions)
uvx opencite cite "10.1126/science.1089506" --direction both
```

Two interfaces, one CLI underneath. The **`/opencite:opencite` skill** drives the workflow with judgement: it picks which strategy to use, evaluates the search results, decides which papers to download, and handles license-aware archival. The **`opencite` CLI** at [`github.com/neuromechanist/opencite`](https://github.com/neuromechanist/opencite) is a primitive that the skill calls underneath; it is also useful directly when you want raw control. Install with `uv pip install opencite` (persistent) or `uvx opencite` (one-off).

Batched retrieval and conversion in one go:

```bash
uvx opencite search "naturalistic EEG" --max 20 -f json -o results.json
uvx opencite batch-fetch \
  --from-json results.json \
  --convert -o ./papers \
  --summary report.json
```

Output tree:

```text
papers/
+-- pdf/
|     +-- paper-A.pdf       # open-access, committed
|     L-- paper-B.pdf       # paywalled, excluded by policy
+-- markdown/
|     +-- paper-A.md
|     +-- paper-B.md        # always present, even for paywalled papers
|     L-- img/
|           L-- paper-A/    # extracted figures (markit-mistral only)
L-- report.json             # per-paper retrieval summary
```

License-aware archival is non-negotiable. Open-access PDFs (CC-BY, CC0, arXiv, bioRxiv, OSF) commit; paywalled PDFs do not. Markdown extraction always commits, since extracted text is generally fair use for research notes. The `redistribution_ok` flag in `meta.json` is the single source of truth.

### The Paper-Card Schema

Each paper lives in its own folder:

```text
collection/<strand>/<slug>/
+-- card.md         the paper-card; required
+-- source.pdf      full PDF, only when redistributable
+-- source.md       markdown extraction, always required
L-- meta.json       provenance: source URL, retrieval date, license, hash
```

The `card.md` template:

```yaml
---
slug: hasson-2004-isc
type: paper
strand: psychophysics
year: 2004
authors: [Hasson, Nir, Levy, Fuhrmann, Malach]
venue: Science
doi: 10.1126/science.1089506
license: publisher-paywall
modalities: [fmri]
tags: [intersubject-correlation, naturalistic-viewing, foundational]
relevance: high
pdf_status: not-redistributable
pdf_path: null
md_path: source.md
md_quality: abstract-only
---

## TL;DR
One or two sentences. The thesis, not the abstract opening.

## Summary
3-6 sentences covering core contribution, method, scope, key numbers.

## Relevance
Concrete connection to the strand. Cite specific mechanisms.

## Notable details
Bullet list of facts worth pulling forward to synthesis.

## Open questions
What this work does not answer. Paper-specific only.

## Citations
Primary BibTeX key plus up to 5 related works as one-liners.
```

Six required sections. Generic "this is relevant because..." prose is not acceptable in the Relevance section; the agent must cite specific mechanisms (band, network, paradigm, dataset). Open Questions feeds Phase 2 gap analysis directly; skip it and synthesis becomes much harder.

The schema is the **rigor discriminator**. With it, the corpus is queryable and uniform. Without it, every entry is a free-form note that downstream steps cannot rely on.

### Calibration Anchors

The `relevance` field is useful only if it discriminates. Spell out anchor examples in the schema:

- **high.** Direct dependency of the strand's main claim. Example: an electroencephalography (EEG) study that defines the standard analysis for the strand.
- **medium.** Standard work in scope, not the anchor. Example: a functional magnetic resonance imaging (fMRI) study on the same perspective whose findings need EEG translation.
- **low.** Tangential or background context. Example: a non-naturalistic-stimulus paper cited only to motivate why naturalistic stimuli matter.

If more than ~40% of entries land at one level, the field has lost discriminative power; recalibrate. Same logic applies to any rated field. Calibration anchors are the cheapest mechanical defence against thumb-on-scale: no prompt engineering, no review process, just anchor examples in the schema.

---

## Stage 3: Synthesize -- Structure Before Prose

The most-skipped stage. The temptation is to draft as soon as you have papers. Resist.

Synthesis produces structured artefacts only: tables, hierarchies, maps, gap analysis, scope diagrams. AGI's Phase 2 produced five docs ([`research/synthesis/`](https://github.com/Annotation-Garden/management/tree/main/research/synthesis)):

- **Tool ontology.** Hierarchical map of the 33 tool, platform, and standard entries grouped into five layers.
- **Dataset hierarchy.** Formal placement of all 36 dataset entries along a naturalistic / cognitive-task spectrum.
- **Science map.** Methodological themes across the 30 science papers.
- **Gap analysis.** Three-column comparison of ANNOTATE R01 coverage, current AGI white paper coverage, and the uncovered terrain.
- **Scope diagram.** Side-by-side AGI-versus-ANNOTATE dimensions and the explicit complementarity statement.

For our practicum the synthesis layer is smaller: a perspective-by-method matrix (rows: psychophysics, action, language, emotion; columns: intersubject correlation, time-resolved regression, frequency-band tracking, classification) plus a one-row-per-strand gap analysis ([`synthesis/gap-analysis-stub.md`](https://github.com/OpenScience-Collective/agentic-research-course/blob/main/sessions/week-05/practicum/synthesis/gap-analysis-stub.md)).

Forcing yourself to produce structured tables first is what catches dataset-level patterns: the same paper appearing in two strands, conflicting findings, coverage gaps. **The gap analysis is the bridge to Stage 4**: it names the claims the prose review will defend. If you cannot fill in a row, you do not have a claim.

---

## Stage 4: Draft Grounded Prose

Two skills run in sequence.

### `/manuscript:manuscript-formatting`

Picks the structure. Five common review types, each with different rules:

| Type | Purpose | Method | Output |
|------|---------|--------|--------|
| **Mini-review** | Focused review for a specific question | Targeted search | Brief, focused synthesis |
| **Scoping** | Map the extent of literature on a topic | Broad search, categorisation | Overview of themes and gaps |
| **Narrative** | Summarise and interpret a body of literature | Selective, thematic | Flowing prose with arguments |
| **Systematic** | Exhaustive, reproducible search | PRISMA protocol | Structured report |
| **IMRAD background** | Introduction section of a manuscript or grant | Embedded | Argument paragraph |

Today's practicum uses the mini-review structure. Week 6 (grants) and Week 7 (manuscripts) revisit this skill for IMRAD; today the focus is the lit review as a standalone artefact.

### `/manuscript:manuscript-writing`

Enforces prose discipline. Two rules above all others.

**Thematic, not chronological.** Group paragraphs by argument, not by year. Chronological organisation only works when the timeline is itself the argument; otherwise it disguises a string-of-pearls.

**Cite the card.** Every claim cites a paper-card by relative path. If the agent cannot link to a `card.md`, the claim does not appear in the draft. This is the second mechanical defence against thumb-on-scale: hallucinated citations are structurally impossible if every claim points to a stored card.

Citation weaving comes in four shapes. Mix them deliberately:

- **Integral.** "Hasson and colleagues showed that ~30% of cortex synchronises across viewers under naturalistic viewing [card](../collection/psychophysics/hasson-2004-isc/card.md)."
- **Non-integral.** "Approximately one-third of cortex is engaged in synchronised activity during free viewing [card](...)."
- **Synthesis.** "Multiple lines of evidence converge on the conclusion that editorial control predicts intersubject correlation [card-A] [card-B] [card-C]."
- **Contrast.** "Where Hasson 2008 reports near-perfect synchronisation under tightly directed films [card-A], Bartels and Zeki 2004 report substantially noisier signals under unedited natural viewing [card-B]."

Real examples in the AGI direction papers ([`direction-papers/science-direction.md`](https://github.com/Annotation-Garden/management/blob/main/direction-papers/science-direction.md)) -- about 30 cite-the-card links across ~160 lines.

---

## Stage 5: Review and the Boomerang

`/manuscript:paper-review` plays the peer-reviewer role: methodological rigor, statistical validity, balance, scope creep. Findings are tagged by severity (critical, major, minor). Critical and major findings cycle back into the pipeline:

- **Missing evidence -> Stage 2.** The reviewer surfaced a claim the corpus does not support; go collect more papers.
- **Mis-scoped direction -> Stage 1.** The reviewer surfaced that the strand brief left a gap; revise the brief and re-run collection.

This is the **boomerang**: the rigor signal that distinguishes a managed pipeline from a one-shot prompt.

A first-draft review that passes everything is a red flag, not a green flag. Either the review is shallow or the corpus is hiding what it found. Run again with adversarial framing if the first pass converges too cleanly.

### Three Defences Against Thumb-on-Scale

The three rigor defences are deliberately stack-redundant, one per stage:

- **Calibration anchors** at scoring time (Stage 2). Cheap and mechanical.
- **Cite-the-card** at drafting time (Stage 4). Makes hallucination structurally impossible.
- **Boomerang** at review time (Stage 5). Cycles the corpus, not just the prose.

Each catches a different failure mode at a different stage. None alone is sufficient. The combination makes a review that lands its conclusion through evidence, irrespective of whether the evidence supports the working hypothesis or contradicts it. Bias-irrespective rigor.

---

## Live Walkthrough -- The Practicum

The Week 5 session ends with a live walkthrough on the practicum scaffold at [`sessions/week-05/practicum/`](https://github.com/OpenScience-Collective/agentic-research-course/tree/main/sessions/week-05/practicum).

Topic: literature review on the neural correlates of naturalistic movie watching, organised by four perspectives (psychophysics, action, language, emotion). Extends the Week 3 Healthy Brain Network (HBN) movie-watching practicum.

Pre-built state:

- Epic brief
- Four strand briefs, one per perspective
- Four anchor cards: Hasson 2004 (psychophysics), Hasson 2008 (action), Huth 2016 (language), Saarimaki 2016 (emotion). Each card is schema-compliant with real DOI, license, and provenance metadata.
- A synthesis stub with a one-row-per-strand gap analysis
- A direction-paper draft stub with a thesis paragraph slot and a section skeleton

Three live actions:

1. **Add one new paper.** Pick a 2024-2026 open-access paper from any of the four strands. Run the `/opencite:opencite` skill with the DOI; it should produce `card.md`, `source.md`, `meta.json` in `collection/<strand>/<slug>/`, append to the strand `INDEX.md`, and add a BibTeX entry to the strand `.bib`.

2. **Weave one paragraph.** Run `/manuscript:manuscript-writing` to integrate the new paper into one synthesis paragraph in `direction-paper/draft-stub.md`. Every claim cites a paper-card by relative path.

3. **Run the review.** Run `/manuscript:paper-review` on that paragraph. Whatever the review surfaces, walk through. We do not manufacture a gap. If a real one appears (a likely natural one given HBN's developmental cohort and the seed-card distribution is **age-effect / developmental coverage**), we describe the boomerang back to Stage 2 with a follow-on `opencite search "naturalistic movie EEG developmental"` call -- but do not run it on stage; we stay in the time box.

The most useful moment of the walkthrough is the boomerang. A red review finding is more reassuring for a first-time literature-review-pipeline user than a clean draft, because it proves the system actually catches things.

---

## Before Next Week

- Install opencite as a one-off (`uvx opencite --version`) or persistently (`uv pip install opencite`).
- Add the [`research-skills`](https://github.com/neuromechanist/research-skills) plugin if not already installed; it bundles `opencite`, `manuscript`, and `project`.
- Pick a topic in your own research area where a focused mini lit review (15-30 papers) would actually move your work forward.
- Optional: skim two of the AGI direction papers ([`science-direction.md`](https://github.com/Annotation-Garden/management/blob/main/direction-papers/science-direction.md) and [`tools-direction.md`](https://github.com/Annotation-Garden/management/blob/main/direction-papers/tools-direction.md)) to see what the end of the pipeline looks like at full scale.
- Make sure your repo has a long-lived branch (`develop` or equivalent) where the lit review epic can land separately from `main`.

Week 6 starts from the corpus produced here. A grant Specific Aims page is, structurally, a literature review condensed into one page; the cards and bibliography from this week feed directly into next week's drafting.
