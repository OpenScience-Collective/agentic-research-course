# Epic: Lit review -- Neural correlates of naturalistic movie watching

## Goal

Establish a methodical, well-cited literature review covering the neural correlates of naturalistic movie watching, organised by four analytical perspectives: psychophysics, action, language, emotion. Output: a paper-card corpus with at least 12 entries (3+ per strand), strand-level INDEX.md and .bib files, a synthesis layer with taxonomy and gap analysis, and a prose direction paper that defends a thesis grounded in the corpus.

The review serves the Week 5 session of the Agentic Research Course as a worked example of the 5-stage literature-review pipeline (direction, collect, synthesize, draft, review) applied at a scale that fits in one teaching session.

## Relationship to the Week 3 practicum

Week 3's HBN movie-watching practicum analyses event-related spectral perturbations (ERSP) around shot-change events in "The Present." The lit review here is the prerequisite: what does the literature say can be measured under naturalistic movie viewing, and along which axes? The review's findings should directly inform the analytical choices in the Week 3 practicum (band selection, time window, contrast definitions).

## Strands

Four parallel collection passes, one per analytical perspective:

1. **Strand A: Psychophysics** -- low-level neural tracking of image and motion statistics; intersubject correlation under naturalistic viewing; correlated EEG components; luminance, motion energy, and scene-cut responses.
2. **Strand B: Action** -- action observation under naturalistic viewing; motor and parietal responses to depicted actions; mirror-system literature in movie contexts.
3. **Strand C: Language** -- speech-elicited responses; narrative comprehension; semantic networks; hierarchy of timescales for language during continuous viewing.
4. **Strand D: Emotion** -- affective time courses; valence and arousal tracking; emotion-network synchronisation across viewers; discrete-emotion classifiers in naturalistic viewing.

## Phases

1. **Phase 1: Methodical collection (parallel strands)** -- four concurrent strand agents populate `collection/{psychophysics,action,language,emotion}/` with shared paper-card schema, .bib files, and per-strand INDEX. Uses `/opencite:opencite` for retrieval.
2. **Phase 2: Synthesis** -- cross-reference the corpus into `synthesis/` artefacts: taxonomy of measurement modalities, perspective-by-method matrix, gap analysis. No prose review yet.
3. **Phase 3: Direction paper** -- a prose mini lit review defending a thesis (candidate thesis: "EEG under naturalistic movie viewing tracks all four perspectives, but with sharply different signal-to-noise across them; the psychophysics layer is well established, language and action are emerging, emotion remains the noisiest layer").

## Workflow

- Epic branch: `feature/issue-N-epic-week5-litreview` from `main`
- Each phase: sub-issue + worktree + PR to epic branch + `/review-pr` + squash merge
- Final PR: epic branch -> `main`

## Acceptance criteria

- [ ] >=12 entries across all four strands (>=3 per strand)
- [ ] Every entry folder has `card.md`, `source.md`, and `meta.json`
- [ ] All entries have BibTeX in their strand `.bib`
- [ ] Each strand `INDEX.md` is populated with categorised one-liners
- [ ] `synthesis/` has at least one taxonomy / matrix and one gap analysis
- [ ] `direction-paper/draft-stub.md` has a thesis paragraph and at least one body paragraph; every claim cites a paper-card

## Out of scope

- Any imaging modality besides EEG (fMRI, MEG, iEEG cards may be cited as context but the review's empirical centre is EEG)
- Computational-model cards (those go in a separate "encoding-model" strand if revisited later)
- A full PRISMA systematic review; this is a focused mini lit review, not a registered protocol
