# Week 6 Guide: Grant Proposal Writing

*A grant proposal is not a single prompt; it is a managed pipeline. Five stages, enforced order, bidirectional boomerang on review findings. Notice of Funding Opportunity (NOFO) parse, Specific Aims, Research Strategy, simulated study-section review, and figure compliance, with a boomerang from review back to Aims or Strategy. The single most useful idea in this guide: **a Specific Aims page is a one-page literature review with deliverables**. The Week-5 corpus is the input; the obligation this week is to put deliverables on the page and defend them against a simulated reviewer panel.*

This guide accompanies [Week 6](../sessions/week-06/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). Three additional shifts make this week different from earlier ones. First, the `research-skills` plugin set now runs across three coding-agent runtimes (Claude Code, OpenAI's Codex command-line interface (CLI), and GitHub Copilot in Visual Studio Code), which collapses the cost gate that previously kept the workflow out of reach for trainees and labs without paid subscriptions. Second, the pipeline ships a self-review skill (`/grant:grant-review`) calibrated to National Institutes of Health (NIH) and National Science Foundation (NSF) scoring rubrics. Third, a separate figure-quality-assurance agent (`/grant:grant-figure-qa`) reads the rendered PDF visually before submission to catch resolution, font, and whitespace failures that source-level review cannot see.

---

## research-skills Is Now Agent-Agnostic

Between Week 5 and Week 6 the `research-skills` plugin set landed across three coding-agent runtimes. The same seven plugins (`opencite`, `manuscript`, `grant`, `scientific-figures`, `neuroinformatics`, `presentation`, `project`) now run from Claude Code (CLI plus integrated development environment (IDE) integrations), OpenAI's Codex CLI (curated for the OpenAI primary runtime), and GitHub Copilot in Visual Studio Code (free tier for verified students and educators). The slash commands, prompts, and outputs are identical; only the runtime differs.

A first-year doctoral student with a free GitHub Education pack can now run `/grant:grant-writing` and `/grant:grant-review` without a paid Claude Pro subscription or OpenAI API credits. The runtime is a deployment choice, not a knowledge prerequisite. Pick whichever your institution licences (or your wallet allows); the workflow does not change.

The rest of this guide demonstrates commands using Claude Code syntax (`/grant:grant-writing`), but every command works identically in Codex CLI and Copilot in VS Code.

---

## Reframe: A Specific Aims Page Is a 1-Page Literature Review with Deliverables

The Week-5 corpus is the input to this week's drafting. The synthesis documents (taxonomies, hierarchies, gap analysis) feed the Significance section directly, and `cite-the-card` discipline transfers verbatim: every Significance and Innovation claim points to a `card.md` by relative path. What the Aims add is the obligation a lit review does not have, namely measurable deliverables on a timeline.

The Definition of Done shifts. A literature review is "done" when the corpus is queryable and the review boomerang has run. A grant is "done" when every aim has a hypothesis, every hypothesis has a deliverable, every deliverable has a date, and the self-review has cycled back at least once.

---

## The 5-Stage Grant Pipeline

```text
[ 1. NOFO ] -> [ 2. Aims ] -> [ 3. Strategy ] -> [ 4. Self-review ] -> [ 5. Figure QA ]
                  ^                                       |
                  +---------------------------------------+
                              boomerang on findings
```

Five stages, enforced order. Drafting Aims before parsing the NOFO is a structural error. Self-review and Figure QA are not optional polish; they are gates.

| Stage | Tool | Output |
|-------|------|--------|
| 1. NOFO | `/grant:grant-writing` (Step 0) | `NOFO.md` -- the scope contract |
| 2. Aims | `/grant:grant-writing` | `specific-aims.md` (1 page, 6 blocks) |
| 3. Strategy | `/grant:grant-writing` | `significance.md`, `innovation.md`, `approach.md` |
| 4. Self-review | `/grant:grant-review` | Severity-tagged findings; boomerang back to Stage 2 or 3 |
| 5. Figure QA | `/grant:grant-figure-qa` | Per-figure compliance report on the rendered PDF |

---

## Pick the Mechanism First

Page limits, review criteria, and the page anatomy itself change with the mechanism. The `grant-writing` skill takes the mechanism as a parameter and pre-populates page budgets and required sections.

| Mechanism | Audience | Aims | Strategy | Budget cap | Cycle |
|-----------|----------|------|----------|------------|-------|
| **R01** | Established principal investigator (PI), full project | 1 p | 12 p | ~$500K/yr direct | 3 cycles/year |
| **R21** | Exploratory / high-risk pilot | 1 p | 6 p | $275K / 2 yr total | 3 cycles/year |
| **R03** | Small / secondary-data project | 1 p | 6 p | $50K/yr / 2 yr | 3 cycles/year |
| **K99/R00** | Postdoc-to-independence | 1 p | 12 p + candidate + mentoring | ~$249K + R00 phase | 3 cycles/year |
| **F31 / F32** | Predoctoral / postdoctoral fellowship | 1 p | 6 p + applicant + sponsor | stipend + tuition | 3 cycles/year |
| **NSF CAREER** | Pre-tenure faculty, integrated | 1 p summary | 15 p description | >=$400K / 5 yr | annual (July deadline) |

NSF CAREER proposals require bidirectional integration of research and education plans; the `grant-writing` skill emits a separate education-plan section that is consumed by the research section and vice versa. NSF standard grants follow a Project Summary plus Project Description (15 pages) structure with separate Intellectual Merit and Broader Impacts paragraphs.

Picking the wrong mechanism is the most expensive avoidable error. A K-award proposal submitted as an R-award gets returned without review. Read the NOFO requirements carefully and check the mechanism with your sponsored projects office before drafting.

---

## What Reviewers Score

NIH study sections score each of five criteria on a 1-9 scale and assign an integrated impact score that is the reviewer's holistic judgement, **not the mean** of the five scores:

| Criterion | Key question |
|-----------|--------------|
| **Significance** | Is the problem important? Will the field advance? |
| **Investigator(s)** | Is the team qualified for the work and career stage? |
| **Innovation** | Are concepts and methods novel? Does it challenge the status quo? |
| **Approach** | Is the design rigorous? Are methods appropriate? Feasibility? |
| **Environment** | Does the institution support the work? |

Each score reads 1 (Exceptional, no weaknesses) through 5 (Good, moderate weaknesses) to 9 (Poor, fundamentally flawed). The integrated impact score similarly runs 1-9, and the "fundable band" varies by institute and cycle but typically sits at impact <= 30 in current cycles.

NSF panels rate Intellectual Merit and Broader Impacts separately on Excellent / Very Good / Good / Fair / Poor scales.

A 1 in Significance does not save a 5 in Approach. The integrated impact score punishes any single weak criterion. Most reviewer comments and most rejections land on Approach, which is why the Approach section gets the largest page budget by far.

---

## Step 0: Parse the NOFO into a Scope Contract

The first thing `/grant:grant-writing` does is read the NOFO end-to-end and write `NOFO.md` with the extracted requirements. Every aim, methods choice, and budget line in the rest of the proposal must point back to one of these requirements.

```yaml
# NOFO.md
mechanism: R21
agency: NIH / NIMH
NOFO_url: https://grants.nih.gov/grants/guide/par-files/PAR-25-XXX.html
deadline: 2026-06-16
next_cycle: 2026-10-16
page_limits:
  aims: 1
  strategy: 6
budget_cap: $275K / 2 yr total
required_areas: [naturalistic stimuli, developmental cohorts]
special: data_sharing_plan, human_subjects_protections
eligible_PIs: any career stage
```

The skill flags any clause that deviates from the standard mechanism template. Common surprises: extra inclusion-of-women / minorities / children language, mandatory data sharing plan formats, narrowly defined eligible populations.

---

## Step 1: Allocate the Page Budget

Page limits are hard constraints. Trim **content**, never **spacing**: reviewers know 9-point body and 0.4-inch margins on sight, and program officers reject pages that exceed the limit before they reach review.

Starting allocations (the skill tunes them after Step 0):

- **R01 (12 pages strategy)** -- Significance ~2 p, Innovation ~1.5 p, Approach ~8.5 p (with preliminary data ~2 p, aim-by-aim breakdown ~5 p, rigor and reproducibility ~1 p, timeline ~0.5 p).
- **R21 (6 pages strategy)** -- Significance ~1 p, Innovation ~0.75 p, Approach ~4.25 p.
- **F31 / F32 (6 pages strategy + applicant + sponsor)** -- strategy follows R21 proportions; applicant background and sponsor / training plan are separate documents.

---

## Step 2: Anatomy of a Specific Aims Page

The Aims page is six blocks, in order, fitting one page at ~650 words:

1. **Opening (2-3 sentences)** -- hook + critical gap. Start broad, narrow quickly. Cite key statistics to establish urgency.
2. **Overarching goal (bold, 1 sentence) + scope** -- the project's ultimate objective and the innovative approach. The single most important sentence on the page; it appears verbatim again in the Strategy.
3. **Aim 1 (bold title with action verb)** -- one to two hypotheses in italic, each followed by "We will..." that bolds the methodological innovation.
4. **Aim 2 (parallel structure; independent of Aim 1)** -- failure of one aim should not prevent completion of the other.
5. **Aim 3 (optional; R21 typically stops at 2)** -- include only when the project scope requires it.
6. **Expected Impact (bold header, numbered deliverables)** -- concrete deliverables that connect back to the opening gap.

Reviewers spend ~10 minutes on this one page. Every sentence earns its place or comes out.

---

## /grant:grant-writing -- What the Skill Does

The skill is a workflow, not a one-shot draft. It parses the NOFO, allocates pages, drafts Aims with the 6-block anatomy, drafts Significance / Innovation / Approach with `cite-the-card` discipline carried in from Week 5, and calls `manuscript:humanizer` for a final natural-writing pass that strips AI fingerprints.

```bash
$ /grant:grant-writing

# writes:
NOFO.md
specific-aims.md
research-strategy/...
budget/...
```

The skill writes to a directory tree that mirrors the canonical layout in the `grant-writing` SKILL.md reference. Working drafts live in `drafts/`; submission-ready documents live in `submission/`.

### Style rules the skill enforces

- **Bold strategically.** The overarching goal sentence, aim titles, one key innovation per aim, memorable phrases. "If everything is bold, nothing is."
- **Italicise hypothesis labels.** *Hypothesis 1A:* one sentence, testable, directional. Continuation on the same line if space is tight.
- **Active voice. Quantify.** "We will demonstrate" beats "It will be demonstrated"; "N=24 across 6 months" beats "an adequate sample".
- **No em-dashes. Define abbreviations on first use.** "Brain Imaging Data Structure (BIDS)" before "BIDS"; commas, semicolons, or parentheses instead of em-dashes.

---

## Step 3: Research Strategy in Three Parts

The Research Strategy is three sections in fixed order: Significance, Innovation, Approach. The agent will not draft them out of order.

**Significance (~2 pages for an R01)** earns the right to ask the question. The structure: Problem (scope + quantification) -> Gap (what remains unknown) -> Why it matters (field / clinical / societal) -> What success enables (downstream impact).

**Innovation (~1.5 pages for an R01)** justifies the bet. Distinguish three kinds of innovation: Conceptual (new hypothesis or framing), Technical (new methods or instrumentation), Methodological (analyses and study design). Close with a paragraph on why current approaches fail and the proposed work resolves them.

**Approach (~8.5 pages for an R01)** delivers the work. Every aim follows the same 6-block anatomy:

1. **Rationale** -- why this aim is a logical next step from the cited literature. Cites paper-cards from Week 5.
2. **Methods** -- cohort, paradigm, N with power justification, acquisition, software, standards (BIDS, Hierarchical Event Descriptors (HED)). Links to preliminary data.
3. **Hypothesis** -- restated from Aims with a directional prediction (effect size, sign, latency). One sentence each.
4. **Analyses** -- statistical models, multiple-comparison correction, what counts as a positive result. Pre-registered if possible.
5. **Expected outcomes** -- what each result pattern would mean plus the deliverables (figure, code, dataset). Tie back to the Specific Aims.
6. **Problems & alternatives** -- what could go wrong, pre-named contingency branches, stop conditions. De-risks the bet.

Block 6 is what reviewers look for first. Approaches that skip the Problems & Alternatives block read as naive. The block does not need to be long; it needs to be honest about what could go wrong and name a specific fallback for each risk.

---

## Rigor and Reproducibility, Preliminary Data, Timeline

Three under-loved sub-sections of Approach that the agent insists on.

- **Rigor and reproducibility (~1 page in R01 Approach)** -- biological variables (NIH sex-as-a-biological-variable policy applies), authentication of reagents and datasets and code versions, blinding and randomisation, analysis pre-registration, open standards (BIDS, HED for our practicum). The Rigor block is where the Week-9 Neuroinformatics content gets cited.
- **Preliminary data (~1.5-2 pages in R01)** -- show feasibility ("we can already do this"), an effect-size estimate that grounds the power analysis, a pipeline checkpoint figure (BIDS import + independent component analysis (ICA) + event-related spectral perturbation (ERSP) for the practicum), and one key figure that is cited from the Approach text.
- **Timeline + milestones (~0.5 page)** -- a Gantt chart with milestone diamonds. Reviewers read this for feasibility cross-check.

---

## Step 4: /grant:grant-review -- the Simulated Study Section

`/grant:grant-review` plays the senior reviewer role with calibration for the mechanism. An R21 is not held to R01 preliminary-data standards; a K-award emphasises career development over research scope; a DP2 rewards bold innovative thinking from new investigators.

The skill scores all five NIH criteria on 1-9, produces an integrated impact estimate, and tags findings by severity. The severity tag is the entry point for the boomerang:

- **Critical findings -> Aims.** The reviewer surfaced a gap the Aims cannot defend. Revise the Aims and re-run the pipeline.
- **Major findings -> Strategy.** The Approach has a methodological weakness or missing rigor element. Revise the Strategy.
- **Minor findings -> in place.** Prose edits; no cycle needed.

The skill also renders each PDF page to portable network graphics (PNG) and reads them visually, flagging whitespace economy, figure sizing, and layout issues that source-level review cannot see.

Convergence in one shot is a red flag. A first-draft review that passes everything either means the review is shallow or the proposal is hiding what it found. Run a second pass with adversarial framing if the first converges too cleanly.

---

## Resubmissions (A1) -- the Introduction Page

When a proposal is not funded on the first submission (most are not), the resubmission carries a separate 1-page Introduction page that responds to reviewer concerns point-by-point. The skill drafts the Introduction and inserts vertical change bars in the Strategy LaTeX source.

The tone rule: **respond, do not rebut.** Mark every change. The Introduction is 1 page; the body shows the work. Rebut only the genuinely wrong critiques; otherwise just respond. Reviewers see defensive rebuttals more critically than they see corrected proposals.

---

## Step 5: /grant:grant-figure-qa -- Figure Compliance

`/grant:grant-figure-qa` is a Claude Code agent (in `plugins/grant/agents/grant-figure-qa.md`) that converts each PDF page to PNG and reads them visually. It checks:

- Resolution >= 300 dots per inch (dpi) at printed size
- Fonts embedded (Arial / Helvetica for NIH; Arial / Helvetica / Times New Roman / Palatino for NSF)
- Colour-blind safe palette (CB-pass)
- Axis labels legible at 50% page size
- Statistical reporting present (N, error bars, confidence intervals)
- Caption tightness (no duplication of body text)
- Whitespace economy (a half-page of empty space in the Approach is a missed half-page of preliminary data or rigor)

The QA agent reports compliance failures, not aesthetic preferences. For deeper figure-design work (composition, panel layout, scientific narrative), Week 8 walks through the `scientific-figures` plugin.

---

## Three Defences -- One per Stage

The pipeline's mechanical defences against thumb-on-scale are deliberately stack-redundant, one per stage. None alone is sufficient.

- **NOFO contract (Step 0).** Every aim, methods choice, and budget line points back to a NOFO clause. Guards against scope drift.
- **Cite-the-card (Aims / Strategy).** Every Significance and Innovation claim links to a Week-5 paper-card. Guards against hallucinated citations. Carried verbatim from Week 5.
- **Review boomerang (Step 4).** Critical findings cycle back to Aims or Strategy, not just to prose edits. Guards against one-shot convergence.

A grant that "passes" on the first self-review either has nothing to say or is hiding what it found.

---

## Live Walkthrough -- The Practicum

The Week 6 session ends with a live walkthrough using the Week-5 corpus as the input. Topic: an R21 Specific Aims page for the Healthy Brain Network (HBN) naturalistic-movie practicum -- the animacy-of-opening-shot ERSP question from Week 3.

Pre-built state in [`sessions/week-06/practicum/`](https://github.com/OpenScience-Collective/agentic-research-course/tree/main/sessions/week-06/practicum):

- `NOFO.md` for an R21 NIMH naturalistic-stimuli call
- Four anchor paper-cards carried in from Week 5 (Hasson 2004, Hasson 2008, Huth 2016, Saarimaki 2016)
- Draft stub for `specific-aims.md` with the 6-block scaffold

Three live actions:

1. **Run `/grant:grant-writing`** -- draft the overarching goal and Aim 1 from the corpus and `NOFO.md`.
2. **Run `/grant:grant-review`** on that draft. Walk through whatever findings surface, in real time.
3. **Run `/grant:grant-figure-qa`** against the preliminary-data figure carried in from Week 5.

We do not manufacture a finding. A likely natural finding given the practicum's seed-card distribution is that the **preliminary data shows the pipeline runs end-to-end on a subset, but does not yet show the animacy effect**. If that surfaces in the live review, we describe the boomerang back to Aim 1 aloud -- we do not run it on stage, to stay in the time box.

---

## Before Next Week

- Install [`research-skills`](https://github.com/neuromechanist/research-skills) if not already installed; it bundles `grant`, `manuscript`, `opencite`, `scientific-figures`, `neuroinformatics`, `project`, and `presentation`.
- Pick a real NOFO from the NIH Guide for Grants and Contracts ([grants.nih.gov/grants/guide](https://grants.nih.gov/grants/guide)) or NSF Program Announcements that matches your research area.
- Draft a one-paragraph version of your overarching goal sentence (the single bold sentence the Aims page hinges on).
- Bring an existing Specific Aims page if you have one; the Week 6 office hours pass it through `/grant:grant-review` in real time.

Week 7 starts from the Aims and Strategy produced here: a manuscript's Introduction is structurally the Aims page expanded; Methods and Results expand the Approach.
