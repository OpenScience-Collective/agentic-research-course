# Week 9 Slide Plan -- Neuroinformatics: Standards, Sharing, and Credit

## Target: 22 slides, ~30 min presentation, then ~5 min live demo + ~15 min Q&A

**Core message.** A finished analysis is not a finished contribution. The data behind it has to be reproducible, shareable, and citable, or the work dies with the paper. Two standards carry the weight: **Brain Imaging Data Structure (BIDS)** answers *where everything lives* (structure), and **Hierarchical Event Descriptors (HED)** answers *what every event meant* (semantics). The single most useful idea this session: the bar for a complete annotation is concrete and falsifiable: **a language model should be able to reconstruct the stimulus, or the experiment, from the annotation alone.** This is not a metaphor; it is exactly the test demonstrated in the HBN-EEG paper (Shirazi et al., 2024, Figure 9), where Claude Sonnet 3.5 regenerated the Surround Suppression stimulus as SVG using only its HED description. The `neuroinformatics` plugin gets data to that bar; `HEDit` automates the hardest leg (natural language to validated HED); `nemar-cli` ships it with automatic ORCID author linking on the DOI, the one feature OpenNeuro still lacks.

The arc mirrors prior weeks: a clear failure mode up front, a standard that fixes it, a mechanical defence per stage (the `bids-validator` agent; the HED validator in HEDit's loop; validation-on-upload in nemar-cli), and every theoretical point landing on the HBN practicum dataset, which is itself a BIDS + HED dataset published on OpenNeuro and NEMAR with these exact tools.

## Definitions on first use
- **BIDS** -- Brain Imaging Data Structure.
- **HED** -- Hierarchical Event Descriptors.
- **DOI** -- Digital Object Identifier.
- **ORCID** -- Open Researcher and Contributor ID.
- **HBN** -- Healthy Brain Network (the practicum dataset).

## Slide Inventory

### Opening (2 slides, ~2 min)

1. **Title** -- "Week 9: Neuroinformatics -- Standards, Sharing, and Credit." Author block, course / Discord / recording links. Same title-slide pattern as Weeks 5-8.
2. **Where we are** -- One bullet per Weeks 1-8, paired by theme, landing on: you have an analysis (and figures, from last week); today is about the *data* underneath it: reproducible, shareable, citable. Fragment-animated bullets, final bullet `slide-up`.

### Act 1 -- The gap (2 slides, ~3 min)

3. **The forensic-search problem** -- A great analysis nobody can rerun, an `events.tsv` that is one cryptic numeric column, and reuse that traces credit to no one. Three locks: structure, semantics, credit. Asset: `reuse-credit-gap.svg` (a rich raw recording collapsing into a thin shared artifact, with three padlocks labelled Structure / Semantics / Credit). Callout (paper phrase): *"analysis-ready means no forensic search for unreported details."*
4. **Two standards and a bar for clarity** -- BIDS answers *where* (structure); HED answers *what* (semantics). The bar that judges both: someone, or a language model, can reconstruct your experiment without emailing you. Asset: `two-standards-bar.svg` (left: BIDS = structure/filesystem; right: HED = semantics/meaning; a banner across the top: "the bar -- an LLM can recreate the stimulus from the annotation alone"). This plants the bar early; it pays off on slide 10.

### Act 2 -- BIDS, the structure standard (3 slides, ~5 min)

5. **What is BIDS** -- A filesystem convention plus metadata: `sub-<label>/ses-<label>/<modality>/` naming, JSON sidecars, TSV tables, top-level `dataset_description.json` and `participants.tsv`. Asset: `bids-tree.svg` (an annotated directory tree for one HBN-EEG subject: `sub-01/eeg/sub-01_task-..._eeg.set`, `_eeg.json`, `_channels.tsv`, `_events.tsv`; root `dataset_description.json`, `participants.tsv`).
6. **Why BIDS** -- One layout, every tool. A BIDS dataset is readable by EEGLAB, MNE, validators, BIDS Apps, and is the upload format both OpenNeuro and NEMAR expect; it is also what makes mega-analysis across studies possible. Asset: `bids-why.svg` (a single BIDS dataset in the centre feeding out to EEGLAB / MNE / validator / OpenNeuro / NEMAR / mega-analysis). Callout: standard structure is what turns "my data" into "reusable data."
7. **Where structure ends -- the sidecar and events.tsv** -- The JSON sidecar carries acquisition metadata (`SamplingFrequency`, `EEGReference`, `PowerLineFrequency`, channel counts); `events.tsv` carries `onset, duration, trial_type, value`. Structure tells you *where* an event is on the timeline; it does not tell you *what the event was*. Asset: `sidecar-anatomy.svg` (annotated `_eeg.json` sidecar beside an `events.tsv`, with the `events.tsv` highlighted and a tag: "structure says WHERE; it cannot say WHAT"). Bridges to HED.

### Act 3 -- HED, the semantics standard, and the bar (3 slides, ~5 min)

8. **events.tsv is thin** -- The one-column problem: an onset and a cryptic code (HBN originally shipped numeric event codes). Everything the event meant -- modality, stimulus content, response, context -- is missing from the shared file. Asset: `events-thin.svg` (a thin `events.tsv` with a cryptic `value` column on the left; a list of what is NOT captured on the right: stimulus content, modality, condition, response, context). Note: HBN-EEG replaced numeric codes with meaningful strings as step one.
9. **HED -- the fix in principle** -- Hierarchical Event Descriptors: a controlled, composable, validatable vocabulary. One tag is a comma-separated path; the hierarchy carries meaning (`Action/Move/Move-body-part/.../Press`), so analysis works at any level of the tree; value slots take typed numbers with units. The sidecar pattern: `events.tsv` is unchanged, all semantics live in `events.json` under HED keys. Asset: `hed-anatomy.svg` (a HED tag broken into its hierarchical path + a `events.json` HED-key sidecar beside an unchanged `events.tsv`). The three stated objectives of HED (from the paper): build event context; machine-readable + human-understandable annotation for mega-analysis and machine learning; task transparency and reproducibility.
10. **The bar: recreate the stimulus** -- THE slide. The HBN-EEG Surround Suppression task: its HED annotation alone was handed to Claude Sonnet 3.5, which regenerated the visual stimulus as SVG -- accurate down to foreground/background contrast and grating structure (it only missed the disks' size and position, which are awkward to express in HED, so were left out). If a model can redraw your stimulus from the annotation, the annotation is complete; if it can't, you left something out. Asset: `recreate-the-stimulus-figure.svg` -- the **actual paper Figure 9** (raster, caption cropped) embedded as a data-URI, with a "what the model was given: the HED only" banner and two aligned callouts: green "Reproduced from the HED alone" under the intended panel, amber "The miss: disk size and position -- both awkward to express in HED, so left out" under the regenerated panel. Source raster also kept at `recreate-the-stimulus.png`. Cite: Shirazi et al. (2024), HBN-EEG, bioRxiv 10.1101/2024.10.03.615261. Ties back to Week 8 (LLM-from-HED also drew the paper's figures) and forward to the live demo.

### Act 4 -- HEDit, AI-assisted annotation (2 slides, ~3 min)

11. **Why HED workflows stall** -- ~2000 tags, expert-only fluency, a validator with cryptic messages; adoption stays inside the labs that build the schema. This is a workflow problem, not a willingness problem. Asset: `hed-workflow-pain.svg` (a 4-step pain pipeline: read the paper -> learn the schema -> write the sidecar -> validate and repeat; a bottom rail: "HED stays with the HED authors"). Adapted from the HEDit deck's `workflow-pain.svg`, re-themed to the course palette.
12. **HEDit -- describe in English, get validated HED** -- You write one rich prose description per event value; HEDit runs a Parser -> Tagger -> Validator pipeline (LangGraph multi-agent, the official HED validator in the loop) and returns a BIDS-compliant `events.json` with HED tags plus a provenance trail. Scope today: natural language to validated HED. Asset: `hedit-pipeline.svg` (Parser -> Tagger -> Validator with a feedback loop from Validator back to Tagger; a bottom rail: "the HED schema is the contract -- no agent invents vocabulary"). Adapted from the HEDit deck. Callout linking to slide 10: HEDit is tuned for exactly the detail the "recreate the stimulus" bar demands; garbage in, garbage out.

### Act 5 -- The neuroinformatics plugin (3 slides, ~5 min)

13. **The neuroinformatics plugin -- 2 skills + 1 agent** -- Map: `/neuroinformatics:bids-conversion` (guided conversion), the `bids-validator` agent (autonomous validate + fix), and `/neuroinformatics:experiment-design` (the collection side -- PsychoPy + Lab Streaming Layer; in the plugin and the README, not today's focus). HED annotation lives inside the skills. Asset: `neuro-plugin-map.svg` (centre: bids-conversion; an agent card: bids-validator; a dimmed/"also included" card: experiment-design). Same visual language as `figures-plugin-map.svg`.
14. **/neuroinformatics:bids-conversion** -- A guided six-step workflow: inventory source data -> scaffold (`dataset_description.json`, `participants.tsv`, directory tree) -> convert files (BrainVision, EEGLAB `.set`, EDF, BDF) -> write JSON sidecars -> write TSVs (`channels`, `events`, `electrodes`, `coordsystem`) -> validate. Modalities: EEG, EMG, MEG, fMRI, behavioral. Asset: `bids-conversion-flow.svg` (the six steps as a horizontal flow with the file artifacts each step produces).
15. **The bids-validator agent -- the mechanical defence** -- Autonomous: locates the dataset, runs the BIDS validator, categorizes findings (errors must-fix / warnings should-fix / info), applies fixes with confirmation, re-validates, and reports readiness for OpenNeuro/NEMAR. This is this week's equivalent of `cite-the-card` / `validate_fonts.py`: a deterministic gate that turns "looks fine" into a pass/fail. Asset: `bids-validator-agent.svg` (the agent loop on the left; a sample report on the right: errors fixed, remaining warnings, "Ready for submission: YES"). Note the division of labour: the agent fixes your data *locally*; nemar-cli (next act) validates again *at the gate*.

### Act 6 -- Sharing and credit (6 slides, ~7 min)

16. **Where BIDS data goes -- OpenNeuro** -- The de-facto open BIDS archive: browser or CLI upload, BIDS-validated on ingest, public, gets a DOI. The default home for shared neuro data. Asset: `openneuro-flow.svg` (validate -> upload -> public + DOI). Honest framing: OpenNeuro *does* support private upload, but only via CLI / direct push (no polished GUI for it); and the DOI record stays sparse -- no ORCID author links, minimal metadata. (Private-vs-public is not the differentiator; the metadata/credit gap on slide 21 is.)
17. **NEMAR -- EEG/MEG focus, compute adjacency** -- The Neuroelectromagnetic Data Archive and Tools Resource: BIDS datasets specialized for EEG/MEG, sitting next to San Diego Supercomputer Center compute so you can analyze without downloading. HBN-EEG lives on both OpenNeuro and NEMAR. Asset: `openneuro-nemar.svg` (OpenNeuro and NEMAR side by side, shared BIDS core, NEMAR adding the compute-adjacency badge). Keep claims conservative.
18. **nemar-cli -- validation is now trivial** -- `nemar dataset validate ./my-dataset` wraps the official BIDS validator; validation also runs automatically on upload and on every update PR. No separate toolchain to install or configure. Asset: `nemar-validate.svg` (the one command + a clean validation report). One of the session's headline points.
19. **nemar-cli -- upload to publish** -- The flow: `nemar auth login` -> `nemar dataset validate ./ds` -> `nemar dataset upload ./ds` -> `nemar dataset publish request <id>`. The real model: upload creates a **private GitHub repo where you're admin** -- you invite collaborators and push directly until publish; after publishing, changes go through **pull requests + version tags**. (OpenNeuro also allows private upload, just CLI-only -- so the NEMAR advantage is this collaboration model plus the rich DOI metadata, not "private vs public.") Asset: `nemar-upload-publish.svg` (four-command pipeline with a private->public state band). Command/flag spellings verified against nemar-cli docs.
20. **DOI minting + ORCID auto-link** -- THE differentiator. On publish, nemar-cli mints a concept DOI plus per-version DOIs (DataCite), and **auto-links every author to their ORCID iD in the DOI metadata**, so the dataset appears on each author's ORCID record automatically. OpenNeuro does not do author-level ORCID linking yet. Asset: `doi-orcid.svg` (authors -> ORCID iDs -> DataCite DOI metadata -> the dataset showing up on an ORCID profile). Callout: "your dataset shows up on your ORCID record without you lifting a finger -- credit, automatically."

21. **The metadata gap -- proof on a real dataset** -- The same dataset on both homes: NEMAR `nm000103` vs OpenNeuro `ds005505` (HBN-EEG Release 1, the same 8 authors), read live from the DataCite API. OpenNeuro's DOI record carries only a title and author names; NEMAR fills license (CC-BY-NC-SA-4.0), 8 keywords, description, 5 related links (papers + datasets), 8/8 ORCID iDs, funding, and a stable concept DOI. Findability (FAIR) and credit are metadata the platform writes, not luck. Asset: `doi-metadata-gap.svg` (two-column comparison grouped into FINDABILITY and CREDIT rows; ORCID row highlighted; source line cites api.datacite.org). The strongest evidence slide in the deck because it is the audience-relevant dataset and real, current data.

### Act 7 -- Demo and close (2 slides, ~2 min + 5 live)

22. **Live demo roadmap** -- Two small, honest actions: (1) HEDit -- one rich prose description of an HBN event -> a validated HED string (the "recreate the stimulus" bar in miniature); (2) `nemar dataset validate` on the HBN practicum dataset -> a clean BIDS report. Nothing more. Asset: `demo-roadmap-neuro.svg` (two steps with timing badges; a note: "we do not manufacture a pass"). Matches the answered scope: small HEDit annotation + nemar-cli validate only.
23. **What today gives you / what's next** -- Today: BIDS (structure) + HED (semantics) + the recreate-the-stimulus bar + the plugin (`bids-conversion` + `bids-validator`) + sharing with DOI/ORCID credit. The HBN data you have analyzed since Week 3 is itself a BIDS + HED dataset shared this exact way. Next: Week 10 -- build your own plugin. Two-column bullets + callout.

## Slide Budget

| Phase | Slides | Time |
|-------|--------|------|
| Opening | 2 | 2 min |
| Act 1 -- the gap | 2 | 3 min |
| Act 2 -- BIDS | 3 | 5 min |
| Act 3 -- HED + the bar | 3 | 5 min |
| Act 4 -- HEDit | 2 | 3 min |
| Act 5 -- plugin | 3 | 5 min |
| Act 6 -- sharing + credit | 6 | 7 min |
| Act 7 -- demo + close | 2 | 1 min + 5 live |
| **Total** | **23** | **~31 min content + 5 min demo** |

Q&A (~15 min) fills the rest. Acts 3 and 6 carry the new and the headline material; budget extra breathing room there.

## Animation Discipline (same as Weeks 5-8)

Every multi-bullet slide and every multi-line code block uses **fragment animations** so one concept is on screen at a time.
- Bullets stagger in one per click (`animation: { fragment: true, type: "fade", index: N }`), final bullet `slide-up`.
- Footer/side callouts appear after the main content (`fragment: true, type: "slide-up"`).
- Hero diagrams are single composed SVGs; build-on-click is baked into the speaker pacing, not the SVG.
- Speaker notes lead with `[Press right Nx to reveal fragments]` on animated slides.

Text sizing (matching Week 8): title `xxl` / subtitle `large` / author `medium`; slide headers `xl`; bullets `xl` or `large`; hero images 82-94% width; callouts in `footer` (single-column) or `right` (two-column).

## Assets to produce (hand-crafted SVG, no mermaid; ship in `assets/icons/`)

Course palette (default theme, blue accent `#2563EB`), not the HEDit green/orange.

1. `reuse-credit-gap.svg` -- slide 3. Rich raw recording collapsing into a thin shared artifact; three padlocks: Structure / Semantics / Credit.
2. `two-standards-bar.svg` -- slide 4. BIDS = structure | HED = semantics, under a banner: "the bar -- an LLM can recreate the stimulus from the annotation alone."
3. `bids-tree.svg` -- slide 5. Annotated BIDS directory tree for one HBN-EEG subject.
4. `bids-why.svg` -- slide 6. One BIDS dataset feeding EEGLAB / MNE / validator / OpenNeuro / NEMAR / mega-analysis.
5. `sidecar-anatomy.svg` -- slide 7. `_eeg.json` sidecar beside `events.tsv`, with "structure says WHERE; it cannot say WHAT."
6. `events-thin.svg` -- slide 8. Thin `events.tsv` (cryptic `value`) + list of missing meaning.
7. `hed-anatomy.svg` -- slide 9. A HED tag's hierarchical path + a HED-key `events.json` beside an unchanged `events.tsv`. (Adapt from HEDit `hed-anatomy.svg` + `hed-sidecar.svg`, re-themed.)
8. `recreate-the-stimulus-figure.svg` -- slide 10 (centerpiece). The actual paper Figure 9 (raster embedded) + "what the model was given" banner + matched/only-miss callouts. (`recreate-the-stimulus.png` is the source raster.)
9. `hed-workflow-pain.svg` -- slide 11. 4-step pain pipeline. (Adapt from HEDit `workflow-pain.svg`.)
10. `hedit-pipeline.svg` -- slide 12. Parser -> Tagger -> Validator with feedback loop. (Adapt from HEDit `hedit-pipeline.svg`.)
11. `neuro-plugin-map.svg` -- slide 13. bids-conversion (centre) + bids-validator agent + experiment-design (dimmed).
12. `bids-conversion-flow.svg` -- slide 14. Six-step conversion flow with per-step artifacts.
13. `bids-validator-agent.svg` -- slide 15. Agent loop + sample readiness report.
14. `openneuro-flow.svg` -- slide 16. validate -> upload -> public + DOI.
15. `openneuro-nemar.svg` -- slide 17. OpenNeuro and NEMAR side by side, shared BIDS core, NEMAR compute-adjacency.
16. `nemar-validate.svg` -- slide 18. `nemar dataset validate` command + clean report.
17. `nemar-upload-publish.svg` -- slide 19. Four-command pipeline with private/public toggle.
18. `doi-orcid.svg` -- slide 20 (centerpiece). authors -> ORCID -> DataCite DOI -> ORCID profile.
19. `doi-metadata-gap.svg` -- slide 21 (centerpiece, real data). Side-by-side DataCite metadata: NEMAR nm000103 vs OpenNeuro ds005505, grouped into findability + credit fields.
20. `demo-roadmap-neuro.svg` -- slide 22. Two demo steps with timing badges.

Slides 1, 2, 23 are text/bullets only (no hero SVG). 21 hero figures total (20 authored SVGs + the slide-10 composed figure embedding the real paper Figure 9 raster).

## Production Notes
- Reuse the HEDit deck's HED/HEDit assets as *design references*, but regenerate in the course palette (blue accent, default theme) for visual consistency with Weeks 1-8. Source: `annot-garden/.../annotate-those-steps/assets/icons/`.
- Slide 10 (`recreate-the-stimulus-figure.svg`) and slide 20 (`doi-orcid.svg`) are the two slides trainees will quote; give them the strongest before/after treatment and make the report/figure readable from the back of the room.
- Code/command snippets inside skill/CLI slides render as SVG `<text>`, not raster, so they stay crisp and re-themeable.
- **Verify before freezing the JSON:** exact `nemar-cli` command and flag spellings (validate / upload / publish request / auth login), the DOI provider name (DataCite vs EZID), and the precise wording of "OpenNeuro lacks ORCID author linking," all against `nemar-cli/docs`. Keep on-slide claims at the headline level; do not put unverified internal specifics (orchestrator step counts, DOI prefixes, IAM details) on slides.
- HBN-EEG facts safe to state: 2,600+ participants, nine releases, on OpenNeuro and NEMAR, six tasks (passive: Resting State, Surround Suppression, Movie Watching; active: Contrast Change Detection, Sequence Learning, Symbol Search); "The Present" is the Week-3 practicum stimulus.

## Continuity With Prior Weeks
- **Week 5 (lit review):** cite-the-card becomes cite-the-dataset; every shared dataset earns a DOI.
- **Week 8 (figures):** the LLM-from-HED stimulus regeneration that drew the paper's figures is reframed here as the *standard of annotation completeness*.
- **Week 10 (plugins):** the last research-workflow plugin of the course; next week trainees build their own.
