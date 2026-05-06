# Paper-Card Schema

Each entry lives in its own folder under the strand:

```
collection/<strand>/<slug>/
├── card.md         this paper-card; required
├── source.pdf      full PDF; only when redistributable / open access
├── source.md       markdown extraction of the paper; always required
└── meta.json       provenance: source URL, retrieval date, license, hash
```

Rationale: we need offline-archival access to the underlying papers, not only summaries. Future synthesis and drafting must be able to re-read the primary text. This mirrors the schema used by [Annotation-Garden/management/research/collection](https://github.com/Annotation-Garden/management/tree/main/research/collection); the AGI corpus is the canonical reference.

## card.md template

```yaml
---
slug: <kebab-case-short-id>             # matches folder name
type: paper | dataset | tool | platform | standard
strand: psychophysics | action | language | emotion
year: <YYYY>
authors: [<surname1>, <surname2>, ...]
venue: <journal / conference / org>
doi: <doi or null>
url: <canonical url or null>
license: <license or null>
modalities: [eeg, ieeg, fmri, meg, eyetrack, behavior, ...]
tags: [<5-12 short tags>]
relevance: high | medium | low
imported_from: <relative path or null>
added: <YYYY-MM-DD>

# Archival fields
pdf_status: archived | not-redistributable | not-available | not-applicable
pdf_path: source.pdf | null
md_path: source.md | null
md_quality: clean | rough | partial | abstract-only
---
```

### Calibration anchors for `relevance`

To keep the field useful for downstream filtering, apply the following anchors. If more than ~40% of entries land in `high`, the field has lost discriminative power; recalibrate.

- **high**: the entry directly anchors a strand's main claim. Example: an EEG study that defines the standard analysis for the strand's perspective on naturalistic viewing.
- **medium**: standard work in the strand's scope but not the strand's anchor. Example: an fMRI study on the same perspective whose findings need EEG translation.
- **low**: tangential or background context. Example: a non-naturalistic-stimulus paper cited only to motivate why naturalistic stimuli matter.

### Required sections in `card.md` (after the front-matter)

1. **TL;DR** -- one or two sentences. Capture the *thesis*, do not duplicate the Summary opening.
2. **Summary** -- 3-6 sentences covering core contribution, method, scope, key numbers.
3. **Relevance** -- concrete connection to the strand's perspective. Cite specific mechanisms (band, network, paradigm). Avoid generic prose.
4. **Notable details** -- bullet list of facts worth pulling forward to synthesis.
5. **Open questions / limitations** -- what this work does not answer. Paper-specific only; generic boilerplate is harmful because synthesis depends on this.
6. **Citations** -- primary BibTeX key plus up to 5 related works as one-liners.

## meta.json template

```json
{
  "doi": "10.xxxx/xxxxx",
  "source_url": "https://...",
  "retrieved_at": "2026-05-06",
  "pdf_sha256": "<sha256 hex if archived; null otherwise>",
  "pdf_license": "<see vocabulary below>",
  "redistribution_ok": true,
  "notes": "<retrieval notes, e.g. 'arxiv preprint used; published version paywalled'>"
}
```

### pdf_license vocabulary

- `CC-BY`, `CC-BY-2.0`, `CC-BY-3.0`, `CC-BY-4.0`, `CC-BY-NC`, `CC0`
- `preprint-cc-arxiv`, `preprint-cc-biorxiv`, `preprint-cc-osf`
- `author-accepted-manuscript` (institutional repository copy)
- `publisher-paywall`
- `not-applicable` (e.g. tool with only a README)
- `unknown`

`redistribution_ok` is the single source of truth for whether `source.pdf` may exist in the repo. Any `*-paywall` value implies `redistribution_ok: false` and no `source.pdf` file in the entry folder.

## Storage rules

- **Open-access PDFs** (CC-BY, CC0, arXiv, bioRxiv, OSF, institutional repository copies): commit directly under `source.pdf` and populate `pdf_sha256`.
- **Paywalled / non-redistributable**: do NOT commit the PDF. Set `pdf_status: not-redistributable`, `pdf_path: null`, `pdf_sha256: null`. Still commit `source.md` (extracted text is generally fair use for research notes; flag in `notes` if uncertain).
- **Datasets / tools without a paper**: set `pdf_status: not-applicable`. Store the project README or canonical landing page as `source.md`.
- **Failed downloads**: set `pdf_status: not-available`. Document the failure mode in `meta.json` notes (Cloudflare gate, reCAPTCHA, broken DOI, etc.).

## Tooling

Use the `/opencite:opencite` skill (preferred; it drives the workflow with judgement) or the `opencite` CLI directly:

```bash
# Resolve DOI / canonical URL
uvx opencite lookup "10.xxxx/xxxxx" -f json

# Download PDF and convert to markdown in one step
uvx opencite pdf "10.xxxx/xxxxx" -o ./collection/<strand>/<slug>/source.pdf --convert

# Append BibTeX
uvx opencite lookup "10.xxxx/xxxxx" -f bibtex --append-bib ./collection/<strand>/<strand>.bib
```

For batch retrieval across an entire strand:

```bash
uvx opencite search "<query>" --max 20 -f json -o results.json
uvx opencite batch-fetch --from-json results.json --convert -o ./papers --summary report.json
```

The `papers/` output then maps into the per-entry `collection/<strand>/<slug>/` structure manually or via a small script.
