# Strand A, Psychophysics (Phase 1 brief)

**Goal.** Populate `collection/psychophysics/` with at least 5 paper-cards covering the low-level neural tracking of image and motion statistics under naturalistic movie viewing. The strand answers: under what conditions can we recover stimulus-locked responses (intersubject correlation, correlated components, time-resolved tracking of luminance / motion / scene cuts) from electroencephalography (EEG) during continuous viewing, and what is the typical signal-to-noise ratio?

## Scope

Cover four sub-areas. Aim for breadth first, depth where it directly anchors the strand's main claim.

### 1. Intersubject correlation (ISC) under naturalistic viewing

- Hasson et al. 2004, intersubject correlation in fMRI under naturalistic viewing; the foundational paper. (Cited for context even though fMRI; EEG cards must connect to it.)
- Dmochowski et al. 2012, *Frontiers in Human Neuroscience*, correlated components of EEG during naturalistic viewing.
- Subsequent EEG ISC work, ideally 2018-2026, with HBN-relevant cohorts.

### 2. Time-resolved tracking of low-level features

- Luminance- and motion-energy regression on EEG; mTRF-style analyses on naturalistic stimuli.
- Scene-cut and shot-change responses in EEG; Dmochowski follow-ups.
- Pupillometry as a complementary channel (eye-tracking during EEG).

### 3. Slow timescales

- Honey et al. 2012, slow timescales of cortical processing under naturalistic stimuli.
- Lerner et al. 2011, hierarchy of timescales in language comprehension (cite in this strand for the timescale framing; full card may live in the language strand).

### 4. EEG methodology under naturalistic stimuli

- Reliable-components analysis, joint decorrelation, blind source separation tuned for naturalistic viewing.
- Artefact handling specific to long, free-viewing recordings (eye, motion, drift).

## Per-entry deliverable

Create folder `collection/psychophysics/<slug>/` containing:

- `card.md` from the schema (`type: paper`, `strand: psychophysics`)
- `source.pdf` only when redistributable
- `source.md` always required (markdown extraction)
- `meta.json` with provenance
- BibTeX entry appended to `collection/psychophysics/psychophysics.bib`
- One-line entry appended to `collection/psychophysics/INDEX.md` under the right sub-area heading

Use `/opencite:opencite` for retrieval, or the `opencite` CLI directly.

## Skills to use

- `/opencite:opencite` for paper retrieval, DOI lookup, BibTeX export
- `/manuscript:manuscript-writing` (only when drafting card prose) for prose discipline (no em-dashes, define abbreviations on first use)

## Acceptance criteria

- [ ] >=5 entries across the four sub-areas
- [ ] Every entry folder has `card.md`, `source.md`, and `meta.json`
- [ ] `source.pdf` archived for >=60% of entries that have a redistributable paper
- [ ] All entries have BibTeX in `psychophysics.bib`
- [ ] `INDEX.md` populated with categorised one-liners

## Out of scope

- Action, language, or emotion perspectives (those have their own strands)
- Encoding-model methodology papers (cite in `Notable details` as needed; do not create cards here)
- Static-image or single-trial paradigm work unrelated to continuous naturalistic viewing
