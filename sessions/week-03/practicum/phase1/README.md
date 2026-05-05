# Phase 1: BIDS Import and Preprocessing

Part of the HBN ERSP practicum (see `../project_brief.md`).

## What this phase does

Imports the HBN R3-mini BIDS dataset and runs four preprocessing steps, producing one cleaned EEG set per subject in `derivatives/preproc/`.

| Step | Function | Operation |
|------|----------|-----------|
| 1 | `p1_import_bids` | `pop_importbids` -- loads BIDS, attaches channel locations and events |
| 2 | `p1_highpass` | `pop_eegfiltnew` -- 1 Hz FIR highpass to remove DC drift |
| 3 | `p1_cleanline` | `pop_cleanline` -- removes 60/120/180 Hz line noise |
| 4 | `p1_channel_reject` | `clean_rawdata` -- drops flat/noisy channels (ASR off) |

## Prerequisites

- EEGLAB 2024+ on MATLAB path
- Plugins: `Biosig`, `CleanLine`, `clean_rawdata` (ships with EEGLAB 2024)
- matlab-mcp-tools configured if driving from Claude Code
- R3-mini data downloaded to `~/data/HBN/R3-mini` (or update `config/cfg_r3mini.m`)

## Running

**Interactive (MATLAB command window):**
```matlab
addpath(genpath('sessions/week-03/practicum'));
run_phase1('r3mini');
```

**Command line (from repo root):**
```bash
matlab -nodisplay -nosplash \
  -r "addpath(genpath('sessions/week-03/practicum')); run_phase1('r3mini'); exit"
```

## Configuration

Edit `config/cfg_r3mini.m` to set:
- `cfg.bids_root` -- path to your local R3-mini copy
- `cfg.subjects` -- list specific subject IDs or leave `{}` for all found

## Outputs

```
derivatives/
└── preproc/
    ├── <subject>_preproc.set   (one per subject, not committed to git)
    └── phase1_report.mat       (channel retention counts, committed if small)
```

`derivatives/` is listed in `.gitignore`. Data files are never committed.

## Acceptance criteria (closes #11)

- [ ] `run_phase1('r3mini')` completes without error on R3-mini
- [ ] All subjects retain >80% of channels (warning printed otherwise)
- [ ] `phase1_report.mat` saved with per-subject channel counts
- [ ] No data files committed to git

## Deviations from reference pipeline

The reference (`study_handy_scripts.m`) runs highpass before CleanLine. This order is preserved here. The reference uses `clean_rawdata` with default ASR settings; this pipeline disables ASR (`BurstCriterion = 'off'`) because ASR modifies the continuous signal in ways that can bias ICA decomposition (Phase 2). Channel-level rejection only.
