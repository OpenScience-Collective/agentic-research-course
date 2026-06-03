# Week 9 Outline -- Neuroinformatics: Standards, Sharing, and Credit

## Target
22 slides, ~30 min presentation + ~5 min live demo + ~15 min Q&A.

## Core message
You spent eight weeks producing an analysis. This week is about making the *data* behind it reproducible, shareable, and citable, so the work outlives the paper. Two standards do the heavy lifting: **BIDS** answers *where everything lives* (structure); **HED** answers *what every event meant* (semantics). The bar for "good enough" is concrete and high: an annotation is complete when a language model can reconstruct the stimulus or the experiment from the annotation alone, with no forensic search for unreported details. The `neuroinformatics` plugin gets your data to that bar (`/neuroinformatics:bids-conversion` + the `bids-validator` agent), `HEDit` automates the hardest part (natural language to validated HED), and `nemar-cli` ships it to the world with the one feature OpenNeuro still lacks: automatic ORCID author linking on the minted DOI, so credit flows back to you.

## Narrative arc
1. **The gap** -- a finished analysis nobody can rerun, events nobody can decode, credit nobody can trace.
2. **BIDS** -- the structure standard: directory layout, sidecars, TSVs. Where things live.
3. **HED** -- the semantics standard: hierarchical, composable, validatable event vocabulary. What things mean. The "recreate the stimulus" bar (HBN-EEG, Figure 9).
4. **HEDit** -- AI-assisted HED: describe in English, get validated HED back.
5. **The neuroinformatics plugin** -- `bids-conversion` skill + `bids-validator` agent (the mechanical defence).
6. **Sharing and credit** -- OpenNeuro then NEMAR; `nemar-cli` makes validation trivial, keeps data private until ready, and mints DOIs with ORCID author auto-linking.
7. **Demo + close** -- a tiny HEDit annotation, a `nemar dataset validate`, then Week 10 (build your own plugin).

## Practicum thread
The dataset throughout is HBN-EEG (Shirazi et al., 2024) -- the very data the course has analyzed since Week 3 ("The Present" movie). It is a BIDS + HED dataset published on both OpenNeuro and NEMAR with exactly the tools this session teaches. The loop closes: the data you analyzed is itself the worked example for how to share data.

## Continuity
- **Week 5 (lit review):** cite-the-card -> here, cite-the-dataset (every shared dataset earns a DOI).
- **Week 8 (figures):** last week an LLM-from-HED regenerated a stimulus figure; this week that same trick becomes the *standard of annotation completeness*.
- **Week 10 (plugins):** today is the last research-workflow plugin; next week you build your own.

## Out of scope (deliberate)
PsychoPy experiment design and Lab Streaming Layer (the data *collection* side) are in the plugin and the README but are not taught live this week; the session is about *standardizing and sharing* data you already have.
