# Week 5 Presentation: Literature Search and Review

20-slide cap. ~30 min presentation, then ~5 min live walkthrough, then 15 min Q&A.

**Thesis.** A literature review is not a single prompt; it is a managed pipeline. Five stages, enforced order, bidirectional boomerang on review findings. Same epic, sub-issue, and pull-request rigor introduced in Week 3, plus citation grounding at every step. The goal is a review that reaches its conclusion through evidence, irrespective of whether the evidence is favorable or unfavorable to the working hypothesis. Drift is what an agentic workflow makes easy and what disciplined structure prevents.

The tone matches Weeks 3 and 4: thesis up front, every theoretical point lands on the HBN movie-EEG practicum, every tool decision is justified by *why it improves research output*, not *why it is fashionable*. Real artefacts come from the Annotation Garden Initiative (AGI) research foundation epic, which is the canonical worked example at full scale. The practicum is a smaller-scope reproduction of the same shape so the live demo fits in five minutes.

## Opening

### Slide 1: Title

- Week 5: Literature Search and Review
- Author, course link, Discord link, recording link

### Slide 2: Where we are

- Week 1: git + GitHub (safety net)
- Week 2: Claude Code (the agent)
- Week 3: epic + sub-issues + worktrees + plan + `/review-pr` (structure inside the repo)
- Week 4: CI/CD (automated checks outside the repo)
- Today: the same rigor applied to research output, starting with literature

## Why Structured Literature Reviews

### Slide 3: Three failure modes of unstructured reviews

- **String-of-pearls citation:** one paper -> next paper -> next paper, no thematic argument
- **Recency bias:** the top of the search result page becomes the field
- **Hallucinated references:** plausible author + year + DOI that does not exist
- Manual reviews fall into these traps already; AI accelerates each of them by an order of magnitude

### Slide 4: AI raises the stakes

- An agent will fabricate a credible-sounding citation unless it is forced to ground claims in a corpus it has actually read
- Confirmation bias is mechanical: the agent paraphrases the first half of the search result, ignores the second
- The fix is not "ask the agent to cite better." The fix is **a pipeline where every claim is mechanically traceable to a stored artefact**

### Slide 5: Reframe -- a literature review is a managed pipeline

- Same shape as Week 3: epic with sub-issues, branches, PRs, review
- Plus: citation grounding at every step (cite-the-card rule)
- Plus: a boomerang from review back to direction or collection when gaps surface

## The Pipeline

### Slide 6: The 5-stage pipeline (diagram)

- Direction -> Collect -> Synthesize -> Draft -> Review, with a boomerang arrow from Stage 5 back to Stages 1 and 2
- Order is enforced; drafting before synthesising is a structural error, not a style choice

## Stage 1: Direction

### Slide 7: Direction with `/project:epic-dev`

- Plan-mode the topic into an epic issue and parallel strand sub-issues
- Strands are concurrent collection passes (e.g., tools / data / science)
- Each strand gets its own brief, branch, and PR
- AGI example: `Annotation-Garden/management#3` has Phase 1 (collection), Phase 2 (synthesis), Phase 3 (white paper + direction drafts)

### Slide 8: Strand brief anatomy

- Five fields, every brief: **goal**, **scope**, **per-entry deliverable**, **acceptance criteria**, **out-of-scope**
- The brief is a contract; without it, Stage 2 collects whatever the agent's first search surfaces
- Snippet from `research/_briefs/strand-A-tools.md` annotated with the five fields

## Stage 2: Collect with `opencite`

### Slide 9: `opencite` -- search strategies

- **canonical:** foundational, high-citation works (`opencite canonical "topic" --max 10`)
- **search:** recent or specific (`opencite search "query" --max 20 --sort citations` or `--sort date`)
- **cite:** citation graph traversal (`opencite cite "DOI" --direction both`)
- Combine: canonical for background, search for state-of-the-art, cite to fill gaps
- Two interfaces: the **`/opencite:opencite` skill** drives the workflow with judgement and is what we use in the demo; the **`opencite` CLI** at `github.com/neuromechanist/opencite` is what the skill calls underneath. CLI install: `uv pip install opencite` (persistent) or `uvx opencite` (one-off)

### Slide 10: Batched retrieval and conversion

- `opencite batch-fetch --from-json results.json --convert -o ./papers --summary report.json`
- Output tree: `papers/pdf/`, `papers/markdown/`, `papers/markdown/img/` (mistral converter only)
- License-aware: PDFs only commit when redistribution is allowed; markdown extraction always commits

### Slide 11: The paper-card schema

- One folder per paper: `card.md`, `source.pdf` (if redistributable), `source.md` (always), `meta.json`
- Front-matter: slug, type, year, doi, license, modalities, tags, **agi_relevance**, **pdf_status**
- Six required sections: TL;DR, Summary, Relevance, Notable details, Open questions, Citations
- This schema is the **rigor discriminator**. With it, the corpus is queryable; without it, every entry is a free-form note

### Slide 12: Calibration anchors

- The `agi_relevance` field is useful only if it discriminates
- Anchor examples: a direct dependency = high; a standard tool in scope = medium; tangential background = low
- If more than 40% of entries land at one level, the field has lost discriminative power; recalibrate
- Same logic applies to any rated field; calibration anchors are the cheapest defence against thumb-on-scale

## Stage 3: Synthesize

### Slide 13: Synthesis artefacts -- structure before prose

- AGI Phase 2 produced five docs: tool ontology, dataset hierarchy, science map, gap analysis, scope diagram
- All structured tables and maps. **No prose review yet.**
- Cross-strand references emerge here: a tool used by a dataset, a method enabled by a standard
- The gap analysis is the bridge to Stage 4: it names the claims the prose review will defend

## Stage 4: Draft

### Slide 14: `/manuscript:manuscript-formatting`

- Pick the structure: mini-review, scoping review, narrative review, systematic review, IMRAD background
- For Week 5 we use the **mini-review** structure: thesis up front, thematic sections, no methods or results, citation-rich
- For Week 7 we will revisit the same skill for IMRAD manuscripts

### Slide 15: `/manuscript:manuscript-writing` -- the cite-the-card rule

- Thematic over chronological organisation
- Citation weaving: integral, non-integral, synthesis, contrast
- Abbreviations defined on first use; no em-dashes
- The hard rule: **every claim cites a paper-card by relative path.** No card, no claim
- Snippet from AGI `direction-papers/science-direction.md` showing the cite trail

## Stage 5: Review and Boomerang

### Slide 16: `/manuscript:paper-review`

- Plays the peer-reviewer role: methodological rigor, statistical validity, balance, scope creep
- Findings are tagged by severity; critical and major findings cycle back into the pipeline
- The boomerang: review -> Stage 2 (missing evidence) or Stage 1 (mis-scoped direction)

### Slide 17: Bias and rigor -- the favorable / unfavorable point

- A review of a hypothesis you wanted to confirm should still surface findings against it
- Calibration anchors prevent thumb-on-scale at scoring time
- The cite-the-card rule prevents thumb-on-scale at drafting time
- The boomerang prevents thumb-on-scale at review time
- A review that converges in one shot has either nothing to say or is hiding what it found

## Live Demo and Close

### Slide 18: Demo roadmap

- Topic: literature review on the neural correlates of naturalistic movie watching, organised by four perspectives: **psychophysics**, **action**, **language**, **emotion**. Extends Week 3 HBN movie-watching practicum
- Pre-built in the practicum repo: epic + 4 strand briefs (one per perspective) + 3-5 seed paper-cards per strand + synthesis stub
- Three live actions: add 1 paper via `/opencite:opencite`; weave it into one synthesis paragraph via `/manuscript:manuscript-writing`; critique that paragraph via `/manuscript:paper-review`; if the review surfaces a real gap, walk the boomerang back to Stage 2 -- a likely natural gap is age-effect / developmental coverage given HBN's cohort, but we do not manufacture one

### Slide 19: What today gives you / what's next

- Today: a literature review you can defend, where every claim points at a stored, retrievable paper, and where reviewer feedback updates the corpus instead of being argued away
- Next: Week 6 grant proposals -- starts from a literature review like the one we just built

### Slide 20: What we have / what we do next

- Two columns
  - **Have:** the pipeline shape; the AGI canonical example; the practicum scaffold with strand briefs and seed cards
  - **Do next, live:** add one paper -> weave one paragraph -> review that paragraph -> show the boomerang
- Bottom line: "Questions? Ask while opencite searches."
