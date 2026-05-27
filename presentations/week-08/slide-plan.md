# Week 8 Slide Plan

## Target: 20 slides, ~30 min presentation, then ~5 min live walkthrough + 15 min Q&A

**Core message.** A publication figure is not a single prompt; it is a 5-step pipeline (Plan, Build, Compose, Validate, Export) that lives in the same repository as the manuscript and survives journal-submission scrutiny because every step has a mechanical defence. The single most useful idea in this session: **`validate_fonts.py` is to figures what `cite-the-card` is to prose** -- a deterministic check that converts a vague "the figure looks small" complaint into a precise "Frequency (Hz) is 4.5 pt, Nature requires >= 5 pt" finding. The `figures` plugin expanded between weeks 7 and 8 from a 3-skill set into a 5-skill plugin plus a `figure-qa` agent; the new shape is a deliberate response to the react-pdf workflow's structural failures.

The pipeline shape is the same as Weeks 5-7: a multi-stage flow with a boomerang on QA findings. What is new this week: the **physical-size discipline** (panels placed at exact mm coordinates), the **font validator** (effective-pt vs journal minimum across the transform stack), and the **VLM-judgment QA pass** (the `figure-qa` agent's aesthetic-correctness check, kept separate from the deterministic checks).

The tone matches Weeks 5-7: thesis up front, every theoretical point lands on the worked example (the Healthy Brain Network (HBN) practicum's algorithm figure -- a multi-panel schematic showing the BIDS-load to event-related spectral perturbation (ERSP) to cluster-stats pipeline, then a Nature-style composition).

## Slide Inventory

### Opening (2 min)

1. **Title** -- "Week 8: Scientific Figures." Author, course / Discord / recording links.
2. **Where we are** -- Weeks 1-7 recap with one bullet each. Today: the figures stage that Week 7 used but did not teach.

### Failure modes and reframe (2 min)

3. **Why the old workflow broke** -- The react-pdf approach had two structural failures: composition did not respect physical size (flexbox shifted dimensions during render), and fonts shrank below readable thresholds (axis labels under 4 pt). Asset: `figures-failure-modes.svg` (a Nature panel target on the left, a react-pdf rendering on the right with red-highlighted shrunk text).
4. **Reframe -- figures are a 5-step pipeline** -- Plan, Build, Compose, Validate, Export. Same shape as the lit-review / grant / manuscript pipelines. Asset: `figures-reframe.svg` (an old "one-shot generator" arrow on the left morphing into a 5-step pipeline on the right).

### Hero (1 min)

5. **The 5-step scientific-figure pipeline (hero)** -- Plan -> Build -> Compose -> Validate -> Export, with a boomerang from Validate back to Build when a font fails. Asset: `figures-pipeline.svg`.

### Step 1: Plan (2 min)

6. **Pick the journal first** -- Cheatsheet of Nature / Science / Cell / PNAS column widths and minimum body-font sizes. The validator in step 4 enforces these; pick the journal early so the validator can warn early. Asset: `journal-cheatsheet.svg` (a 4-row table-as-graphic with column widths and min-pt).
7. **Colorblind-safe palettes** -- Wong, Okabe-Ito, Paul Tol bright, viridis, Crameri. Reuse one palette across all panels. Asset: `palettes.svg` (5 swatch rows with hex codes).

### Step 2: Build elements -- the four supporting skills (6 min)

8. **The figures plugin -- 5 skills + 1 agent** -- Overview card: `scientific-figure` (composer) + `plot-styling`, `svg-figure`, `transparent-icons`, `ai-full-figure` (element builders) + `figure-qa` (agent). Asset: `figures-plugin-map.svg` (composer in the centre, four element-builder cards around it, QA agent on top).
9. **/figures:plot-styling -- SciencePlots and SVG-with-text** -- Library decision tree (matplotlib for control, seaborn for stats, plotnine for ggplot, plotly for HTML supplement). SciencePlots styles: `science`, `nature`, `ieee`, `bright`. Export discipline: SVG, transparent, tight bbox, embedded text. Asset: `plot-styling-skill.svg` (code on the left: `plt.style.use(['science','nature']) ... savefig('panel.svg', transparent=True, bbox_inches='tight')`; rendered panel mock on the right with axis labels measured at 7 pt).
10. **/figures:svg-figure -- schematics with constraints** -- Hand-authored SVG or programmatic via svgutils. Constraints: text anchored to box bounds (`text-anchor=middle, dominant-baseline=middle`); arrows ending at target edge (`refX=9, marker-end`); lines pass under shapes via document-order z-order. Asset: `svg-figure-skill.svg` (code on the left: a `<rect>` + a `<text>` centered + an arrow with marker-end; rendered schematic on the right with labelled arrow tip touching target).
11. **/figures:transparent-icons -- Codex first, API fallback** -- Codex CLI `image_gen` (no API key required when `codex login` is configured) or OpenAI Images API. Transparency post-process: `threshold` (Pillow, default, fast) or `birefnet` (rembg + BiRefNet, opt-in for clean edges). Theme bible (`theme.json`) keeps an icon set consistent. Asset: `transparent-icons-skill.svg` (code on the left: `generate_icon.py --template brain-eeg --transparent`; three rendered icons on the right -- brain, neuron, EEG cap -- in matching palette).
12. **/figures:ai-full-figure -- substrate only, overlay programmatic** -- For pictorial scenes (brain rendering, microscope setup, anatomical scene). Hard ceiling: AI cannot reliably render data plots with axis numerals, equations, multi-arrow flowcharts, or > 5 labeled elements. The pattern: substrate without text from the model + labels / arrows / scale bars as a programmatic SVG overlay. Asset: `ai-full-figure-skill.svg` (left: raw substrate -- watercolour brain on white; right: same substrate with three programmatic labels and arrows overlaid).

### Step 3: Compose (2 min)

13. **/figures:scientific-figure -- svgutils at exact mm coords** -- `panels-config.json` schema with `width_mm, height_mm, journal, panels[]` where each panel has `x_mm, y_mm, scale, label`. Two recipes: the helper (`compose.py panels-config.json -o figure.svg`) and direct `svgutils.compose.Figure`. Asset: `compose-skill.svg` (left: `panels-config.json`; right: a composed two-panel figure at 183 mm with `A` and `B` labels).

### Step 4: Validate (2 min)

14. **validate_fonts.py -- the new mechanical defence** -- Walks the transform stack to compute the effective pt for every `<text>` and `<tspan>`, reports anything below the journal minimum. The validator catches the failure-mode-slide problem before export. Remedies: rescale that panel up, increase the source plot's font size, or upgrade to a wider canvas. Asset: `font-validator.svg` (left: JSON output showing one issue at 4.5 pt under Nature's 5 pt; right: the same figure post-fix with the issue annotated and resolved).

### Step 5: Export (1 min)

15. **Inkscape vs cairosvg** -- Inkscape: highest fidelity, text remains text, fonts subsetted; one-time `brew install inkscape`. cairosvg fallback: works without Inkscape but lower-fidelity PDF when journal-required fonts are not installed. The script auto-detects Inkscape on `$PATH`. Asset: `export-backends.svg` (left: SVG -> Inkscape -> PDF with text-still-text annotation; right: SVG -> cairosvg -> PDF with paths annotation).

### Step QA -- the figure-qa agent (3 min)

16. **/figures:figure-qa -- dispatch by input type** -- The agent reads the input type (SVG, raster PNG/JPG/TIFF, plot script, composed-figure directory) and dispatches to the right deterministic check script (`check_svg.py`, `check_raster.py`, `check_plot_script.py`). Honors a `no-qa` opt-out. Asset: `figure-qa-dispatch.svg` (left: four input-type cards; centre: agent diamond; right: three check-script cards + a VLM-judgment card).
17. **Deterministic checks vs VLM judgment** -- Strict separation: programmatic checks own anything with ground truth (hex codes, pt sizes, pixel positions, alpha values, bbox overlap); VLM owns judgment ("does the hierarchy read clearly", "is this layered correctly"). Asset: `qa-split.svg` (a vertical divider: left column lists deterministic-check examples; right column lists VLM-judgment examples).

### Three defences and close (3 min plus 5 live)

18. **Three defences -- one per pipeline phase** -- Palette + theme consistency (Build); font validation (Compose -> Validate); VLM aesthetic pass (QA). Deliberately stack-redundant. The font validator is new this week. Asset: `three-defences-figures.svg` (three shields: palette/theme + font-validation + VLM-aesthetics, the middle one marked NEW).
19. **Live demo roadmap** -- Topic: the HBN practicum algorithm figure. Three live actions: (1) `/figures:svg-figure` drafts the algorithm-flow panel (BIDS -> AMICA -> IClabel -> shot-aligned epoching -> ERSP -> cluster stats); (2) `/figures:plot-styling` builds an example ERSP panel from a stub data file; (3) `/figures:scientific-figure` composes them into a 1-column Nature-style figure and `figure-qa` runs the validator. We do not manufacture a font failure; if the validator flags one, walk the remedy. Asset: `demo-roadmap-figures.svg` (three steps with timing badges).
20. **What today gives you / what's next** -- Today: a 5-step figures pipeline, a font validator that prevents the journal-reject scenario, and a QA agent that adds aesthetic judgment without losing rigor on the parts with ground truth. Next: Week 9 neuroinformatics -- BIDS, HED, and what the Methods section cites.

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 2 min |
| Failure modes + reframe | 2 | 2 min |
| Hero pipeline | 1 | 1 min |
| Step 1 (Plan) | 2 | 2 min |
| Step 2 (Build) -- 5 skill slides | 5 | 6 min |
| Step 3 (Compose) | 1 | 2 min |
| Step 4 (Validate) | 1 | 2 min |
| Step 5 (Export) | 1 | 1 min |
| QA agent | 2 | 3 min |
| Three defences + close | 3 | 3 min |
| **Total** | **20** | **~24 min content + 6 min buffer** |

Live walkthrough (~5 min) + Q&A (~15 min) fill the remaining time. Buffer accommodates the slower pace on the element-builder skill slides.

## Animation Discipline

Same as Weeks 5-7. Every multi-bullet slide and every multi-line code block uses **fragment animations** so a single concept is on screen at a time:

- Bullets stagger in (one per click)
- Code blocks reveal line by line
- Diagrams use **build-on-click**: stage labels before arrows; the boomerang appears last on the hero
- Side callouts appear after main content

Reference: `presentations/week-05/presentation.json`, `presentations/week-06/presentation.json`, `presentations/week-07/presentation.json`.

## Continuity With Prior Weeks

- **Week 5 (lit review).** Cite-the-card discipline extends to cite-the-figure (every claim a paper-card, every panel a source file). The boomerang shape is the same.
- **Week 6 (grant proposals).** `grant-figure-qa` was the first version of the QA agent; this week's `figure-qa` is the unified successor that also handles SVG and plot scripts.
- **Week 7 (manuscripts).** This week's Stage 3 was figures-as-workflow; today is figures-as-craft. The directory layout (figures next to the manuscript) is unchanged.
- **Week 9 (neuroinformatics).** The Methods section will cite BIDS and HED standards; today's figures support those Methods.

## Three Defences

The pipeline's mechanical defences against thumb-on-scale are deliberately stack-redundant:

- **Palette + theme consistency (Step 2 -- Build).** A `theme.json` keeps every icon, plot, and substrate in the same colour and stroke language. Guards against the "every panel is its own little world" failure mode.
- **Font validation (Step 4 -- Validate).** `validate_fonts.py` walks the transform stack and reports any text below the journal minimum. **New this week.** Guards against the react-pdf failure mode that motivated the rewrite.
- **VLM aesthetic pass (Step QA).** The `figure-qa` agent runs deterministic checks for anything with ground truth, then asks a vision-language model for aesthetic judgment on hierarchy and layering. Guards against the "passes every check but looks ugly" failure mode.

A figure that "passes" without the validator running, or without the QA agent's aesthetic pass, is hiding what it found.

## Assets Produced (via `/figures:scientific-figure` and `/figures:svg-figure`, hand-crafted SVG)

All ship in [`assets/icons/`](../../assets/icons/) unless noted. Hand-crafted SVG, no mermaid.

- `figures-failure-modes.svg` -- slide 3. Two panels side-by-side: left is a Nature target with crisp 7 pt labels; right is the react-pdf render with `Frequency (Hz)` highlighted in red at 4.5 pt. A central diagonal slash crosses the right panel.
- `figures-reframe.svg` -- slide 4. Left side: an old "one-shot generator" with a single arrow and a "garbage output" warning. Right side: a 5-step pipeline with explicit Plan / Build / Compose / Validate / Export labels.
- `figures-pipeline.svg` -- slide 5 (hero). Five horizontal stages with a boomerang from Validate back to Build. Same visual language as the lit-review and manuscript pipelines.
- `journal-cheatsheet.svg` -- slide 6. A 4-row table with Journal / 1-col width / 2-col width / min body font, plus a top-row "Pick the journal first" header.
- `palettes.svg` -- slide 7. Five named palette rows (Wong, Okabe-Ito, Tol bright, viridis, Crameri batlow) with 6-8 swatches per row and hex codes labelled.
- `figures-plugin-map.svg` -- slide 8. `scientific-figure` composer card in the centre; four element-builder skill cards around it (`plot-styling`, `svg-figure`, `transparent-icons`, `ai-full-figure`); `figure-qa` agent card above with arrows down to the composer. Reuses the visual language of `plugin-ecosystem.svg`.
- `plot-styling-skill.svg` -- slide 9. Two-column: left a code snippet with `plt.style.use(["science", "nature"])` and `savefig("panel.svg", transparent=True, bbox_inches="tight")` highlighted; right a small rendered line plot in the Nature style with 7 pt axis labels annotated.
- `svg-figure-skill.svg` -- slide 10. Two-column: left a code snippet of a `<rect>` + centered `<text>` + a `<line>` with `marker-end`; right the rendered schematic with the arrow visibly touching the target edge.
- `transparent-icons-skill.svg` -- slide 11. Two-column: left `generate_icon.py --template brain-eeg --transparent`; right three rendered icons (brain, neuron, EEG cap) in a matching palette with checkerboard transparency indicators.
- `ai-full-figure-skill.svg` -- slide 12. Two-column: left a raw substrate (watercolour brain on white background, no text); right the same substrate with three programmatic labels and arrows overlaid; a "hard ceiling" callout strip across the bottom.
- `compose-skill.svg` -- slide 13. Two-column: left a `panels-config.json` with two panels at `x_mm=0, x_mm=92`; right the composed two-panel Nature 2-column figure with `A` and `B` labels.
- `font-validator.svg` -- slide 14. Two-column: left a JSON output with `effective_pt: 4.5` highlighted; right the rescaled figure with the previously-flagged label measured at 5.5 pt and a green check.
- `export-backends.svg` -- slide 15. Two-column: left `Inkscape: text remains text, fonts subsetted`; right `cairosvg: paths, lower fidelity`. A small badge on Inkscape indicating "preferred".
- `figure-qa-dispatch.svg` -- slide 16. Four input-type cards on the left (SVG, raster, plot script, composed-figure dir) feeding a central agent diamond; on the right three check-script cards (`check_svg.py`, `check_raster.py`, `check_plot_script.py`) and one VLM-judgment card.
- `qa-split.svg` -- slide 17. Vertical divider down the middle. Left column lists deterministic-check examples ("hex codes", "pt sizes", "pixel positions", "alpha", "bbox overlap"). Right column lists VLM-judgment examples ("hierarchy reads clearly", "layered correctly", "panel labels positioned consistently").
- `three-defences-figures.svg` -- slide 18. Three labelled shields. Shield 1 (palette + theme consistency) covers Build, carried from prior weeks. Shield 2 (font validation) covers Validate, marked NEW with a badge. Shield 3 (VLM aesthetic pass) covers QA, carried from the Week-6 figure-qa concept.
- `demo-roadmap-figures.svg` -- slide 19. Three live-action steps with timing badges: `/figures:svg-figure` (1:30), `/figures:plot-styling` (1:30), `/figures:scientific-figure` + `figure-qa` (2:00). An off-stage tail shows the boomerang on font-validator failure if one surfaces.

## Production Notes

- Each two-column "code + mock" skill slide uses a single composed SVG with both halves baked in, not the `two-column` layout type. This keeps the visual rhythm tight and avoids whitespace drift between layouts.
- Code snippets in skill-slide SVGs are rendered as `<text>` not as raster screenshots, so they remain crisp at any zoom level and can be re-themed centrally if the deck moves to a dark theme.
- The `figures-failure-modes.svg` slide gets the most explicit "before / after" visual treatment because it carries the entire motivation for the plugin rewrite. Land the failure mode hard; the rest of the deck is the fix.
- The validator slide (14) is the slide trainees will quote when they explain the workflow to lab-mates. The JSON-output side should be readable at the back of a 30-foot room.
