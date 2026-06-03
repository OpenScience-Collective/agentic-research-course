# Week 9 SVG house style (match Weeks 5-8 exactly)

All hero SVGs live in `assets/icons/` and are referenced from the deck as `../../assets/icons/<name>.svg`. Hand-authored SVG only, NO mermaid. They must render correctly as static SVG in a browser (Reveal.js), and read clearly from the back of a 30-foot room.

## Canvas
- Root: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 360" width="1000" height="360">` (use height 320 for shorter diagrams; never exceed 360). Wide 16:9-ish hero.
- Everything is drawn in this 1000-wide coordinate space. Keep a ~40px left/right margin (content x from ~40 to ~960).

## Typography (font-family always "sans-serif", or "monospace" for code/commands/filenames)
- Title (top, centered): `x="500" y="24" font-size="15" fill="#1E293B" font-weight="bold" text-anchor="middle"`.
- Subtitle/italic tagline under title: `x="500" y="42" font-size="11" fill="#64748B" font-style="italic" text-anchor="middle"`.
- Card title: font-size 12-13 bold, in the card's dark color.
- Card body lines: font-size 9.5-10.5.
- Monospace command/filename/code: font-size 10-11.5, `font-family="monospace"`.
- Bottom "moral strip" text: font-size 10-11.
- Never go below font-size 9 for anything meant to be read; 6-7 is allowed only to *depict* "too small" failure cases.

## Color families (light fill / saturated stroke / dark text)
- Blue (structure, primary): fill `#DBEAFE`, stroke `#2563EB`, text `#1E40AF`. Lighter fill `#EFF6FF`.
- Green (good / success / semantics-rich): fill `#D1FAE5`, stroke `#059669`, text `#065F46`.
- Purple (compose / tooling): fill `#EDE9FE` (header band `#DDD6FE`), stroke `#7C3AED`, text `#5B21B6`.
- Amber (caution / steps): fill `#FEF3C7`, stroke `#D97706`, text `#92400E`.
- Teal (export / alt): fill `#CCFBF1`, stroke `#0D9488`, text `#134E4A`.
- Pink/magenta (agent): fill `#FCE7F3` (header band `#FBCFE8`), stroke `#BE185D`, text `#831843` / `#9D174D`.
- Red (danger / missing / "broken"): fill `#FEE2E2`, stroke `#DC2626`, text `#991B1B` / `#7F1D1D`.
- Neutrals: text `#1E293B`, muted `#475569` / `#64748B` / `#94A3B8`, borders `#CBD5E1`, panel fill `#F1F5F9`, white `#FFFFFF`.
- ORCID brand green (use ONLY for ORCID marks): `#A6CE39`. DOI/DataCite can use blue.

## Card recipe
```
<rect x=".." y=".." width=".." height=".." rx="6" fill="<lightfill>" stroke="<stroke>" stroke-width="1.4"/>
```
- Use stroke-width 1.4 for normal cards, 1.8-2 for the emphasized/centerpiece card.
- Two-tone "named" card (command/skill name in a header band): draw the full card, then a header band rect on top:
```
<rect x="380" y="170" width="240" height="100" rx="6" fill="#EDE9FE" stroke="#7C3AED" stroke-width="2"/>
<rect x="380" y="170" width="240" height="26" rx="6" fill="#DDD6FE" stroke="#7C3AED" stroke-width="2"/>
<text x="500" y="188" font-family="monospace" font-size="11.5" fill="#5B21B6" font-weight="bold" text-anchor="middle">/command:name</text>
```

## Arrow markers (paste once per file in a <defs>, vary the id)
```
<marker id="arrowfwd" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
  <path d="M 0 0 L 10 5 L 0 10 z" fill="#475569"/>
</marker>
```
- Forward arrows: stroke `#475569` width 1.2-1.6, `marker-end="url(#arrowfwd)"`.
- Feedback/loop arrows: red `#DC2626`, `stroke-dasharray="6,3"`, with a red marker variant.

## Badge recipe (e.g. NEW, TRIVIAL, ORCID)
```
<rect x=".." y=".." width="42" height="16" rx="3" fill="#DC2626"/>
<text x=".." y=".." font-size="9.5" fill="#FFFFFF" font-weight="bold" text-anchor="middle">NEW</text>
```

## Bottom "moral strip" (most heroes end with one)
```
<rect x="60" y="334" width="880" height="20" rx="4" fill="#F1F5F9" stroke="#94A3B8" stroke-width="0.6"/>
<text x="500" y="348" font-size="10" fill="#1E293B" text-anchor="middle">One-line takeaway.</text>
```

## Mock code/terminal block (for CLI slides)
- Draw a dark rounded rect `fill="#0F172A"` (slate-900) or light `#F8FAFC` with border; render commands as `monospace` `<text>` lines, prompt `$` in muted color, command in `#E2E8F0` (on dark) or `#1E293B` (on light), flags/comments in a muted/green tint. Keep ~14px line height.

## Hard rules
- No overlapping text. Compute x/y so labels sit inside their boxes (use `text-anchor="middle"` and center on the box).
- Arrows end exactly at the target box edge (gap of ~2px), not inside it.
- Title + subtitle at top; optional moral strip at bottom; main content in between (y ~60 to ~320).
- Reference templates to mirror: `assets/icons/figures-pipeline.svg` (horizontal pipeline), `assets/icons/figures-plugin-map.svg` (center + satellite cards), `assets/icons/figures-failure-modes.svg` (left/right before-after with mock plots).
- Output valid standalone SVG. Self-check: every `<rect>`/`<text>`/`<line>` is closed; the file starts with `<svg` and ends with `</svg>`.
