# Week 8: Scientific Figures

## Learning Objectives

By the end of this session, you will:
- Plan publication-quality figures with proper dimensions and palettes
- Generate icons and diagrams programmatically
- Create data plots with matplotlib, seaborn, and plotly
- Compose multi-panel figures with react-pdf
- Run a visual QA feedback loop to refine figures

## Outline

### Part 1: Figure Planning (10 min)
- Journal requirements: dimensions, DPI, fonts, file formats
- Choosing a colorblind-safe palette (Wong, Tol, Okabe-Ito)
- Panel layout: how many panels, what each shows
- Sans-serif fonts for all text elements

### Part 2: Creating Elements (15 min)
- Icons with gpt-image-1.5 (transparent PNG, specific constraints)
- Data plots with matplotlib/seaborn (publication style)
- Setting rcParams for consistent styling
- Exporting as SVG or high-resolution PNG

### Part 3: Composition (10 min)
- Assembling panels with react-pdf
- Panel labels (A, B, C), scale bars, legends
- Rendering to PDF, converting to PNG for preview
- Standard sizes: single column, double column, full page

### Part 4: Visual QA (10 min)
- The feedback loop: render -> inspect -> fix -> repeat
- Common issues: overlapping labels, inconsistent fonts, pixelation
- Caption writing: self-contained, all panels referenced
- Final checks before submission

### Q&A (15 min)

## Key Concepts

- **DPI:** Dots per inch; 300 minimum for photos, 600 for line art
- **Colorblind-safe palette:** Colors distinguishable by people with color vision deficiency
- **react-pdf:** JavaScript library for programmatic PDF composition
- **Visual QA:** Iterative process of rendering, inspecting, and refining figures
- **Panel labels:** Letters (A, B, C) identifying sub-figures in a multi-panel figure

## Before Next Session

- Have some data you'd like to visualize
- Install matplotlib: `uv add matplotlib seaborn`
