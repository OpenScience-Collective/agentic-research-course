# Week 8 Guide: Scientific Figures

*A publication figure is not a single prompt; it is a managed 5-step pipeline (Plan, Build, Compose, Validate, Export) that lives in the same repository as the manuscript and survives journal-submission scrutiny because every step has a mechanical defence. The single most useful idea this week: **`validate_fonts.py` is to figures what `cite-the-card` is to prose** -- a deterministic check that converts a vague "the figure looks small" complaint into a precise "Frequency (Hz) is 4.5 pt, Nature requires >= 5 pt" finding. The `figures` plugin expanded from 3 skills into 5 skills plus a `figure-qa` agent between Weeks 7 and 8; the new shape is a deliberate response to the react-pdf workflow's structural failures.*

This guide accompanies [Week 8](../sessions/week-08/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). The session builds directly on Week 7 (manuscripts), where Stage 3 of the IMRAD pipeline was figures-as-workflow; this week is figures-as-craft. A new defence is introduced this week: a font validator that walks the SVG transform stack and reports every label whose effective point size lands below the target journal's minimum.

---

## Why the Old Workflow Broke

The previous workflow leaned on react-pdf for multi-panel composition. It had two structural failures.

First, **composition did not respect physical size**. Flexbox layout shifted dimensions in subtle ways during render. Over a 2-column figure, panels could drift by fractions of a millimetre and panel labels (A, B, C) would land in subtly different positions. The journal-submitted PDF and the laptop preview no longer matched.

Second, **fonts shrank below readable thresholds**. When a panel's content overflowed its allotted box, the engine scaled the entire figure uniformly. Axis labels that started at 7 pt landed at 4-4.5 pt, below Nature's 5 pt minimum and below Science / Cell / PNAS's 6 pt minimum. The figure was rejected at submission.

The 5-step pipeline introduced this week is the deliberate response. Every step has a mechanical defence; the new one in Step 4 is the font validator.

---

## The 5-Step scientific-figure Pipeline

```text
[ 1. Plan ] -> [ 2. Build ] -> [ 3. Compose ] -> [ 4. Validate ] -> [ 5. Export ]
                    ^                                   |
                    +-----------------------------------+
                         boomerang on font failure
```

Five steps, enforced order. Composing before planning produces dimension drift; exporting before validating produces journal rejections.

| Step | Tool | Output |
|------|------|--------|
| 1. Plan | `/figures:scientific-figure` (pick journal + palette) | Target dimensions in mm; colour-blind safe palette from `references/color-palettes.md` |
| 2. Build | `/figures:plot-styling`, `/figures:svg-figure`, `/figures:transparent-icons`, `/figures:ai-full-figure` | Per-panel SVG files (data plots, schematics, icons, AI substrates) with text preserved as `<text>` |
| 3. Compose | `/figures:scientific-figure` (svgutils helper) | Multi-panel SVG at exact mm coordinates; panel labels added |
| 4. Validate | `validate_fonts.py` (called by the composer; also the QA agent) | JSON report of every `<text>` effective pt vs the journal minimum |
| 5. Export | `export.py` (Inkscape if present; cairosvg otherwise) | Journal-ready PDF with fonts subsetted and text preserved |

---

## Step 1: Plan (Pick the Journal First)

Width sets the canvas. Min body font is the validator's threshold. Pick early so the validator can warn early.

| Journal | 1 column | 2 column | Min body font | Notes |
|---------|----------|----------|---------------|-------|
| Nature | 89 mm | 183 mm | 5 pt | 8 pt for panel labels |
| Science | 55 mm | 120 mm | 6 pt | Myriad / Helvetica preferred |
| Cell | 85 or 112 mm | 174 mm | 6 pt | Max 225 mm tall |
| PNAS | 87 mm | 180 mm | 6 pt | No label below 2 mm tall |

The full table for ~20 journals (eLife, IEEE, NeuroImage, Cerebral Cortex, Journal of Neuroscience, PLOS, Cell Reports, Journal of Open Source Software (JOSS), and more) lives in `references/journal-specs.md`.

Reuse one **colour-blind-safe palette** across all panels. The plugin ships five categorical and sequential options:

- **Wong** (8 swatches, categorical)
- **Okabe-Ito** (8 swatches, categorical, lab-calibrated)
- **Tol bright** (7 swatches, categorical, SciencePlots "bright" style)
- **viridis** (sequential, perceptually uniform)
- **Crameri batlow** (sequential, designed for scientific geoscience data)

A `theme.json` keeps every icon, plot, and substrate in the same colour and stroke language. This is the first of three mechanical defences, carried in from prior weeks.

---

## Step 2: Build Elements -- the Four Supporting Skills

The plugin shape has changed since Week 7. The composer (`/figures:scientific-figure`) is the sink; four element-builder skills feed it.

### /figures:plot-styling -- SciencePlots and SVG-with-text

For data plots: matplotlib for control, seaborn for stats, plotnine for ggplot-in-Python, plotly for HTML supplements. SciencePlots styles fix 80% of the "ugly defaults" complaints:

```python
import matplotlib.pyplot as plt
import scienceplots  # registers SciencePlots styles

plt.style.use(["science", "nature", "no-latex"])

fig, ax = plt.subplots(figsize=(3.5, 2.5))  # 89 mm x ~63 mm
ax.plot(t, y, label="signal")
ax.set_xlabel("time (s)")
ax.set_ylabel("amplitude")
fig.savefig("panel_a.svg", transparent=True, bbox_inches="tight")
```

The export discipline matters: **save as SVG, transparent, tight bbox, embedded text**. The validator inspects every `<text>` element; rasterised PNG breaks the check. `no-latex` is non-optional unless you have system LaTeX installed AND want path-rendered text (which also breaks the validator).

### /figures:svg-figure -- Schematics with Element-Consistency Guarantees

For schematics (boxes, arrows, labels). Hand-authored SVG or programmatic via svgutils. Three constraints the skill enforces and `figure-qa` later checks:

1. **Text inside box bounds.** `text-anchor="middle"`, `dominant-baseline="middle"`, centred at the box's centroid.
2. **Arrows ending at target edge.** `marker-end="url(#arrow)"` with `refX` near the marker tip; the visual tip lands exactly at the target shape's edge.
3. **Lines pass under shapes by document order.** Draw the connection first, then the shape that should sit on top -- no `z-index` outside CSS-rendered SVG.

The viewBox convention: `width="89mm" height="60mm" viewBox="0 0 89 60"`. User units equal mm. A `<text font-size="9">` is 9 pt; a `<rect width="20">` is 20 mm wide.

### /figures:transparent-icons -- Codex CLI First, OpenAI API Fallback

For flat scientific icons (brain, neuron, EEG cap, DNA, microscope). Two backends, auto-selected:

- **Codex CLI `image_gen` tool** (preferred). Uses local `codex login`; no `OPENAI_API_KEY` needed. Routes through gpt-image-2 internally.
- **OpenAI Images API** (fallback). Requires `OPENAI_API_KEY` via environment or `.env`.

The first researcher with a ChatGPT subscription but no API key benefits immediately; auto-selection prefers Codex when both are available.

Transparency is a post-process because gpt-image-2 (April 2026) does not accept `background="transparent"`. Two methods: `threshold` (Pillow, fast, default) or `birefnet` (rembg + BiRefNet alpha-matting, opt-in, cleaner edges, ~400 MB one-time model download).

```bash
uv run --with openai --with pillow python scripts/generate_icon.py \
    --template brain-eeg -o brain_eeg.png --transparent
```

A `theme.json` keeps an icon set consistent across the figure (same primary colour, same stroke weight, same line-join style).

### /figures:ai-full-figure -- Substrate-Only Generation + Programmatic Overlay

For pictorial substrates (brain renderings, microscope setups, anatomical scenes, lab apparatus). The hard ceiling: AI cannot reliably render axis numerals, equations, multi-arrow flowcharts, or more than 5 labelled elements. Labels longer than 1-2 words drift in position.

The pattern: **prompt the model for the picture with no text, no labels, no arrows; overlay the labels, arrows, and scale bars as a separate SVG layer; ship the combined SVG**.

```bash
uv run --with openai --with pillow python scripts/generate_figure.py \
    "a stylized lateral view of a human brain in soft watercolour on a clean white background" \
    -o brain_substrate.png --size 1536x1024 --backend codex
```

Then the labels, arrows, and scale bar are added programmatically via `svgwrite` or hand-authored SVG, embedded in the same composed figure.

---

## Step 3: /figures:scientific-figure -- svgutils Composer at Exact mm Coordinates

The composer is built around [svgutils](https://svgutils.readthedocs.io/) (MIT). It places panels at exact mm coordinates and preserves every `<text>` element so the validator can inspect them.

```json
{
  "width_mm": 183,
  "height_mm": 120,
  "journal": "nature",
  "panels": [
    {"id": "A", "src": "panels/spectrum.svg", "x_mm": 0,  "y_mm": 0, "scale": 0.5, "label": "A"},
    {"id": "B", "src": "panels/topomap.svg",  "x_mm": 92, "y_mm": 0, "scale": 0.5, "label": "B"}
  ]
}
```

```bash
uv run --with svgutils python compose.py panels-config.json -o figure.svg
```

Panel labels (A, B, C) at top-left of each panel in 12 pt bold sans-serif. Two recipes available: the helper (for the 80% case) and direct `svgutils.compose.Figure` for full control.

---

## Step 4: validate_fonts.py -- the New Mechanical Defence

This is the slide trainees will quote. The validator parses every `<text>` and `<tspan>` element with a `font-size`, walks the accumulated transform stack to compute the **effective pt** at the final physical dimensions, and reports anything below the journal minimum.

```bash
uv run --with lxml python validate_fonts.py figure.svg --journal nature
```

```json
{
  "svg": "figure.svg",
  "journal": "nature",
  "minimum_pt": 5.0,
  "checked_count": 47,
  "issue_count": 1,
  "issues": [{
    "text": "Frequency (Hz)",
    "specified_pt": 9.0,
    "effective_pt": 4.5,
    "scale_x": 0.5,
    "minimum_pt": 5.0
  }]
}
```

A 9 pt source label scaled to 0.5 lands at 4.5 pt effective -- under Nature's 5 pt minimum. Caught before export.

Three remedies, in priority order:

1. **Rescale the offending panel up** (and the others down) instead of accepting small text.
2. **Increase the source plot's font size** so even at panel scale 0.5 it still passes.
3. **Upgrade to a wider canvas** (1-column to 1.5-column, or to 2-column).

Exit codes: `0` clean, `1` issues found, `2` script error.

---

## Step 5: Export (Inkscape Preferred, cairosvg Fallback)

```bash
uv run --with cairosvg python export.py figure.svg --out figure.pdf --dpi 300
```

`export.py` auto-detects Inkscape on `$PATH` at runtime. When present, Inkscape produces the highest-fidelity PDF: text remains text (selectable, searchable in the PDF), fonts subsetted and fully embedded. When absent, the script falls back to cairosvg with a stderr warning; text without an installed font may be converted to paths.

```bash
brew install inkscape    # macOS, ~200 MB one-time
sudo apt install inkscape # Debian / Ubuntu
```

The cairosvg fallback works without Inkscape, but if the journal requires a specific font (Arial / Helvetica for Nature; Myriad / Helvetica for Science) and you do not have it installed, the rendered text becomes paths and the validator's downstream guarantees no longer hold for the exported PDF.

---

## /figures:figure-qa -- Dispatch by Input Type, Deterministic + VLM

The QA agent dispatches on input type and runs the right deterministic-check script, then adds a vision-language model (VLM) aesthetic pass on top.

| Input type | Deterministic check | What it owns |
|------------|---------------------|--------------|
| SVG | `check_svg.py` | bbox overlap, arrow-tip-to-target distance, pt sizes, palette membership |
| Raster (PNG / JPG / TIFF) | `check_raster.py` | DPI, font embedding, alpha values, image dimensions |
| Plot script (Python source) | `check_plot_script.py` | `savefig` kwargs, rcParams font sizes, SciencePlots usage |
| Composed figure directory | All three, plus VLM | Cross-panel consistency |

The strict separation is the design discipline. **Programmatic checks own anything with ground truth**: a hex code is exactly equal to `"#0072B2"`; a pt size is greater than or equal to 5.0; a bbox overlap is exactly 0; an alpha value is exactly 1.0. **The VLM owns judgment**: does the hierarchy read top-down? Does the background sit behind the data? Are the panel labels positioned consistently? Does the narrative arc flow in argumentative order?

Never blur the line. The moment a VLM tries to judge an exact hex code, the QA loses its falsifiability.

The agent honours a `no-qa` opt-out for fast iteration; re-enable it before commit.

---

## Three Defences -- One per Phase

The pipeline's mechanical defences are deliberately stack-redundant. None alone is sufficient.

- **Palette and theme consistency (Build phase).** A `theme.json` keeps icons, plots, and substrates in the same colour language. Carried from prior weeks (cite-the-card extended to cite-the-figure).
- **Font validation (Validate phase).** `validate_fonts.py` walks the transform stack and reports any text below the journal minimum. **New this week.** The defence that fixed the react-pdf failure mode.
- **VLM aesthetic pass (QA phase).** `figure-qa` runs deterministic checks for everything with ground truth, then asks a vision-language model for aesthetic judgment. Evolved from Week 6's `grant-figure-qa`, now unified across all four input types.

A figure that "passes" without the validator running, or without the QA agent's aesthetic pass, is hiding what it found.

---

## Live Walkthrough -- The HBN Algorithm Figure

The Week 8 session ends with a live walkthrough composing the algorithm figure for the practicum's animacy-of-opening-shot event-related spectral perturbation (ERSP) analysis -- the methods overview figure the practicum's eventual manuscript will use as Figure 1.

Pre-built state:

- The Week-3 practicum repository with a `figures/algorithm/` directory stubbed.
- A `theme.json` carrying the practicum's palette (Okabe-Ito + a custom EEG channel-strip blue).
- A stub `panels-config.json` with two empty panels (`algorithm-flow`, `example-ersp`).
- A small `example-ersp-data.csv` for the second panel.

Three live actions, ~5 minutes total:

1. **`/figures:svg-figure` drafts the algorithm-flow panel** (1:30). A 5-stage horizontal flow: Brain Imaging Data Structure (BIDS) load to adaptive mixture independent component analysis (AMICA) to independent component classification (IClabel) to shot-aligned epoching to ERSP to cluster-level statistics. The skill enforces text-anchored-to-box-bounds and arrows-touching-target-edges.
2. **`/figures:plot-styling` builds an example-ERSP panel** (1:30). From `example-ersp-data.csv`, draws a single-channel ERSP heat map in the Nature column style (3.5 inches wide, 7 pt axis labels). `plt.style.use(['science', 'nature'])` and `savefig(..., transparent=True, bbox_inches='tight')`.
3. **`/figures:scientific-figure` composes and `figure-qa` validates** (2:00). Composes the two SVG panels into a 1-column Nature figure at 89 mm width with `A` and `B` labels; runs `validate_fonts.py`; runs the `figure-qa` agent's SVG branch including the VLM aesthetic pass.

We do not manufacture a finding. If the validator flags a font (likely natural surface: the topomap colorbar label might land at 4.8 pt under Nature's 5 pt), we walk the remedy on stage -- rescale the topomap panel from 0.5 to 0.6.

---

## Common Pitfalls (Watched For in the Live Demo)

- **Skipping the journal-pick step.** Without a target journal, the validator has no minimum to enforce. Pick before authoring.
- **Saving plots as PNG instead of SVG.** Rasterised text breaks font validation. Always SVG with `transparent=True, bbox_inches='tight'`.
- **Composing in flexbox or react-pdf.** The mode this week's pipeline replaces. Composition at exact mm coordinates is the discipline that prevents drift.
- **Letting AI write text into the figure.** AI image models cannot reliably render axis numerals, equations, multi-arrow flowcharts, or more than 5 labelled elements. Substrate-only generation plus programmatic overlay is the pattern.
- **Treating `figure-qa` as optional.** The deterministic checks catch real failures (palette violations, font-pt under minimum, pixel positions wrong). The VLM pass catches aesthetic issues humans would notice. Skipping either lets the failure mode through.

---

## Before Next Week

- Install [`research-skills`](https://github.com/neuromechanist/research-skills) if not already installed; it bundles `figures`, `manuscript`, `opencite`, `grant`, `neuroinformatics`, `project`, and `presentation`.
- Run `codex login` if you have a ChatGPT subscription; the icon and substrate generators will auto-select Codex and skip the API key requirement. Otherwise set `OPENAI_API_KEY` for the API fallback.
- Pick a target journal from `references/journal-specs.md` and a palette from `references/color-palettes.md`. Write both into a `theme.json` at the root of your manuscript.
- Optional: `brew install inkscape` for the highest-fidelity export.
- Bring an existing figure draft (any format) if you have one; the Week 8 office hours pass it through `figure-qa` in real time.

Week 9 starts where Week 8 left off: BIDS, Hierarchical Event Descriptors (HED), and what the Methods section cites.
