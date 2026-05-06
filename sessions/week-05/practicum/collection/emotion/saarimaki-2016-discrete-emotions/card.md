---
slug: saarimaki-2016-discrete-emotions
type: paper
strand: emotion
year: 2016
authors: [Saarimaki, Gotsopoulos, Jaaskelainen, Lampinen, Vuilleumier, Hari, Sams, Nummenmaa]
venue: Cerebral Cortex
doi: 10.1093/cercor/bhv086
url: https://academic.oup.com/cercor/article/26/6/2563/2510142
license: publisher-paywall
modalities: [fmri]
tags: [discrete-emotions, naturalistic-stimuli, classification, valence-arousal, foundational]
relevance: high
imported_from: null
added: 2026-05-06

pdf_status: not-redistributable
pdf_path: null
md_path: source.md
md_quality: abstract-only
---

# Discrete Neural Signatures of Basic Emotions

## TL;DR

Functional magnetic resonance imaging (fMRI) classification evidence that distinct, decodable activity patterns underlie six basic emotions (anger, fear, disgust, happiness, sadness, surprise) elicited by naturalistic stimuli. Anchors the emotion strand by establishing that emotional categories are not just dimensional valence-arousal projections; there is category-level neural structure recoverable from continuous viewing.

## Summary

Saarimaki and colleagues elicited basic emotions using emotionally evocative movies and narrated stories, then trained multivariate classifiers on the fMRI activation patterns. The classifiers discriminated all six basic emotions above chance, with the cortical patterns being relatively distributed (rather than localised to a single "emotion area") and partly overlapping across emotion categories. The discrete-emotion classification was robust across both stimulus modalities (movies and narrated stories), arguing for a representational layer above raw valence and arousal.

## Relevance

For the emotion strand, this paper licenses the project of decoding affect from naturalistic-viewing electroencephalography (EEG). It does the work of showing the discrete-emotion structure is real and recoverable; the strand's open question is then which fraction of that structure survives the loss of spatial resolution when moving from fMRI to EEG, and how the surviving signal behaves across age in developmental cohorts (Healthy Brain Network, HBN).

## Notable details

- Stimuli: movie clips and narrated stories per emotion category.
- Method: searchlight multivariate pattern analysis with cross-classification across stimulus modalities.
- Output: significant decoding for all six emotions; cortical patterns show partial overlap, not crisp localisation.
- Methodological reference for Kragel et al. 2019 follow-on work classifying emotions across naturalistic stimuli at scale.

## Open questions

- Movies and narrated stories are short clips, not continuous viewing; whether the same patterns hold over a 20-minute movie is open.
- No EEG translation; signal-to-noise ratio under naturalistic viewing for discrete-emotion decoding is unestablished.
- No developmental data; HBN-style cohorts are uncovered by this work.

## Citations

- Primary: `saarimaki2016discrete` in `emotion.bib`
- Related:
  - Nummenmaa et al. 2012, emotion synchronisation across viewers (`nummenmaa2012emotionsync`)
  - Kragel et al. 2019, emotion classifiers across naturalistic stimuli (`kragel2019classifiers`)
