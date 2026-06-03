# Week 9 Guide: Neuroinformatics -- Standards, Sharing, and Credit

*A finished analysis is not a finished contribution. The data behind it has to be reproducible, shareable, and citable, or the work dies with the paper. Two standards carry the weight: the Brain Imaging Data Structure (BIDS) answers where everything lives (structure), and Hierarchical Event Descriptors (HED) answer what every event meant (semantics). The single most useful idea this week: the bar for a complete annotation is concrete and falsifiable. **A language model should be able to reconstruct the stimulus, or the experiment, from the annotation alone.** That is not a metaphor; it is exactly the test demonstrated in the HBN-EEG paper (Shirazi et al., 2024, Figure 9), where Claude Sonnet 3.5 regenerated the Surround Suppression stimulus from its HED description with no image. The `neuroinformatics` plugin gets data to that bar; HEDit automates the hardest leg (natural language to validated HED); and `nemar-cli` ships it with rich, ORCID-linked DataCite metadata, the part OpenNeuro still leaves blank.*

This guide accompanies [Week 9](../sessions/week-09/) of the Agentic Research Course by the [Open Science Collective](https://osc.earth). It builds directly on Week 8 (figures), where a language model regenerated a stimulus figure from its HED annotation; this week that same trick becomes the standard of annotation completeness. The dataset throughout is HBN-EEG, the very data the course has analyzed since Week 3 ("The Present" movie). It is itself a BIDS + HED dataset published on both OpenNeuro and NEMAR with exactly the tools this session teaches: the loop closes, the data you analyzed is the worked example for how to share data.

> **Scope note.** Week 9 is about *standardizing and sharing* data you already have. The `neuroinformatics` plugin also ships an `experiment-design` skill (PsychoPy + Lab Streaming Layer, the data-*collection* side); that is in the plugin and the README, but not the focus of this session.

---

## The Reuse-and-Credit Gap

A lab collects dense, synchronized data. What reaches re-users is a thin `events.tsv` with one cryptic column and a results figure locked in a folder. Three locks snap shut at once:

- **Structure** -- where is everything? Custom folder layouts mean every re-user writes glue code before they can start.
- **Semantics** -- what did the events mean? A numeric event code is meaningless outside the lab.
- **Credit** -- who is cited when the data is reused? Without a DOI and author identifiers, reuse traces back to no one.

The phrase from the HBN-EEG paper is the target: a dataset is "analysis-ready" when re-users need **no forensic search for unreported details**. The information is not lost; it just never reaches the shared artifact. BIDS, HED, and good sharing are what close the three locks.

---

## Two Standards, One Bar

**BIDS answers where; HED answers what.** The bar that judges both is the same: someone, or a language model, can reconstruct your experiment without emailing you.

- **BIDS (Brain Imaging Data Structure)** -- a filesystem convention plus metadata. *Structure.*
- **HED (Hierarchical Event Descriptors)** -- a controlled, composable, validatable event vocabulary. *Semantics.*

Plant the bar early; it pays off when we hit Figure 9.

---

## BIDS: the Structure Standard

BIDS is a filesystem convention plus metadata: predictable names (`sub-`, `ses-`, `task-`), JSON sidecars, and TSV tables, with a top-level `dataset_description.json` and `participants.tsv`.

```text
ds00XXXX/                                   (dataset root)
├── dataset_description.json                (name, BIDSVersion, authors, license)
├── participants.tsv                        (age, sex, p-factor ...)
├── README
└── sub-NDARAB1234/
    └── eeg/
        ├── sub-..._task-surroundSupp_eeg.set       (signals)
        ├── sub-..._task-surroundSupp_eeg.json      (sidecar)
        ├── sub-..._task-surroundSupp_channels.tsv  (name, type, units)
        ├── sub-..._task-surroundSupp_events.tsv    (onset, duration, value)
        └── sub-..._task-surroundSupp_events.json   (HED annotations)
```

**Why BIDS is worth it: one layout, every tool.** A BIDS dataset is readable by EEGLAB, MNE-Python, the BIDS validator, and BIDS Apps, and it is the upload format both OpenNeuro and NEMAR expect. Standard structure is also what makes mega-analysis across studies possible. The payoff is leverage, not bureaucracy.

### Where structure ends

The JSON sidecar carries acquisition metadata; `events.tsv` carries the timeline.

```json
{
  "TaskName": "surroundSupp",
  "SamplingFrequency": 500,
  "EEGReference": "Cz",
  "PowerLineFrequency": 60,
  "EEGChannelCount": 128
}
```

```text
onset    duration   value
0.000    n/a        12
1.500    n/a        14
3.000    n/a        12
```

Structure tells you **where** an event sits on the timeline. It cannot tell you **what** the event was. That gap is semantics, and it is HED's job.

---

## HED: the Semantics Standard

`events.tsv` is thin: an onset and a cryptic numeric code. Stimulus content, modality, condition, participant response, trial context -- all real, all recorded, none of it in the shared file. (HBN originally shipped numeric event codes; the first curation step was replacing them with meaningful strings, then annotating with HED.)

HED is the fix. One tag is a comma-separated path through a controlled schema; the hierarchy carries meaning, so analysis works at any level:

```text
Action, Move, Move-body-part, Move-upper-extremity, Press
```

You can analyze at the leaf (`Press`) or at any ancestor (`Move`). Tags compose, take typed values with units, and validate against the official schema, so a tag means the same thing across labs. The sidecar pattern keeps `events.tsv` unchanged; all semantics live in `events.json` under HED keys, so existing analyses keep working.

The HBN-EEG paper states three objectives for HED: build event context; create machine-readable and human-understandable annotation for mega-analysis and machine learning; and task transparency and reproducibility.

### The bar: recreate the stimulus

Here is the test made concrete. In the HBN-EEG paper, the HED annotation of the Surround Suppression task was handed to Claude Sonnet 3.5 with **no image** -- and the model regenerated the visual stimulus from the annotation alone.

Everything structural came back correct: the gratings, the vertical-grating background, the central fixation point, the contrast relationship, four foreground disks present. The **only** miss was the disks' **size and position** -- both are awkward to express in HED, so they were left out of the annotation, and the model had no way to reproduce them.

That miss is the proof the test is honest, and a real lesson: HED nails event semantics, but spatial geometry (size, position) is hard to encode. The rule that falls out:

> If a language model can rebuild your stimulus from the annotation alone, the annotation is complete. If it can't, you left something out.

The same trick drew several of the paper's figures (a callback to Week 8). Cite: Shirazi et al. (2024), *HBN-EEG: The FAIR implementation of the Healthy Brain Network EEG dataset*, bioRxiv [10.1101/2024.10.03.615261](https://doi.org/10.1101/2024.10.03.615261).

---

## HEDit: AI-assisted HED

HED workflows stall for most labs, and it is a workflow problem, not a willingness problem: roughly 2000 tags, expert-only fluency, a validator with cryptic messages. Adoption stays inside the labs that build the schema.

[HEDit](https://github.com/Annotation-Garden/HEDit) turns the wall into a paragraph. You write one rich prose description per event value; HEDit runs a Parser to Tagger to Validator pipeline (a LangGraph multi-agent system with the official HED validator in the loop) and returns a BIDS-compliant `events.json` with HED tags plus a provenance trail.

- **Parser** -- natural language to structured facts (action, body-part, direction, magnitude, unit)
- **Tagger** -- retrieve HED nodes (retrieval over the schema) and compose the tag string
- **Validator** -- the official HED validator: does the tag exist, are units valid, is the value slot well-formed? On failure, the error feeds back to the Tagger.

The schema is the contract; no agent invents vocabulary. And HEDit is only as good as the description: it is tuned for exactly the detail the recreate-the-stimulus bar demands. Garbage in, garbage out.

---

## The neuroinformatics Plugin: 2 Skills + 1 Agent

The plugin packages the BIDS workflow for Claude Code.

- **`/neuroinformatics:bids-conversion`** -- a guided conversion to BIDS.
- **`bids-validator`** (agent) -- autonomous validation and fixes. This week's mechanical defence.
- **`/neuroinformatics:experiment-design`** -- the data-collection side (PsychoPy + Lab Streaming Layer); in the plugin, not today's focus.

HED annotation is woven into the skills rather than exposed as a separate command.

### /neuroinformatics:bids-conversion

A guided six-step workflow that ends where the next act begins, validation:

1. **Inventory source data** -- formats, subjects, channels
2. **Scaffold** -- `dataset_description.json`, `participants.tsv`, the directory tree
3. **Convert files** -- BrainVision, EEGLAB `.set`, EDF, BDF
4. **JSON sidecars** -- `SamplingFrequency`, `EEGReference`, channel counts
5. **TSV tables** -- `channels`, `events`, `electrodes`, `coordsystem`
6. **Validate** -- the BIDS validator

Modalities: EEG, EMG, MEG, fMRI, and behavioral data.

### The bids-validator agent: the mechanical defence

The agent locates the dataset, runs the BIDS validator, categorizes findings (errors must-fix, warnings should-fix, info optional), applies fixes with confirmation, re-validates, and reports readiness for OpenNeuro/NEMAR.

```text
## BIDS Validation Report
Subjects: 12   Modalities: eeg
Errors fixed: 3
  [FIXED] missing dataset_description.json
  [FIXED] _eeg.json missing PowerLineFrequency -> 60
Remaining warnings: 2
Ready for submission: YES
```

This is Week 9's equivalent of `cite-the-card` (Week 5) and `validate_fonts.py` (Week 8): a deterministic gate that turns "looks fine" into pass/fail. Note the division of labour, the agent fixes your data **locally**; `nemar-cli` validates again **at the upload gate**.

---

## Sharing and Credit

### OpenNeuro

[OpenNeuro](https://openneuro.org) is the de-facto open BIDS archive: validated on ingest, public, DOI-minted, the default home for shared neuro data and a genuinely great resource. Two honest caveats that motivate what follows: private upload *is* possible, but only via the command line / direct push (there is no polished GUI for it), and the DOI record stays sparse -- no ORCID author links, minimal metadata.

### NEMAR

[NEMAR](https://nemar.org) (the Neuroelectromagnetic Data Archive and Tools Resource) specializes in EEG/MEG BIDS datasets and sits next to San Diego Supercomputer Center compute, so you can analyze without downloading. HBN-EEG lives on both OpenNeuro and NEMAR, which is exactly what lets us compare their DOI records head to head.

### nemar-cli: validation is trivial

```bash
nemar dataset validate ./my-dataset
```

It wraps the official BIDS validator (Deno), and it also runs automatically on upload and on every update pull request. No separate toolchain to install or configure.

### nemar-cli: upload to publish, and the collaboration model

```bash
nemar auth login                              # one-time, token cached
nemar dataset validate ./my-dataset           # BIDS check, must pass
nemar dataset upload ./my-dataset             # creates a private GitHub repo
nemar dataset publish request nm000XXX        # admin approves -> public + DOI
```

The model is what matters: `upload` creates a **private GitHub repository where you are the admin**. You invite collaborators and push directly to it while you stage. After publishing, changes go through pull requests and version tags. (OpenNeuro also supports private upload, just command-line only, so the NEMAR advantage is this collaboration model plus the rich DOI metadata below, not "private vs public.")

### DOI minting + ORCID auto-link

On publish, `nemar-cli` mints a **concept DOI** (one stable citation across all versions) plus per-version DOIs, via EZID writing DataCite kernel-4 metadata, and **auto-links every author's ORCID iD** in that metadata. The dataset then appears on each author's ORCID record automatically, with no manual "add work." OpenNeuro does not link authors to ORCID on the DOI yet.

---

## The Metadata Gap: Proof on a Real Dataset

This is not a claim; it is live DataCite data on the audience's own dataset. The same HBN-EEG Release 1, the same eight authors, two homes:

| DataCite field | NEMAR `nm000103` | OpenNeuro `ds005505` |
|---|---|---|
| DOI | `10.82901/NEMAR.nm000103` (concept) | `10.18112/openneuro.ds005505.v1.0.1` (version-only) |
| Stable concept DOI | yes | no |
| **Authors linked to ORCID iD** | **8 / 8** | **0 / 8** |
| License | CC-BY-NC-SA-4.0 | none |
| Subject keywords | 8 | 0 |
| Description / abstract | yes | none |
| Links to papers + related datasets | 5 | 0 |
| Funding references | 2 | 0 |

OpenNeuro's DOI record carries only a title and author names; everything else is blank. NEMAR fills every field. **Findability (the F in FAIR) and credit are metadata the platform writes, not luck.** (Source: `api.datacite.org`, live records.)

---

## Live Walkthrough

Two small, honest actions, about four minutes total:

1. **HEDit** -- write one rich prose description of an HBN event and watch it become a validated HED string. The recreate-the-stimulus bar in miniature: the richer the description, the better the tag.
2. **`nemar dataset validate`** -- run it on the HBN practicum dataset and read the clean BIDS report.

If validation surfaces something, we walk it. We do not manufacture a pass.

---

## Common Pitfalls

- **Treating filenames as metadata.** A re-user learning the condition from `sub-003_ses-02_task-pullwalk_events.tsv` is reading a string, not a machine-queryable field. Put it in the sidecar.
- **Shipping numeric event codes.** Replace them with meaningful strings, then annotate with HED.
- **Stopping at BIDS.** Structure without semantics still leaves the events undecodable. HED is the second half.
- **Skipping validation.** The `bids-validator` agent fixes locally; `nemar dataset validate` checks at the gate. Both, by design.
- **Assuming a DOI means credit.** A DOI with no ORCID author identifiers does not propagate to anyone's ORCID record. Check the DataCite metadata, not just that a DOI exists.

---

## Before Next Week

- Install [`research-skills`](https://github.com/neuromechanist/research-skills) if you have not; it bundles `neuroinformatics`, `figures`, `manuscript`, `opencite`, `grant`, `project`, and `presentation`.
- If you have a small EEG/EMG dataset, try `/neuroinformatics:bids-conversion` on it and run the `bids-validator` agent.
- Browse HBN-EEG on [NEMAR](https://nemar.org) and [OpenNeuro](https://openneuro.org); compare the two DOI records on [DataCite](https://commons.datacite.org).
- Optional: try [HEDit](https://github.com/Annotation-Garden/HEDit) on one event from your own experiment, written as a rich paragraph.

Week 10 is the capstone: building your own plugin. This week was the last research-workflow plugin of the course; next you make one.
