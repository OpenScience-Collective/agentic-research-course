# Seed Cards -- TODO via opencite

The four anchor cards (`hasson-2004-isc`, `hasson-2008-neurocinematics`, `huth-2016-semantic-maps`, `saarimaki-2016-discrete-emotions`) are written in full. The remaining seed cards are listed in each strand's `INDEX.md` with a *(seed card pending)* marker. Run the commands below during the pre-session dry-run to populate them.

The whole point of the workflow is **not to hand-write paper-cards**. Cards are produced by `opencite` plus the schema in `_schema/paper-card.md`. The four anchors are written by hand only because they were drafted before the dry-run; everything else flows from the CLI.

## Per-strand opencite commands

### Strand A: Psychophysics

```bash
cd sessions/week-05/practicum/collection/psychophysics

# Dmochowski 2012 EEG correlated components
uvx opencite pdf "10.3389/fnhum.2012.00112" \
  -o ./dmochowski-2012-eeg-correlated-components/source.pdf --convert
uvx opencite lookup "10.3389/fnhum.2012.00112" -f bibtex --append-bib psychophysics.bib

# Dmochowski 2014 audience engagement
uvx opencite pdf "10.1038/ncomms5567" \
  -o ./dmochowski-2014-audience-engagement/source.pdf --convert

# Honey 2012 timescales
uvx opencite pdf "10.1016/j.neuron.2012.08.011" \
  -o ./honey-2012-timescales/source.pdf --convert
```

### Strand B: Action

```bash
cd sessions/week-05/practicum/collection/action

# Bartels & Zeki 2004 natural viewing
uvx opencite pdf "10.1002/hbm.10153" \
  -o ./bartels-2004-natural-viewing/source.pdf --convert

# Pineda 2005 mu-rhythm review
uvx opencite pdf "10.1016/j.brainresrev.2005.04.005" \
  -o ./pineda-2005-mu-suppression/source.pdf --convert

# Zacks 2007 event-segmentation theory
uvx opencite pdf "10.1037/0033-2909.133.2.273" \
  -o ./zacks-2007-event-segmentation/source.pdf --convert
```

### Strand C: Language

```bash
cd sessions/week-05/practicum/collection/language

# Lerner 2011 timescales
uvx opencite pdf "10.1523/JNEUROSCI.3684-10.2011" \
  -o ./lerner-2011-timescales/source.pdf --convert

# Brennan 2016 narrative EEG
uvx opencite pdf "10.1016/j.bandl.2016.04.008" \
  -o ./brennan-2016-narrative-eeg/source.pdf --convert

# Crosse 2016 mTRF Toolbox
uvx opencite pdf "10.3389/fnhum.2016.00604" \
  -o ./crosse-2016-mtrf/source.pdf --convert
```

### Strand D: Emotion

```bash
cd sessions/week-05/practicum/collection/emotion

# Nummenmaa 2012 emotion sync
uvx opencite pdf "10.1073/pnas.1206095109" \
  -o ./nummenmaa-2012-emotion-sync/source.pdf --convert

# Kragel 2019 emotion classifiers
uvx opencite pdf "10.1126/sciadv.aaw8262" \
  -o ./kragel-2019-emotion-classifiers/source.pdf --convert
```

## After retrieval

For each retrieved paper:

1. Verify the PDF downloaded (or note it is paywalled and only the markdown extraction is present).
2. Compute `sha256sum source.pdf` and write it into `meta.json` along with the license string.
3. Use the `/opencite:opencite` skill (or hand-edit using `_schema/paper-card.md`) to fill out `card.md` from the markdown extraction.
4. Confirm the `INDEX.md` one-liner matches the card content; tighten the description if needed.

## What the live demo skips

The live demo adds **one more** new paper at session time, on top of these seeds. The demo paper is chosen during the dry-run from a recent (2024-2026) open-access study in any of the four perspectives, ideally Healthy Brain Network (HBN)-adjacent so the cite ties back to the Week 3 practicum.
