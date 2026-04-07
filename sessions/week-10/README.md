# Week 10: Building Your Own Plugins and Workflows

## Learning Objectives

By the end of this session, you will:
- Understand the Claude Code plugin architecture
- Create a custom skill that encodes your domain knowledge
- Build an agent that runs autonomously
- Add slash commands to your plugin
- Share your plugin with your lab or community

## Outline

### Part 1: Plugin Architecture (10 min)
- Plugins, skills, agents, commands, hooks
- The `plugin.json` manifest
- Progressive disclosure: SKILL.md -> references/ -> examples/
- Trigger descriptions: how Claude knows when to use your skill

### Part 2: Creating a Skill (15 min)
- SKILL.md structure: frontmatter, workflow steps, references
- Writing effective trigger descriptions
- Encoding domain knowledge (not just instructions)
- When to use skills vs agents vs commands

### Part 3: Building an Agent (10 min)
- Agent frontmatter: name, description, model, tools, color
- Autonomous vs interactive agents
- Tool selection: what does the agent need?
- Testing and iterating on agent behavior

### Part 4: Publishing and Sharing (10 min)
- Plugin structure for distribution
- Marketplace manifests
- Installing plugins via CLI: `claude plugin install`
- Versioning: when to bump

### Q&A (15 min)

## Key Concepts

- **Skill:** Reusable knowledge template loaded when triggered by keywords
- **Agent:** Autonomous subagent that runs independently with specific tools
- **Command:** User-invoked `/slash-command` with defined arguments
- **Hook:** Event-driven automation (PreToolUse, PostToolUse, Stop)
- **Plugin:** The package containing skills, agents, commands, and hooks

## After the Course

- Continue building and refining your plugins
- Share with the OSC community on Discord
- Contribute to the research-skills marketplace
- Help others get started with AI-powered research workflows
