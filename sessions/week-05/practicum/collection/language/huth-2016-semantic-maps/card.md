---
slug: huth-2016-semantic-maps
type: paper
strand: language
year: 2016
authors: [Huth, de Heer, Griffiths, Theunissen, Gallant]
venue: Nature
doi: 10.1038/nature17637
url: https://www.nature.com/articles/nature17637
license: publisher-paywall
modalities: [fmri]
tags: [semantic-maps, narrative, encoding-model, naturalistic-listening, foundational]
relevance: high
imported_from: null
added: 2026-05-06

pdf_status: not-redistributable
pdf_path: null
md_path: source.md
md_quality: abstract-only
---

# Natural Speech Reveals the Semantic Maps That Tile Human Cerebral Cortex

## TL;DR

The high-water mark for naturalistic-listening encoding models: a continuous-valued semantic-feature space, fit voxel-wise on hours of story listening, produces interpretable cortical maps that tile most of the cortex. Anchors the language strand by showing that naturalistic stimuli are not noisier than controlled stimuli; given enough data, they are richer.

## Summary

Subjects in functional magnetic resonance imaging (fMRI) listened to ~2 hours of stories from "The Moth Radio Hour." The authors fit voxel-wise encoding models on a 985-dimensional semantic feature space (word co-occurrence statistics from a large text corpus), then interpreted the resulting weight maps. The maps tile cortex with semantically coherent regions, consistent across subjects after anatomical alignment, covering approximately one-third of cortex with above-baseline prediction performance. The paper is the methodological reference for "encoding models on naturalistic speech."

## Relevance

For the language strand, this is the target framework that EEG-language papers under naturalistic listening try to translate. Brennan et al. 2016 (also in this strand) translates parts of this methodology to EEG. The semantic-map framing also clarifies which signals the EEG strand can plausibly recover (slow envelope and low-dimensional semantic projections) and which it cannot (the full 985-dimensional space; signal-to-noise ratio is insufficient at scalp).

## Notable details

- Data: ~2 hours of story-listening fMRI per subject, 7 subjects.
- Feature space: 985-dim word-co-occurrence vectors, ridge-regression encoding.
- Output: voxel-wise weight maps interpreted as a continuous semantic atlas tiling roughly one-third of cortex.
- Methodologically central for the broader Gallant-lab encoding-model program (`pycortex`, `voxelwise_tutorials`, `himalaya`).

## Open questions

- Does not address whether the same maps emerge under multimodal naturalistic stimuli (movies with dialogue) versus pure listening.
- Pre-dates large language model embeddings; the feature space is hand-engineered word co-occurrence, not transformer embeddings.
- Does not extend to developmental cohorts; the cortical maps are adult-only.

## Citations

- Primary: `huth2016semanticmaps` in `language.bib`
- Related:
  - Lerner et al. 2011, hierarchy of timescales (`lerner2011timescales`)
  - Brennan et al. 2016, EEG narrative comprehension (`brennan2016narrativeeeg`)
  - de Heer et al. 2017, hierarchical processing of speech features (`deheer2017hierarchical`)
