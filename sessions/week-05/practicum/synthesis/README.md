# Phase 2 Synthesis

Synthesis cross-references the Phase 1 corpus into structured artefacts. **No prose review here**; that lives in `direction-paper/`. Synthesis outputs are tables, hierarchies, and gap analyses that the prose review draws on.

Abbreviations: Electroencephalography (EEG), functional magnetic resonance imaging (fMRI), intersubject correlation (ISC), Healthy Brain Network (HBN). Each individual document redefines abbreviations on first use within that document.

## Documents

- [`gap-analysis-stub.md`](./gap-analysis-stub.md) -- starter gap analysis, one row per strand. Identifies the most visible coverage gap each strand has against the demo's target thesis. The boomerang from Stage 5 (paper-review) writes new rows here when reviewer findings surface gaps not yet listed.

## To be added during the dry-run

- `perspective-by-method.md` -- a 4-by-N matrix of analytical perspective (rows: psychophysics, action, language, emotion) by EEG analysis method (columns: ISC, time-resolved regression, frequency-band tracking, classification). Each cell summarises how well-established the combination is and cites the supporting paper-cards.
- `signal-to-noise-ladder.md` -- a ranking of the four perspectives by typical EEG signal-to-noise ratio under naturalistic viewing, with citation evidence per ranking position.

## Citation conventions

Every claim in these documents that depends on a specific paper cites the corresponding `card.md` by relative path, e.g. [`../collection/psychophysics/hasson-2004-isc/card.md`](../collection/psychophysics/hasson-2004-isc/card.md). The card is the primary source; BibTeX keys come from the strand `.bib` files.
