# Week 5 Practicum: Lit Review on the Neural Correlates of Naturalistic Movie Watching

A working, smaller-scale reproduction of the AGI research-foundation epic ([`Annotation-Garden/management#3`](https://github.com/Annotation-Garden/management/issues/3)). The goal is a focused mini literature review organised by **four analytical perspectives**: psychophysics, action, language, emotion. The corpus is sized so that one new paper-card can be added live in the Week 5 demo and the boomerang can run end-to-end in five minutes.

## Topic

> What is currently known about the neural correlates of naturalistic movie watching, viewed through four perspectives: low-level **psychophysics** (correlated activity tracking image and motion statistics), **action** observation (motor and parietal responses to depicted actions), **language** comprehension (semantic and narrative networks engaged by dialogue and voiceover), and **emotion** dynamics (affective time courses tracking valence and arousal)?

The review extends the Week 3 HBN movie-watching practicum: the dataset is the Healthy Brain Network (HBN) electroencephalography (EEG) collection, with "The Present" Pixar short as the default stimulus, and the empirical layer is what an EEG pipeline can actually measure under each perspective.

## Layout

```
practicum/
├── README.md                       # this file
├── epic-brief.md                   # the epic-issue body (drives /project:epic-dev)
├── _briefs/
│   ├── strand-A-psychophysics.md
│   ├── strand-B-action.md
│   ├── strand-C-language.md
│   └── strand-D-emotion.md
├── _schema/
│   └── paper-card.md               # mirrors the AGI schema
├── collection/
│   ├── psychophysics/              # 3-5 seed paper-cards
│   ├── action/                     # 3-5 seed paper-cards
│   ├── language/                   # 3-5 seed paper-cards
│   └── emotion/                    # 3-5 seed paper-cards
├── synthesis/
│   ├── README.md
│   └── gap-analysis-stub.md
└── direction-paper/
    └── draft-stub.md               # the prose review starts here
```

## Live Demo Sequence (5 min)

The pre-built state ships with the four strand briefs, the schema, the seed paper-cards (open-access only; paywalled cards have `card.md` and `source.md` but no `source.pdf`), and a one-row gap-analysis stub. The live demo runs three commands in sequence:

1. **Add one paper.** Pick a 2024-2026 open-access paper from any of the four strands. Run the `/opencite:opencite` skill with the DOI; it should produce `card.md`, `source.md`, `meta.json` in `collection/<strand>/<slug>/`, append to the strand `INDEX.md`, and add a BibTeX entry to the strand `.bib`.
2. **Weave one paragraph.** Run `/manuscript:manuscript-writing` to incorporate the new paper into one synthesis paragraph in `direction-paper/draft-stub.md`. Every claim must cite a paper-card by relative path (`../collection/<strand>/<slug>/card.md`).
3. **Run the review.** Run `/manuscript:paper-review` on the new paragraph. Whatever the review surfaces, walk it through. If a real gap appears (the most likely natural one given HBN's developmental cohort and the seed-card distribution is **age-effect / developmental coverage**), describe the boomerang back to Stage 2 with a follow-on `opencite search "naturalistic movie EEG developmental"` call -- but do not run it on stage; we stay in the time box.

## Acceptance State

The practicum is "ready" when:

- All four strand briefs are populated with goal, scope, per-entry deliverable, acceptance criteria, out-of-scope.
- Each strand's `collection/<strand>/` directory has at least 3 paper-cards (5 preferred), each with `card.md` matching the schema. Open-access PDFs are committed; paywalled cards have `pdf_status: not-redistributable`.
- Each strand has a populated `INDEX.md` and `.bib`.
- `synthesis/gap-analysis-stub.md` has at least one row per strand identifying a known coverage gap.
- `direction-paper/draft-stub.md` has the section skeleton ready for a new paragraph to be woven in.

## Conventions

- Abbreviations defined on first use within each document. Brain Imaging Data Structure (BIDS), Hierarchical Event Descriptors (HED), Healthy Brain Network (HBN), Electroencephalography (EEG).
- No em-dashes; commas or semicolons.
- No emojis.
- Every claim in `direction-paper/` cites a `collection/<strand>/<slug>/card.md` by relative path; if the agent cannot point to a card, the claim does not appear in the draft.
- Calibration anchors for `agi_relevance` follow the AGI schema verbatim (`_schema/paper-card.md`).
