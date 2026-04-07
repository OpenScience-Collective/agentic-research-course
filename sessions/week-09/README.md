# Week 9: Neuroinformatics -- Data Standards and Experiments

## Learning Objectives

By the end of this session, you will:
- Convert EEG/EMG data to BIDS format with proper metadata
- Create JSON sidecars, channels.tsv, events.tsv, and participants.tsv
- Validate BIDS datasets and fix common errors
- Design PsychoPy experiments with proper timing
- Integrate Lab Streaming Layer (LSL) markers for synchronization

## Outline

### Part 1: BIDS Format (15 min)
- Why BIDS: reproducibility, sharing (OpenNeuro/NEMAR), tooling
- Directory structure and file naming conventions
- Required vs recommended metadata fields
- Using `/convert-bids` for guided conversion
- Modality-specific notes: EEG, EMG

### Part 2: BIDS Validation (10 min)
- Running the bids-validator
- Common errors and fixes (missing sidecars, wrong names, encoding)
- Using `/validate-bids` for automated diagnosis and repair
- Preparing datasets for OpenNeuro/NEMAR submission

### Part 3: Experiment Design with PsychoPy (15 min)
- Trial structure: fixation, stimulus, response, ITI
- Block vs event-related vs mixed designs
- Frame-based timing (why not time-based)
- Using `/design-experiment` to scaffold an experiment
- BIDS-compatible output from experiments

### Part 4: LSL Integration (5 min)
- Sending markers from PsychoPy via LSL
- Marker naming schemes
- HED annotation for standardized event description
- Synchronization between devices

### Q&A (15 min)

## Key Concepts

- **BIDS:** Brain Imaging Data Structure; a standard for organizing neuroimaging data
- **JSON sidecar:** Metadata file accompanying each data file (sampling rate, channels, etc.)
- **PsychoPy:** Python-based experiment design software
- **LSL:** Lab Streaming Layer; unified system for streaming time-series data and markers
- **HED:** Hierarchical Event Descriptors; standardized vocabulary for describing events

## Before Next Session

- If you have EEG/EMG data, try converting a small dataset to BIDS
- Install PsychoPy: `uv add psychopy` (or use the standalone installer)
