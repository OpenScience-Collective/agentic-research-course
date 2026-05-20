# Week 6: Grant Proposal Writing

A grant proposal is not a single prompt; it is a managed pipeline that composes the same way the Week 5 literature review does. Notice of Funding Opportunity (NOFO) parse, Specific Aims, Research Strategy, simulated study-section review, and figure compliance, with a boomerang from review back to Aims or Strategy. The single most useful idea in this session: **a Specific Aims page is a one-page literature review with deliverables**. The Week-5 corpus is the input; the obligation today is to put deliverables on the page and defend them against a simulated reviewer panel.

Three additional shifts make this week different from earlier ones. First, the `research-skills` plugin set now runs across three coding-agent runtimes (Claude Code, OpenAI's Codex command-line interface (CLI), and GitHub Copilot in Visual Studio Code), which collapses the cost gate that previously kept the workflow out of reach for trainees and labs without paid subscriptions. Second, the pipeline ships a self-review skill (`/grant:grant-review`) calibrated to National Institutes of Health (NIH) and National Science Foundation (NSF) scoring rubrics. Third, a separate figure-quality-assurance agent (`/grant:grant-figure-qa`) reads the rendered PDF visually before submission to catch resolution, font, and whitespace failures that source-level review cannot see.

## Learning Objectives

By the end of this session, you will:

- Frame a grant proposal as a **5-stage pipeline**: NOFO, Aims, Strategy, self-review, figure quality assurance (QA)
- Pick the right NIH or NSF mechanism (R01, R21, R03, K99/R00, F31/F32, NSF CAREER) and budget pages accordingly
- Draft a Specific Aims page with the 6-block anatomy and a measurable deliverables list
- Write a Research Strategy with the Significance / Innovation / Approach order enforced and `cite-the-card` discipline carried in from Week 5
- Use `/grant:grant-review` to simulate a study section and read the boomerang of findings back into the Aims or Strategy
- Use `/grant:grant-figure-qa` to validate figure compliance against agency standards (resolution, embedded fonts, colour-blind safe palettes, whitespace economy)
- Recognise the three mechanical defences (NOFO contract, cite-the-card, review boomerang) and why they are deliberately stack-redundant
- Run the entire pipeline from any of three runtimes: Claude Code, Codex CLI, or Copilot in VS Code

## The 5-Stage Pipeline

```
[ 1. NOFO ] -> [ 2. Aims ] -> [ 3. Strategy ] -> [ 4. Self-review ] -> [ 5. Figure QA ]
                  ^                                       |
                  +---------------------------------------+
                              boomerang on findings
```

| Stage | Tool | Output |
|-------|------|--------|
| 1. NOFO | `/grant:grant-writing` (Step 0) | `NOFO.md` -- the scope contract |
| 2. Aims | `/grant:grant-writing` | `specific-aims.md` (1 page, 6 blocks) |
| 3. Strategy | `/grant:grant-writing` | `significance.md`, `innovation.md`, `approach.md` |
| 4. Self-review | `/grant:grant-review` | Severity-tagged findings; boomerang back to Stage 2 or 3 |
| 5. Figure QA | `/grant:grant-figure-qa` | Per-figure compliance report on the rendered PDF |

Order is enforced. Drafting Aims before parsing the NOFO is a structural error. Self-review and Figure QA are not optional polish; they are gates.

## Outline (30-45 min talk + 15 min Q&A)

### Part 1: Agent-agnostic, accessible (4 min)

- `research-skills` now runs on three runtimes: Claude Code, Codex CLI, Copilot in VS Code. Same slash commands, same prompts, same outputs; only the runtime differs
- A first-year doctoral student with a free GitHub Education pack can now run `/grant:grant-writing` and `/grant:grant-review` without a paid Claude Pro subscription or OpenAI API credits
- Reframe carried in from Week 5: structured pipelines beat one-shot prompts. Same shape, new artefact

### Part 2: Aims = lit review + deliverables (3 min)

- The Week-5 corpus is the input; synthesis docs feed the Significance section directly
- `cite-the-card` discipline transfers verbatim: every Significance and Innovation claim points to a `card.md` by relative path
- What Aims add over a lit review: measurable deliverables on a timeline
- **Definition of Done shifts.** A lit review is "done" when the corpus is queryable and the boomerang has run. A grant is "done" when every aim has a hypothesis, every hypothesis has a deliverable, every deliverable has a date, and the self-review has cycled back at least once

### Part 3: The 5-stage grant pipeline (2 min)

- Hero diagram. NOFO -> Aims -> Strategy -> Self-review -> Figure QA, with a boomerang from Stage 4 back to Stages 2 and 3
- Mechanical defence at each stage: NOFO contract (Step 0), cite-the-card (Aims / Strategy), review boomerang (Step 4)

### Part 4: Pick the mechanism first (4 min)

- Page limits, review criteria, and the page anatomy itself change with the mechanism. The skill takes the mechanism as a parameter
- Cheatsheet table: R01, R21, R03, K99/R00, F31/F32, NSF CAREER -- audience, page budgets, dollar caps, cycles
- The most expensive avoidable error: submitting a K-award as an R-award. Read the NOFO and check with sponsored projects before drafting
- NSF CAREER requires bidirectional integration of research and education plans

### Part 5: What reviewers score (3 min)

- NIH study sections score each of five criteria on 1-9 and assign an integrated impact score that is **not the mean** of the five
- Criteria: Significance, Investigator(s), Innovation, Approach, Environment
- Fundable band typically sits at impact <= 30 in current cycles (varies by institute and cycle)
- NSF panels rate Intellectual Merit and Broader Impacts separately on Excellent / Very Good / Good / Fair / Poor
- **A 1 in Significance does not save a 5 in Approach.** Most rejections land on Approach, which is why Approach gets the largest page budget

### Part 6: Step 0 -- Parse the NOFO into a Scope Contract (3 min)

- The first thing `/grant:grant-writing` does is read the NOFO end-to-end and write `NOFO.md` with the extracted requirements
- Every aim, methods choice, and budget line in the rest of the proposal must point back to a NOFO clause
- Common surprises the skill flags: extra inclusion-of-women / minorities / children language, mandatory data sharing plan formats, narrowly defined eligible populations

### Part 7: Step 1 -- Allocate the Page Budget (2 min)

- Page limits are hard. Trim **content**, never **spacing**. Reviewers know 9-pt body and 0.4-in margins on sight
- R01 (12 p strategy): Significance ~2 p, Innovation ~1.5 p, Approach ~8.5 p
- R21 (6 p strategy): Significance ~1 p, Innovation ~0.75 p, Approach ~4.25 p
- F31 / F32 (6 p strategy + applicant + sponsor): strategy follows R21 proportions

### Part 8: Step 2 -- Anatomy of a Specific Aims Page (5 min)

- Six blocks, in order, fitting one page at ~650 words:
  1. **Opening (2-3 sentences)** -- hook + critical gap with statistics
  2. **Overarching goal (bold, 1 sentence) + scope** -- single most important sentence on the page; appears verbatim in the Strategy
  3. **Aim 1** -- 1-2 italicised hypotheses; each followed by a "We will..." that bolds the methodological innovation
  4. **Aim 2** -- parallel structure; independent of Aim 1
  5. **Aim 3 (optional; R21 stops at 2)** -- include only when scope requires
  6. **Expected Impact** -- bold header, numbered deliverables that connect back to the opening gap
- Reviewers spend ~10 minutes on this one page. Every sentence earns its place or comes out

### Part 9: /grant:grant-writing in action (3 min)

- Workflow, not a one-shot draft: parses NOFO, allocates pages, drafts Aims (6-block), drafts Significance / Innovation / Approach with cite-the-card, calls `manuscript:humanizer` for the final natural-writing pass
- Style rules the skill enforces: bold strategically, italicise hypothesis labels, active voice with quantification, no em-dashes, define abbreviations on first use
- Output layout: working drafts in `drafts/`, submission-ready documents in `submission/`

### Part 10: Step 3 -- Research Strategy in Three Parts (5 min)

- Significance (~2 p R01): Problem -> Gap -> Why it matters -> What success enables
- Innovation (~1.5 p R01): Conceptual / Technical / Methodological. Close with why current approaches fail
- Approach (~8.5 p R01): every aim follows the same 6-block anatomy: Rationale, Methods, Hypothesis, Analyses, Expected outcomes, Problems & alternatives
- **Block 6 is what reviewers look for first.** Skipping Problems & Alternatives reads as naive; it does not need length, it needs honesty

### Part 11: Rigor, Preliminary Data, Timeline (2 min)

- Rigor & reproducibility (~1 p in R01 Approach): biological variables (NIH sex-as-a-biological-variable), authentication of reagents and code versions, blinding and randomisation, pre-registration, open standards (BIDS, Hierarchical Event Descriptors). Cite Week 9 content here
- Preliminary data (~1.5-2 p in R01): show feasibility, effect-size estimate that grounds the power analysis, a pipeline checkpoint figure (BIDS import + ICA + ERSP for the practicum), one key figure cited from Approach text
- Timeline + milestones (~0.5 p): Gantt with milestone diamonds. Reviewers cross-check feasibility against this

### Part 12: Step 4 -- /grant:grant-review (3 min)

- Plays the senior reviewer role with calibration for the mechanism. An R21 is not held to R01 preliminary-data standards
- Scores all five NIH criteria on 1-9, produces an integrated impact estimate, and tags findings by severity
- Boomerang routing:
  - **Critical -> Aims.** The reviewer surfaced a gap the Aims cannot defend
  - **Major -> Strategy.** Methodological weakness or missing rigor element
  - **Minor -> in place.** Prose edits only
- Also renders each PDF page to PNG and reads them visually -- catches whitespace economy, figure sizing, and layout that source-level review cannot see
- **Convergence in one shot is a red flag.** Run a second adversarial pass if the first converges cleanly

### Part 13: Resubmissions (A1) (2 min)

- A separate 1-page Introduction responds point-by-point to reviewer concerns
- The skill drafts the Introduction and inserts vertical change bars in the Strategy LaTeX source
- Tone rule: **respond, do not rebut.** Reviewers see defensive rebuttals more critically than corrected proposals
- The body shows the work; the Introduction is 1 page

### Part 14: Step 5 -- /grant:grant-figure-qa (2 min)

- Claude Code agent that converts each PDF page to PNG and reads them visually
- Checks: resolution >= 300 dpi at printed size; fonts embedded (Arial / Helvetica for NIH; + Times New Roman / Palatino for NSF); colour-blind safe palette; axis labels legible at 50% page size; statistical reporting present (N, error bars, CIs); caption tightness; whitespace economy
- Reports compliance failures, not aesthetic preferences. Week 8 covers figure design proper

### Part 15: Three Defences -- One per Stage (1 min)

- NOFO contract (Step 0): guards against scope drift
- Cite-the-card (Aims / Strategy): guards against hallucinated citations. Carried verbatim from Week 5
- Review boomerang (Step 4): guards against one-shot convergence
- Deliberately stack-redundant. None alone is sufficient

### Part 16: Live Walkthrough (5 min)

Topic: an R21 Specific Aims page for the HBN naturalistic-movie practicum -- the animacy-of-opening-shot ERSP question from Week 3.

Pre-built state:

- `NOFO.md` for an R21 NIMH naturalistic-stimuli call
- Four anchor paper-cards carried in from Week 5 (Hasson 2004, Hasson 2008, Huth 2016, Saarimaki 2016)
- Draft stub for `specific-aims.md` with the 6-block scaffold

Three live actions:

1. Run `/grant:grant-writing` -- draft the overarching goal and Aim 1 from the corpus and `NOFO.md`
2. Run `/grant:grant-review` on that draft. Walk through whatever findings surface, in real time
3. Run `/grant:grant-figure-qa` against the preliminary-data figure carried in from Week 5

**We do not manufacture a finding.** A likely natural finding given the practicum's seed-card distribution is that the preliminary data shows the pipeline runs end-to-end on a subset, but does not yet show the animacy effect. If that surfaces in the live review, we describe the boomerang back to Aim 1 aloud (we do not run it on stage, to stay in the time box).

### Q&A (15 min)

## Key Concepts

- **5-stage grant pipeline:** NOFO, Aims, Strategy, Self-review, Figure QA. Order enforced; bidirectional boomerang on findings.
- **NOFO contract:** The first artefact the skill writes (`NOFO.md`). Every aim, method, and budget line must point back to a clause in it. Guards against scope drift.
- **Specific Aims page:** A one-page literature review with deliverables. The single most-read page in the proposal. Six blocks, ~650 words, bold the goal sentence and aim titles, italicise hypothesis labels.
- **6-block aim anatomy (Approach):** Rationale, Methods, Hypothesis, Analyses, Expected outcomes, Problems & alternatives. Block 6 is what reviewers look for first.
- **Integrated impact score:** NIH's holistic 1-9 score, **not the mean** of the five criteria. A single weak criterion sinks an otherwise strong proposal.
- **Cite-the-card:** Every Significance and Innovation claim links to a Week-5 paper-card by relative path. Same rule as the lit review; hallucinated citations remain mechanically impossible.
- **Review boomerang:** Critical findings cycle back to Aims; major findings cycle back to Strategy; minor findings are prose edits. Same shape as the Week-5 boomerang.
- **Three defences:** NOFO contract, cite-the-card, review boomerang. One per stage, deliberately stack-redundant.

## Agent-Runtime Matrix

| Plugin | Claude Code | Codex CLI | Copilot in VS Code |
|--------|-------------|-----------|---------------------|
| `opencite` | yes | yes | yes |
| `manuscript` | yes | yes | yes |
| `grant` | yes | yes | yes |
| `scientific-figures` | yes | yes | yes |
| `neuroinformatics` | yes | yes | yes |
| `presentation` | yes | yes | yes |
| `project` | yes | yes | yes |

The slash command, prompt, and output are identical across runtimes. Pick whichever your institution licences or your wallet allows.

## Before Next Session

- Install `research-skills` if not already installed; it bundles `grant`, `manuscript`, `opencite`, `scientific-figures`, `neuroinformatics`, `project`, and `presentation`
- Pick a real NOFO from the NIH Guide for Grants and Contracts ([grants.nih.gov/grants/guide](https://grants.nih.gov/grants/guide)) or NSF Program Announcements that matches your research area
- Draft a one-paragraph version of your overarching goal sentence (the single bold sentence the Aims page hinges on)
- Bring an existing Specific Aims page if you have one; office hours will pass it through `/grant:grant-review` in real time

## Common Pitfalls (Watched For in Live Demo)

- **Drafting Aims before parsing the NOFO.** Without the NOFO contract, the agent invents requirements the funder did not write. Step 0 exists to prevent this.
- **Picking the wrong mechanism.** A K-award submitted as an R-award gets returned without review. The mechanism cheatsheet is not decoration.
- **Trimming spacing instead of content to hit page limits.** Reviewers know 9-pt body and 0.4-in margins on sight. Program officers reject pages that exceed the limit before the review starts.
- **Skipping the Problems & Alternatives block.** It is what reviewers look for first. Length is not the point; honesty about risks and named fallbacks is.
- **One-shot self-review convergence.** A first-draft review that passes everything is shallow or the proposal is hiding what it found. Re-run with adversarial framing.
- **Aesthetic figure decisions in Figure QA.** The skill checks **compliance**, not design. Week 8 covers design proper.

## What This Session Does Not Cover

- Budget construction and justification (covered briefly; full treatment is institution-specific and out of scope for one session)
- Human subjects, inclusion-of-women / minorities / children narratives, vertebrate animals, biohazards -- the skill flags when they apply, but their substantive content sits with the lab and the institutional review board
- Biosketch construction; SciENcv handles that and the skill points to it
- Department-specific or institute-specific narratives (e.g., NIDA vs. NIMH preferences)

## Related Sessions

- **Week 5** produces the corpus this week consumes. The cite-the-card rule transfers verbatim
- **Week 7** consumes the Aims and Strategy produced here; a manuscript Introduction is structurally the Aims expanded; Methods and Results expand the Approach
- **Week 8** covers figure design proper (composition, panel layout, scientific narrative). This week's Figure QA agent checks compliance only
- **Week 9** content (BIDS, HED) is what the Rigor & Reproducibility block of an Approach section cites
