# HBN "The Present": Boy-Shot vs Puppy-Shot ERSP

## Research Question

Do the first 500 ms of neural responses differ when a movie shot begins with the boy visible versus the puppy visible? This uses the HBN-EEG dataset, Release 3, for the "The Present" movie-watching task. The comparison metric is event-related spectral perturbation (ERSP) aligned to shot onsets.

## Working Hypothesis (Placeholder)

Shots opening with the puppy elicit a different early ERSP pattern than shots opening with only the boy. The direction (suppression vs enhancement), frequency band, and scalp topography are intentionally unspecified here; fix them during the planning session based on the literature and on the specific contrast you choose below. The 0-500 ms window is the analysis window, not a content filter.

## Dataset

- **Release:** HBN-EEG R3 (ds005507 on NEMAR / OpenNeuro)
- **S3 URI:** `s3://fcp-indi/data/Projects/HBN/BIDS_EEG/cmi_bids_R3`
- **Subjects:** 183 (see participants.tsv for availability flags)
- **Task:** `ThePresent` (passive movie watching)
- **Sampling rate:** 500 Hz (full), 100 Hz (mini subset)
- **Channels:** 128 EEG (Geodesic Sensor Net, HydroCel)
- **Format:** BIDS, event markers in `_events.tsv`

The full R3 is ~140 GB. For development, the R3-mini (100 Hz, 20 subjects) is recommended; scale to full R3 only after the pipeline runs end-to-end.

## Stimulus and Events

"The Present" is a ~3.5-minute Pixar short. The HBN events files mark coarse task boundaries (`start_trial`, `stop_trial`) but not individual shots. Shot-level events are expanded at analysis time from the stimulus-side file `shot_events.tsv` (bundled alongside this brief).

### shot_events.tsv columns

| Column | Description |
|--------|-------------|
| `onset` | Shot onset in seconds from stimulus start |
| `duration` | Shot duration in seconds |
| `shot_number` | Sequential shot index (`video_start`, `1..56`, `video_stop`) |
| `LLR` | Log luminance ratio relative to previous shot (brightness change) |
| `has_boy` | 1 if the boy/child is visible at shot onset, else 0; `n/a` if unannotated |
| `has_puppy` | 1 if the puppy/dog is visible at shot onset, else 0; `n/a` if unannotated |
| `match_diff_s` | Seconds between the stimulus shot onset and the nearest frame-level annotation onset (quality check; lower is better) |

### Shot statistics

- Total shots: 56
- Annotated (matched to a frame-level description): 52
- Trusted labels (`match_diff_s <= 1.0 s`): 49
- High-drift labels (`match_diff_s > 1.0 s`, invalidated to `n/a`): 3
- Unmatched (no nearby annotation): 4
- Of the 49 trusted rows: `has_boy=1` in 23, `has_puppy=1` in 18, both in 3, neither in 7

Frame-level image descriptions come from the EventFormer neural-vocabulary annotation set (Shirazi lab, unpublished). The `has_boy` flag matches the regex `\b(boy|child|kid)\b` on the image description; `has_puppy` matches `\b(puppy|dog)\b`. These keyword rules are provisional; refine during planning if needed.

### Data-quality note

The stimulus-side shot boundaries in this TSV and the EventFormer shot boundaries were detected by different algorithms, so onsets can drift apart by several seconds in a small number of cases. The `match_diff_s` column records that gap. Rows with `match_diff_s > 1.0 s` have their `has_boy`/`has_puppy` flags already set to `n/a`; the 1.0 s threshold is a conservative cutoff because most shot durations are 1-5 s. If you relax the threshold during analysis, spot-check the affected rows against the original image descriptions before trusting them.

## Analysis Conditions

Three candidate contrasts; pick one during the planning session.

Counts below use the 49 trusted rows only (after the `match_diff_s > 1.0` invalidation).

1. **Boy-only vs Puppy-only:** `has_boy=1 AND has_puppy=0` (20 shots) vs `has_boy=0 AND has_puppy=1` (15 shots). Cleanest social-stimulus contrast.
2. **Puppy-present vs Puppy-absent:** `has_puppy=1` (18) vs `has_puppy=0` (31). Higher trial count per condition, confounded by scene content.
3. **Boy-present vs Puppy-present:** `has_boy=1` (23) vs `has_puppy=1` (18). Overlaps 3 shots; interpret with care.

LLR can be used as a regressor of no interest to absorb low-level luminance differences.

## Tools

- **EEGLAB** 2024+ with plugins: `Biosig`, `clean_rawdata`, `AMICA`, `IClabel`, `dipfit5`, `std_precomp` (ERSP)
- **matlab-mcp-tools** (https://github.com/neuromechanist/matlab-mcp-tools) so Claude Code drives MATLAB over MCP
- **Reference pipeline:** `~/Documents/git/HBN_BIDS_analysis/study_handy_scripts.m` contains a working study-level recipe for this dataset: `pop_importbids` -> high-pass 1 Hz -> `cleanline` (60/120/180 Hz) -> `clean_rawdata` (channel rejection only) -> AMICA (24-way parallel) -> `pop_dipfit_settings` + `pop_multifit` -> IClabel (brain threshold 0.69) -> `expand_events` with `shot_events.tsv` -> `pop_epoch` (-0.6 to 0.6 s around `shots`) -> `std_precomp` ERSP. Use this as a known-working starting point; do not copy verbatim. Re-derive each step with explicit parameter justification.

## Outputs Expected

- Group-level ERSP maps per condition on the 0-500 ms window, baseline-corrected against -500 to -100 ms
- Cluster-level statistics across occipital/temporal IC clusters
- A figure showing conditionwise ERSP difference at the cluster of maximal effect
- Saved STUDY with all intermediate stages (`_amica`, `_iclabel`, `_clustered`, `_epoched`) under a `derivatives/` subdirectory

## Initial Phase Sketch

This is a sketch only; the exact phase boundaries, tests, and success criteria should be negotiated in plan mode.

- **Phase 1 - Preprocess R3:** import BIDS, channel cleaning, cleanline, channel rejection. One MATLAB function per step, all callable from the command line. Deliverable: cleaned ALLEEG saved to `derivatives/preproc/`.
- **Phase 2 - AMICA + dipfit:** run AMICA per subject, save weights, attach to EEG sets, compute dipoles.
- **Phase 3 - IClabel and rejection:** classify components, drop non-brain, checkpoint.
- **Phase 4 - Shot events and epoching:** expand events from `shot_events.tsv`, epoch around shots, split by `has_boy`/`has_puppy`.
- **Phase 5 - ERSP precompute and clustering:** study-level ERSP, IC clustering.
- **Phase 6 - Statistics and figures:** group contrasts, plots, manuscript-ready figure.

Start with Phase 1. Each phase is a sub-issue, a worktree, a branch, and a PR.

## Constraints and Non-Goals

- R3-mini first; full R3 only after the pipeline is validated on the mini.
- Single movie (`ThePresent`); do not generalize to other movies in this project.
- No deep learning in Phase 1-6; this is a classical EEGLAB pipeline.
- No custom HED work in this project; use the events as-provided.
- No CI/CD this week; Week 4 adds pre-commit, linting, and GitHub Actions.

## References

- Shirazi et al., *HBN-EEG: A Curated Collection*, bioRxiv 2024. DOI: 10.1101/2024.10.03.615261
- Alexander et al., *The Healthy Brain Network*, Sci Data 2017. DOI: 10.1038/sdata.2017.181
- Delorme & Makeig, *EEGLAB*, J Neurosci Methods 2004.
- Palmer et al., *AMICA*, 2012.
- Pion-Tonachini et al., *ICLabel*, NeuroImage 2019.
