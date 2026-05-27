# Week 8 Presentation Outline

## Title

Week 8: Scientific Figures

## Subtitle

A 5-step figure pipeline that respects physical size, validates fonts before export, and runs deterministic plus aesthetic QA -- powered by the `figures` plugin (5 skills + 1 QA agent).

## Length

~30 min presentation + ~5 min live walkthrough + 15 min Q&A.

## Audience

Researchers who completed Weeks 5-7 and now want to produce publication-grade figures inside the same repository as the manuscript. No assumed background in Inkscape, Adobe Illustrator, or vector authoring. Familiarity with matplotlib is helpful but not required; SciencePlots fixes the 80% case for trainees who learned matplotlib on the job.

## Core Message

A publication figure is not a single prompt; it is a managed 5-step pipeline (Plan, Build, Compose, Validate, Export) where every step has a mechanical defence and the figure source lives next to the manuscript. The single most useful idea this week: **`validate_fonts.py` is to figures what `cite-the-card` is to prose** -- a deterministic check that converts "the figure looks small" into "Frequency (Hz) is 4.5 pt, Nature requires >= 5 pt". The `figures` plugin expanded from 3 skills into 5 skills + a `figure-qa` agent between Weeks 7 and 8; the new shape is a deliberate response to the react-pdf workflow's structural failures.

## Narrative Arc

The arc this week is failure -> fix -> defences -> walkthrough.

- **Failure (slide 3).** Show the react-pdf workflow's broken output: shrunk fonts under 5 pt, panel dimensions that drifted during flexbox layout. Land this hard; it carries the motivation for the plugin rewrite.
- **Fix (slides 4-15).** The 5-step pipeline. Plan -> Build -> Compose -> Validate -> Export. Each step has a skill (or sub-skills). The validator is the new defence introduced this week.
- **Defences (slides 16-18).** The `figure-qa` agent and the three-defences slide. Deterministic checks own ground-truth; the VLM owns aesthetic judgment.
- **Walkthrough (slides 19-20).** The HBN practicum's algorithm figure as the live demo, then the close.

## Where This Sits in the Course

| Week | Topic | Connection to today |
|------|-------|--------------------|
| 5 | Literature review | Cite-the-card carries to cite-the-figure. Boomerang shape is identical. |
| 6 | Grant proposals | `grant-figure-qa` was the first version of the QA agent. `figure-qa` is the unified successor. |
| 7 | Manuscripts | Stage 3 of the manuscript pipeline was figures-as-workflow. Today is figures-as-craft. |
| 8 | **Scientific figures (today)** | The 5-step pipeline. |
| 9 | Neuroinformatics | The Methods section will cite BIDS and HED standards; today's figures support those Methods. |
| 10 | Plugin building | The `figures` plugin's expansion this week is a small case study in plugin evolution. |

## What Today Gives Each Audience Segment

- **PhD students.** A workflow that produces figures the lab's advisor will accept on first review, because the panel-by-panel reproduction story is intact and the journal-compliance checks are deterministic.
- **Postdocs.** A figure source layout that ships next to the manuscript so when the journal asks for a reproducible figure pipeline, the answer is "git clone, then make figure.pdf."
- **PIs.** A QA agent that runs on every commit (when wired into CI) and catches journal-compliance failures before they ship.
- **Open-science researchers.** A pipeline that is fully scriptable, fully open-source, and runs from any of the three coding-agent runtimes carried in from Week 6 (Claude Code, Codex CLI, Copilot in VS Code).

## Live Walkthrough -- The HBN Practicum Algorithm Figure

A 5-minute live action sequence at the end of the session. Topic: the algorithm figure for the practicum's animacy-of-opening-shot event-related spectral perturbation (ERSP) analysis. This is the methods overview figure that the practicum's eventual manuscript will use as Figure 1.

Pre-built state:

- The Week-3 practicum repository, with a `figures/algorithm/` directory stubbed.
- A `theme.json` carried in from earlier sessions with the practicum's palette (Okabe-Ito + a custom EEG channel-strip blue).
- A stub `panels-config.json` with two empty panels (`algorithm-flow`, `example-ersp`).
- A small `example-ersp-data.csv` for the second panel.

Three live actions:

1. **`/figures:svg-figure` drafts the algorithm-flow panel.** A 5-stage horizontal flow: BIDS load -> adaptive mixture independent component analysis (AMICA) -> independent component classification (IClabel) -> shot-aligned epoching -> ERSP -> cluster-level statistics. The skill enforces text-anchored-to-box-bounds and arrows-touching-target-edges. (~1:30 on stage.)
2. **`/figures:plot-styling` builds an example-ERSP panel.** From `example-ersp-data.csv`, draws a single-channel ERSP heat map in the Nature column style (3.5 in wide, 7 pt axis labels). The skill applies `plt.style.use(['science', 'nature'])` and `savefig(..., transparent=True, bbox_inches='tight')`. (~1:30 on stage.)
3. **`/figures:scientific-figure` composes and `figure-qa` validates.** Composes the two SVG panels into a 1-column Nature figure at 89 mm width with `A` and `B` labels; runs `validate_fonts.py`; runs the `figure-qa` agent's SVG branch including the VLM aesthetic pass. We do not manufacture a font failure; if the validator flags one, walk the remedy (rescale the panel up). (~2:00 on stage.)

The session ends with the validated SVG on screen and the QA agent's report alongside it.

## Common Pitfalls (Watched For in Live Demo)

- **Skipping the journal-pick step.** Without a target journal, the validator has no minimum to enforce. Pick before authoring.
- **Saving plots as PNG instead of SVG.** PNGs break font validation because text is rasterised. Save as SVG with `transparent=True, bbox_inches='tight'`.
- **Composing in flexbox / react-pdf.** The mode this week's pipeline replaces. Composition at exact mm coordinates is the discipline that prevents drift.
- **Letting the AI write text into the figure.** AI image models cannot reliably render axis numerals, equations, multi-arrow flowcharts, or > 5 labeled elements. Substrate-only generation + programmatic overlay is the pattern.
- **Treating `figure-qa` as optional.** The deterministic checks catch real failures (palette violations, font-pt under minimum, pixel positions wrong). The VLM pass catches aesthetic issues humans would notice. Skipping either lets the failure mode through.

## What This Session Does Not Cover

- Adobe Illustrator / Inkscape interactive editing. The pipeline is scriptable end-to-end; manual touch-up belongs to a different workflow.
- Figure-level statistical reporting (when to draw error bars vs. confidence intervals, how to annotate p-values). That belongs in a stats workshop; the figures plugin is the medium, not the statistics.
- Journal-specific style sheets beyond Nature / Science / Cell / PNAS. The four supported journals cover ~80% of the audience; adding a new style sheet is a small skill PR. The path is documented in the skill's references.
- 3D / volumetric figures beyond what matplotlib 3d and PyVista handle natively. Specialised 3D rendering tools live outside this plugin.
- Posters and presentations. The plugin produces journal figures; posters and slide decks use a different composition discipline (this presentation is built with the `agentic-presentation-builder`).

## Related Sessions

- **Week 5** -- the lit-review pipeline whose corpus today's worked examples cite.
- **Week 6** -- the `grant-figure-qa` agent that motivated the unified `figure-qa` agent introduced this week.
- **Week 7** -- the manuscript pipeline whose Stage 3 was figures-as-workflow.
- **Week 9** -- BIDS / HED / Methods that today's figures will support.
- **Week 10** -- how the `figures` plugin's expansion this week is a small case study in plugin evolution; trainees who want their own `/figures:my-journal-template` skill will start there.

## Three Defences (Carried From the Plan)

The pipeline's mechanical defences are deliberately stack-redundant:

- **Palette + theme consistency (Step 2 -- Build).** A `theme.json` keeps every icon, plot, and substrate in the same colour and stroke language.
- **Font validation (Step 4 -- Validate).** `validate_fonts.py` walks the transform stack and reports any text below the journal minimum. **New this week.**
- **VLM aesthetic pass (Step QA).** The `figure-qa` agent runs deterministic checks for anything with ground truth, then asks a vision-language model for aesthetic judgment.

None alone is sufficient. The font validator catches what humans miss; the VLM catches what deterministic checks cannot articulate; the theme bible catches drift across panels.
