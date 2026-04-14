# Week 2 Slide Plan

## Slide Inventory (Target: ~25-28 slides for 45 min)

### Opening (3-5 min)
1. **Title slide** - "Week 2: Setting Up Claude Code for Research" + author info
2. **Week 1 Recap** - Git = safety net, GitHub = collaboration layer, terminal = interface. Quick recap for 10x larger audience. Link to Week 1 recording.

### What Is Claude Code? (5 min)
3. **Section: Meet Claude Code** - Section divider with claude-face.svg icon
4. **Claude Code explained** - Agentic coding tool that reads, writes, runs, and iterates. Not autocomplete. Screenshot: init.png
5. **Claude ecosystem comparison** - Table: Claude Chat vs Claude Code vs Claude Cowork. What each does, who it's for.

### Interfaces (3 min)
6. **Where Claude Code Lives** - interfaces.svg icon, list: Terminal, VS Code, JetBrains, Desktop App, Web, plus third-party (Conductor). All share same engine.
7. **Interface screenshots** - Grid/two-column: vscode-claude.png, code-app.png, conductor.png

### Setup (5 min)
8. **Section: Getting Started** - Section divider
9. **Installation** - Three methods (native, Homebrew, WinGet). Commands shown. First run: `cd your-project && claude`
10. **Permission model** - permissions.svg icon. Default/Accept Edits/Plan/Auto modes. Shift+Tab to cycle.

### CLAUDE.md (8 min)
11. **Section: CLAUDE.md** - Section divider with claude-md.svg
12. **The most important file** - What it is: persistent instructions loaded every session. `/init` to generate.
13. **Scope hierarchy** - Diagram: Managed > Project > User > Local. Where each lives.
14. **What goes in, what stays out** - Two columns: include vs exclude. Official Anthropic guidance.
15. **`.claude/rules/`** - Path-scoped rules for large projects. Example YAML frontmatter.
16. **AGENTS.md** - Claude Code doesn't read it. Import pattern: `@AGENTS.md`

### Core Concepts (8 min)
17. **Section: Extending Claude Code** - Section divider with plugin-ecosystem.svg
18. **Concept map** - plugin-ecosystem.svg enlarged. Plugin > Skills, Hooks, Agents, MCP. Below: CLAUDE.md + Auto Memory.
19. **Skills** - What they are, `/skill-name`, bundled vs custom, when to use
20. **MCP** - External tool connectors. `claude mcp add`. Practicum: matlab-mcp-tools
21. **Hooks and Agents** - Hooks: automated actions at lifecycle points. Agents: isolated workers with own context. When to use each.

### Plan Mode & Commands (5 min)
22. **Plan Mode** - plan-mode.svg icon. Explore > Plan > Implement > Commit. Screenshot: plan.png
23. **Essential commands** - Table of top 10 commands. Keyboard shortcuts.

### Anthropic Best Practices (3 min)
24. **Three official rules** - 1. Give Claude verification, 2. Explore then plan then code, 3. Manage context aggressively

### Our Workflow (5 min)
25. **Section: Our Research Workflow** - Section divider
26. **The .context/ directory** - context-directory.svg. Four files and their purposes.
27. **research-skills plugin** - 7 domains mapping to course weeks. Install instructions.

### Pricing & Access (3 min)
28. **Pricing and discounts** - Plans table. Nonprofit discount ($8/seat). Education plans. Recommendation for PIs.

### Closing (2 min)
29. **Before next week** - Checklist: install Claude Code, create CLAUDE.md, try one AI task
30. **Resources** - Links to docs, research-skills repo, course Discord

---

## SVGs needed (created):
- [x] claude-face.svg (animated winking Claude)
- [x] claude-code.svg (terminal icon)
- [x] claude-md.svg (document icon)
- [x] plan-mode.svg (4-phase workflow)
- [x] plugin-ecosystem.svg (concept hierarchy)
- [x] context-directory.svg (.context/ folder)
- [x] interfaces.svg (hub-and-spoke)
- [x] permissions.svg (shield)

## Screenshots provided:
- [x] code-app.png (Claude Code Desktop)
- [x] conductor.png (Conductor app)
- [x] cowork.png (Claude Cowork)
- [x] init.png (/init output)
- [x] plan.png (plan mode)
- [x] vscode-claude.png (VS Code extension)
