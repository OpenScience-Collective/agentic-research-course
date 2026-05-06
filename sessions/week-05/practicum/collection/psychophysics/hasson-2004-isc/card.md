---
slug: hasson-2004-isc
type: paper
strand: psychophysics
year: 2004
authors: [Hasson, Nir, Levy, Fuhrmann, Malach]
venue: Science
doi: 10.1126/science.1089506
url: https://www.science.org/doi/10.1126/science.1089506
license: publisher-paywall
modalities: [fmri]
tags: [intersubject-correlation, naturalistic-viewing, free-viewing, isc, foundational]
relevance: high
imported_from: null
added: 2026-05-06

pdf_status: not-redistributable
pdf_path: null
md_path: source.md
md_quality: abstract-only
---

# Intersubject Synchronization of Cortical Activity During Natural Vision

## TL;DR

The foundational paper of the naturalistic-stimulus paradigm: shared cortical activity time-locks across viewers watching the same continuous movie, producing the intersubject correlation (ISC) measure that anchors essentially every subsequent paper in this strand.

## Summary

Hasson and colleagues showed in functional magnetic resonance imaging (fMRI) that watching the same long, complex movie clip produces tightly synchronised activity in extended cortical regions across viewers. The paper introduces the model-free framing where the stimulus itself drives the response, and ISC across viewers is the dependent variable, sidestepping any explicit feature regression. Roughly 30% of cortex showed significant ISC during free viewing; the proportion drops sharply for scrambled or unrelated stimuli, demonstrating that the synchronisation is stimulus-driven rather than incidental.

## Relevance

This is the strand's anchor citation. Every electroencephalography (EEG) paper that reports ISC under naturalistic viewing builds on the methodology and framing introduced here. The framework lets us treat naturalistic-viewing EEG signal as a stimulus-locked signal even without a stimulus model, which is the operational enabler for the rest of the perspectives (action, language, emotion) covered by the review.

## Notable details

- Stimulus: ~30 minutes of "The Good, the Bad, and the Ugly" plus other clips; presented to multiple viewers in identical order.
- Analysis: voxel-wise Pearson correlation of timeseries across pairs of viewers, averaged.
- Key number: ~30% of cortex showed significant ISC under naturalistic viewing.
- Limitation: fMRI temporal resolution. The methodology generalises to EEG, but with band- and component-specific reliability that the EEG cards in this strand should report.

## Open questions

- The paper does not address how ISC varies with age or developmental stage.
- It treats the stimulus as monolithic; subsequent work (Honey 2012, Lerner 2011) decomposes ISC across timescales.
- It does not separate sensory-driven from semantically-driven ISC; later work isolates the latter.

## Citations

- Primary: `hasson2004isc` in `psychophysics.bib`
- Related:
  - Honey et al. 2012, slow timescales of cortical processing (`honey2012timescales`)
  - Dmochowski et al. 2012, correlated components in EEG (`dmochowski2012eegcc`)
  - Hasson et al. 2008, neurocinematics (`hasson2008neurocinematics`, lives in the action strand)
  - Lerner et al. 2011, hierarchy of timescales (`lerner2011timescales`, lives in the language strand)
