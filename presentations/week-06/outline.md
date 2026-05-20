# Week 6 Presentation: Grant Proposal Writing

22-slide deck. ~30 min presentation, then ~5 min live walkthrough, then 15 min Q&A.

**Thesis.** A grant proposal is a managed pipeline, not a long prompt. Five stages, enforced order, bidirectional boomerang on review findings. The Week-5 corpus is the input; the obligation today is to put **deliverables on the page** and defend them against a simulated reviewer panel. Same shape as Week 5; new artefact and new stakes. Three new beats this week: agent-agnostic plugins (Claude Code, Codex CLI, Copilot in VS Code), a self-review skill calibrated to NIH and NSF rubrics (`/grant:grant-review`), and a figure-compliance agent that reads the rendered PDF visually (`/grant:grant-figure-qa`).

The tone matches Weeks 3, 4, and 5: thesis up front, every theoretical point lands on the HBN movie-EEG practicum, every tool decision is justified by *why it improves research output*. Real artefacts come from the Week-5 corpus and a worked R21 example.

## Opening

### Slide 1: Title

- Week 6: Grant Proposal Writing
- Author, course link, Discord link, recording link

### Slide 2: Where we are

- Week 1: git + GitHub (safety net)
- Week 2: Claude Code (the agent)
- Week 3: epic + sub-issues + worktrees + plan + `/review-pr`
- Week 4: CI/CD (automated checks outside the repo)
- Week 5: literature review as a managed pipeline (today's input)
- Today: same pipeline shape, new artefact, deliverables on the page

## Agent-Agnostic and Accessibility

### Slide 3: research-skills is now agent-agnostic

- Three runtimes: Claude Code, Codex CLI, Copilot in VS Code
- Same seven plugins (`opencite`, `manuscript`, `grant`, `scientific-figures`, `neuroinformatics`, `presentation`, `project`)
- Same slash commands, prompts, outputs; only the runtime differs
- This week's demos use Claude Code syntax; every command works identically in the other two

### Slide 4: Why this matters -- accessibility

- A first-year doctoral student with a free GitHub Education pack can now run `/grant:grant-writing` and `/grant:grant-review` without a paid Claude Pro subscription or OpenAI API credits
- The runtime is a deployment choice, not a knowledge prerequisite
- Pick whichever your institution licences or your wallet allows

## Reframe and Pipeline

### Slide 5: Aims = 1-page lit review + deliverables

- The Week-5 corpus is the input
- `cite-the-card` discipline transfers verbatim
- What Aims add over a lit review: measurable deliverables on a timeline
- **Definition of Done shifts.** A lit review is done when the corpus is queryable and the boomerang has run. A grant is done when every aim has a hypothesis, every hypothesis has a deliverable, every deliverable has a date, and the self-review has cycled back at least once

### Slide 6: The 5-stage grant pipeline (hero diagram)

- NOFO -> Aims -> Strategy -> Self-review -> Figure QA
- Boomerang arrow from Stage 4 back to Stages 2 and 3
- Order is enforced. Drafting Aims before parsing the NOFO is a structural error
- Self-review and Figure QA are gates, not polish

## Mechanism and Scoring

### Slide 7: Pick the mechanism first

- Page limits, review criteria, and the page anatomy change with the mechanism
- Cheatsheet table: R01, R21, R03, K99/R00, F31/F32, NSF CAREER -- audience, page budgets, dollar caps, cycles
- The most expensive avoidable error: submitting a K-award as an R-award
- NSF CAREER requires bidirectional integration of research and education plans

### Slide 8: What reviewers score

- NIH study sections score each of five criteria on 1-9 and assign an integrated impact score that is the reviewer's holistic judgement, **not the mean**
- Criteria: Significance, Investigator(s), Innovation, Approach, Environment
- Fundable band typically sits at impact <= 30 in current cycles
- NSF: Intellectual Merit and Broader Impacts on Excellent / Very Good / Good / Fair / Poor
- **A 1 in Significance does not save a 5 in Approach.** Most rejections land on Approach

## Step 0 and Step 1

### Slide 9: Step 0 -- Parse the NOFO

- `/grant:grant-writing` reads the NOFO end-to-end and writes `NOFO.md` -- the scope contract
- Every aim, methods choice, and budget line points back to a NOFO clause
- Common flags: inclusion-of-women / minorities / children language, mandatory data sharing plan formats, narrowly defined eligible populations
- Annotated `NOFO.md` snippet on slide

### Slide 10: Step 1 -- Page budget allocation

- Page limits are hard. Trim **content**, never **spacing**. Reviewers know 9-pt body and 0.4-in margins on sight
- R01 (12 p strategy): Significance ~2 p, Innovation ~1.5 p, Approach ~8.5 p
- R21 (6 p strategy): Significance ~1 p, Innovation ~0.75 p, Approach ~4.25 p
- F31 / F32 strategy follows R21 proportions; applicant background and sponsor / training are separate documents

## Step 2: Specific Aims Page

### Slide 11: Anatomy of a Specific Aims page

- Six blocks, in order, ~650 words on one page:
  1. Opening (2-3 sentences) -- hook + critical gap with statistics
  2. Overarching goal (bold) + scope -- the single most important sentence; appears verbatim in the Strategy
  3. Aim 1 with italicised hypotheses and bolded methodological innovation
  4. Aim 2 -- parallel, independent of Aim 1
  5. Aim 3 -- optional; R21 stops at 2
  6. Expected Impact -- bold header, numbered deliverables that connect back to the opening
- Reviewers spend ~10 minutes on this page

### Slide 12: /grant:grant-writing -- what the skill does

- Workflow, not one-shot draft. Parses NOFO, allocates pages, drafts Aims, drafts Significance / Innovation / Approach with cite-the-card, calls `manuscript:humanizer` for the final natural-writing pass
- Output: `NOFO.md`, `specific-aims.md`, `research-strategy/`, `budget/`
- Working drafts in `drafts/`, submission-ready in `submission/`

### Slide 13: Style rules the skill enforces

- Bold strategically (goal sentence, aim titles, one key innovation per aim, memorable phrases). "If everything is bold, nothing is"
- Italicise hypothesis labels: *Hypothesis 1A:* one sentence, testable, directional
- Active voice. Quantify ("N=24 across 6 months" beats "an adequate sample")
- No em-dashes. Define abbreviations on first use ("Brain Imaging Data Structure (BIDS)" before "BIDS")

## Step 3: Research Strategy

### Slide 14: Research Strategy = Significance / Innovation / Approach

- Three sections in fixed order. The agent will not draft them out of order
- Significance (~2 p R01): Problem -> Gap -> Why it matters -> What success enables
- Innovation (~1.5 p R01): Conceptual / Technical / Methodological. Close with why current approaches fail
- Approach (~8.5 p R01): the largest section because that is where most rejections land

### Slide 15: Approach -- every aim has the same 6-block anatomy

- Rationale (logical next step from cited literature; cites Week-5 paper-cards)
- Methods (cohort, paradigm, N with power justification, acquisition, software, BIDS / HED, link to preliminary data)
- Hypothesis (restated with a directional prediction)
- Analyses (statistical models, multiple-comparison correction, what counts as a positive result; pre-registered if possible)
- Expected outcomes (what each result pattern means + deliverables; tie back to Aims)
- Problems & alternatives (de-risking; the block reviewers look for first)
- **Block 6 is not optional.** It does not need length; it needs honesty about risks and named fallbacks

### Slide 16: Rigor, preliminary data, timeline

- Rigor & reproducibility (~1 p in R01 Approach): biological variables, authentication of reagents and code, blinding/randomisation, pre-registration, open standards (BIDS, HED). Week 9 content gets cited here
- Preliminary data (~1.5-2 p in R01): show feasibility, effect-size estimate that grounds the power analysis, one pipeline-checkpoint figure, one key figure cited from the Approach text
- Timeline + milestones (~0.5 p): Gantt chart with milestone diamonds; reviewers cross-check feasibility against it

## Step 4 and Resubmission

### Slide 17: /grant:grant-review -- simulated study section

- Plays the senior reviewer role; calibrated for the mechanism
- Scores all five NIH criteria on 1-9 + integrated impact estimate
- Boomerang routing by severity:
  - Critical -> Aims (the reviewer surfaced a gap the Aims cannot defend)
  - Major -> Strategy (methodological weakness or missing rigor element)
  - Minor -> in place (prose edits)
- Renders each PDF page to PNG and reads them visually -- catches whitespace economy, figure sizing, layout that source-level review cannot see
- **Convergence in one shot is a red flag.** Run a second adversarial pass

### Slide 18: Resubmissions (A1) -- the Introduction page

- Most proposals are not funded on first submission
- The A1 carries a separate 1-page Introduction responding point-by-point to reviewer concerns
- The skill drafts the Introduction and inserts vertical change bars in the Strategy LaTeX source
- **Respond, do not rebut.** Reviewers see defensive rebuttals more critically than corrected proposals

## Step 5: Figure QA

### Slide 19: /grant:grant-figure-qa -- compliance pass

- Claude Code agent that converts each PDF page to PNG and reads them visually
- Checks: resolution >= 300 dpi at printed size; fonts embedded (Arial / Helvetica NIH; + Times New Roman / Palatino NSF); colour-blind safe palette; axis labels legible at 50% page size; statistical reporting (N, error bars, CIs); caption tightness; whitespace economy
- Reports compliance failures, not aesthetic preferences. Week 8 covers design proper

## Three Defences and Close

### Slide 20: Three defences -- one per stage

- NOFO contract (Step 0): guards against scope drift
- Cite-the-card (Aims / Strategy): guards against hallucinated citations. Carried verbatim from Week 5
- Review boomerang (Step 4): guards against one-shot convergence
- Deliberately stack-redundant. None alone is sufficient
- Punchline: "A grant that passes on the first self-review either has nothing to say or is hiding what it found"

### Slide 21: Live demo roadmap

- Topic: an R21 Specific Aims page for the HBN naturalistic-movie practicum -- the animacy-of-opening-shot ERSP question from Week 3
- Pre-built: `NOFO.md` for an R21 NIMH naturalistic-stimuli call; four anchor cards from Week 5 (Hasson 2004, Hasson 2008, Huth 2016, Saarimaki 2016); draft stub for `specific-aims.md`
- Three live actions: `/grant:grant-writing` drafts the overarching goal and Aim 1; `/grant:grant-review` on that draft; `/grant:grant-figure-qa` on the preliminary-data figure
- We do not manufacture a finding. A likely natural one is "preliminary data shows the pipeline runs end-to-end on a subset but does not yet show the animacy effect" -- if it surfaces, we describe the boomerang back to Aim 1 aloud (we do not run it on stage, to stay in the time box)

### Slide 22: What today gives you / what's next

- Today: a Specific Aims page where every claim points at a Week-5 paper-card, every deliverable has a date, and the self-review has cycled at least once
- Next: Week 7 manuscript preparation -- a manuscript Introduction is structurally the Aims expanded; Methods and Results expand the Approach
