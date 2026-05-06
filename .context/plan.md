# Agentic Research Course -- Development Plan

## Project Overview
**Goal:** Deliver a 10-week live course on AI-powered research workflows, with a hands-on practicum analyzing HBN EEG data for movie shot-change events using EEGLAB + matlab-mcp.
**Timeline:** April-June 2026 (10 weekly sessions)
**Deliverables:** Session content, presentations, exercises, practicum codebase, blog posts/guidelines

## Work Plan -- Weeks 1-5 (Expanded)

### Week 1: Git, GitHub, and the Command Line + Landscape Overview
- [x] Session README with learning objectives
- [ ] Expand README with detailed objectives and landscape overview
- [x] Create presentation outline (presentations/week-01/)
- [x] Create presentation slides (presentations/week-01/presentation.json)
- [ ] Prepare live demo: init repo, first commit, push to GitHub
- [ ] Create exercises.md with post-session practice
- [x] Blog post: step-by-step setup guide (blog/week-01-setup-guide.md)
- [x] Slide-running instructions (presentations/README.md)

### Week 2: Setting Up Claude Code for Research
- [x] Session README with learning objectives
- [ ] Expand README with detailed objectives
- [ ] Create presentation outline (presentations/week-02/)
- [ ] Prepare live demo: install Claude Code, create CLAUDE.md, first AI-assisted task
- [ ] Create exercises.md
- [ ] Begin practicum: set up HBN analysis project with CLAUDE.md

### Week 3: Project Management with AI
- [x] Session README with learning objectives
- [x] Expand README with detailed objectives (tied to HBN practicum)
- [x] Create presentation outline (presentations/week-03/outline.md, 15-slide cap)
- [x] Create slide plan (presentations/week-03/slide-plan.md)
- [x] Practicum starter: sessions/week-03/practicum/project_brief.md (HBN R3 "The Present" boy vs puppy ERSP)
- [x] Practicum starter: sessions/week-03/practicum/shot_events.tsv (56 shots, has_boy/has_puppy/LLR/match_diff_s)
- [x] Create presentation.json (15 slides, FHD-tested)
- [x] Create SVG assets: problem-definition, epic-phases, epic-branching, worktree, review-pr
- [x] Week 3 blog post (blog/week-03-project-management.md)
- [x] Mirror to osc-docs (courses/agentic-research/week-03.md + slides bundle)
- [x] Update mkdocs nav and index.md to link Week 3
- [ ] Delete existing agentic-research-practicum GitHub repo for a clean init during live session
- [ ] Dry-run the live walkthrough (init -> push private -> epic -> `/plan` -> Phase 1)
- [ ] Create exercises.md
- [ ] Upload Week 3 recording to YouTube and embed in osc-docs week-03.md

### Week 4: CI/CD and Code Quality
- [x] Session README
- [x] Create presentation outline (presentations/week-04/outline.md, 23-slide cap)
- [x] Create slide plan (presentations/week-04/slide-plan.md)
- [ ] Create SVG assets (ci-loop, yaml-anatomy, triggers, tooling-old-vs-new, uv-speed, pre-commit-flow, pipeline-stages, matlab-ci, security-shield, setup-ci-tree)
- [ ] Create presentation.json (23 slides, FHD-tested)
- [ ] Capture screenshots (ci-pr-checks, ci-failed-typo, coverage-report)
- [ ] Dry-run live walkthrough (/project:setup-ci on practicum)
- [ ] Week 4 blog post (blog/week-04-cicd.md)
- [ ] Mirror blog to osc-docs (courses/agentic-research/week-04.md)
- [ ] Mirror slides bundle to osc-docs (courses/slides/agentic-research/week-04/)
- [ ] Update osc-docs mkdocs nav and index.md to link Week 4
- [ ] Upload Week 4 recording to YouTube and embed in osc-docs week-04.md

### Week 5: Literature Search and Review
- [x] Session README (initial)
- [x] Expand README with full objectives, the 5-stage pipeline, and AGI case-study reference
- [x] Create presentation outline (presentations/week-05/outline.md)
- [x] Create slide plan (presentations/week-05/slide-plan.md, 20-slide cap)
- [x] Create SVG assets (lit-review-pipeline, failure-modes, strand-fanout, strand-brief-anatomy, opencite-strategies, opencite-output-tree, paper-card-anatomy, calibration-anchors, synthesis-artifacts, cite-the-card, review-boomerang, three-defences, agi-case-callout) -- 13 SVGs + 4 codex PNGs
- [x] Create presentation.json (20 slides, fragment animations on bullets/code, FHD-tested)
- [x] Practicum scaffold: sessions/week-05/practicum/ -- 4 perspective strands (psychophysics, action, language, emotion); 4 anchor cards (Hasson 2004, Hasson 2008, Huth 2016, Saarimaki 2016); INDEX.md + .bib per strand; synthesis stub; direction-paper draft stub; seed-cards-todo.md
- [ ] Capture screenshots (opencite-search-output, batch-fetch-tree, paper-card-rendered, paper-review-feedback)
- [ ] Dry-run live walkthrough (add 1 paper via opencite -> manuscript-writing weave -> paper-review boomerang)
- [ ] Create exercises.md
- [x] Week 5 blog post (blog/week-05-literature-review.md)
- [x] Mirror blog to osc-docs (courses/agentic-research/week-05.md)
- [x] Mirror slides bundle to osc-docs (courses/slides/agentic-research/week-05/) -- presentation.html + week-05.json (paths rewritten ./assets/icons/) + 17 icon files
- [x] Update osc-docs index.md to link Week 5 (mkdocs uses awesome-pages auto-discovery; no nav edit needed)
- [ ] Upload Week 5 recording to YouTube and embed in osc-docs week-05.md

## Session Prep Checklist (per week)
- [ ] README.md finalized with objectives, outline, key concepts
- [ ] Presentation materials in presentations/week-NN/
- [ ] Live demo scripted and tested
- [ ] exercises.md created (optional)
- [ ] references.md created (optional)

## Success Criteria
- [ ] Weeks 1-3 fully expanded with detailed learning objectives
- [ ] Presentation outlines for weeks 1-3
- [ ] Practicum project scaffolded (HBN analysis with matlab-mcp)
- [ ] All 10 session READMEs have basic content
- [ ] Course blog post published (neuromechanist.github.io)

## Notes
- Presentation happening soon; prioritize weeks 1-3 content
- Blog post already published at neuromechanist.github.io/blog/010-agentic-research-workflows/
- Course companion: research-skills plugin (free, open source)
