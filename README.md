# Claude Code Workflow Template

**A production-ready template for managing software projects with Claude Code, BEADS, and CCPM**

This repository provides a complete, battle-tested workflow for managing software development projects using:
- **Claude Code** - AI-powered development assistant
- **BEADS** - Local issue tracking with git-backed persistence
- **CCPM** (Claude Code Project Management) - GitHub Issues integration and multi-agent coordination

## What This Gives You

**Simple, natural conversation with Claude Code:**

- *"Break down my PRD into tasks"* → Claude creates GitHub issues for all your work
- *"Let's work on authentication"* → Claude sets up the workspace and starts coding
- *"Show me what's done"* → Claude displays project status and progress
- *"I'm done for today"* → Claude saves everything and shows what's next

**Behind the scenes, this template handles:**

1. **Project tracking** - BEADS (local) + GitHub Issues (team visibility)
2. **Multi-agent coordination** - Multiple agents work in parallel without conflicts
3. **Session memory** - Claude remembers context between sessions
4. **Automatic workflows** - No manual git commands or issue tracking

**The result:** You focus on building, Claude handles the workflow.

## Quick Start

### Prerequisites

**Verify you have the required tools installed:**

1. **BEADS CLI** - Issue tracking tool
   ```bash
   bd --version
   ```
   If not installed: https://github.com/steveyegge/beads

2. **GitHub CLI** - GitHub integration
   ```bash
   gh auth status
   ```
   If not installed: `brew install gh` (macOS) then `gh auth login`

> **Note:** If `bd --version` works, BEADS is already in your PATH - you're good to go!

### Setup Your Project

1. **Use this template on GitHub:**
   - Click "Use this template" button on GitHub
   - Name your new project
   - Clone it locally

2. **Fill in your project specifications:**
   - `docs/PRD.md` - What you're building (product requirements)
   - `docs/TAD.md` - How you're building it (technical architecture)
   - `docs/specs/*.md` - Detailed component specs (optional to start)

   *Don't worry about being perfect - you can iterate with Claude!*

3. **Open Claude Code in the project directory**

   Claude will automatically detect this is a new project and say:

   > *"I can see you've filled in your PRD and TAD. Would you like me to initialize the project configuration automatically?"*

4. **Say "yes" and Claude will:**
   - Extract project details from your PRD and TAD
   - Configure CLAUDE.md with your project specifics
   - Rename this README to WORKFLOW.md (for developers)
   - Create a new project-specific README based on your specs
   - Commit everything to git
   - Ask: *"Ready to break down your PRD into tasks?"*

That's it! Your project is initialized and ready to start building.

## Project Structure

```
cc-workflow-template/
├── .claude/                           # CCPM configuration
│   ├── ccpm/                         # CCPM tool and scripts
│   ├── hooks/                        # Git hooks and session hooks
│   ├── scripts/                      # Helper scripts
│   ├── COMMANDS.md                   # Available slash commands
│   └── CHANGELOG.md                  # CCPM version history
├── .beads/                           # BEADS issue tracking database
│   ├── beads.db                      # SQLite database
│   ├── issues.jsonl                  # Git-tracked issue export
│   ├── config.yaml                   # BEADS configuration
│   └── metadata.json                 # Project metadata
├── docs/                             # Specification documents
│   ├── PRD.md                        # Product requirements (placeholder)
│   ├── TAD.md                        # Technical architecture (placeholder)
│   └── specs/                        # Component specifications
│       ├── spec-1.md                 # Placeholder spec
│       ├── spec-2.md                 # Placeholder spec
│       └── spec-3.md                 # Placeholder spec
├── CLAUDE.md                         # Claude Code agent instructions
└── README.md                         # This file
```

## How to Use This Workflow

### Your First Session

**You:** *"Break down my PRD into epics and tasks"*

**Claude:**
- Reads your PRD, TAD, and specs
- Creates GitHub issues for each epic and task
- Sets up dependencies
- Shows you the breakdown
- Asks: *"Which issue would you like to work on?"*

### Working on Features

**You:** *"Let's work on issue #2"*

**Claude:**
- Creates a feature branch for you
- Sets up an isolated workspace
- Updates issue status to "in progress"
- Posts to GitHub so others know you're working on it
- Starts implementing

### During Development

**What Claude does automatically:**
- Tracks progress in both BEADS (local) and GitHub (team visibility)
- Works in feature branches to avoid conflicts
- Periodically syncs status to GitHub
- Discovers and creates new tasks when finding bugs/TODOs

**What you can say:**
- *"Show me the project status"* - See what's done, what's in progress, what's next
- *"Create a PR for this work"* - When you're ready to merge
- *"What's blocking us?"* - See all blocked tasks
- *"What should we work on next?"* - Get priority recommendations

### Ending Your Session

**You:** *"I'm done for today"* or *"End session"*

**Claude:**
- Asks what you completed
- Asks what's still in progress
- Updates GitHub issues with progress comments
- Commits all tracking data to git
- Shows what's ready for next session

**Important:** Always say "done" or "end session" - don't just close the window! This ensures all your progress is saved.

### Multi-Agent / Team Collaboration

**For humans on your team:**
- Everything is visible on GitHub - no special tools needed
- See all epics and tasks as GitHub issues
- Progress updates posted as comments
- No BEADS knowledge required

**For multiple Claude agents:**
- Each works in isolated feature branches
- BEADS synced via git provides shared context
- No conflicts when working in parallel
- Easy handoffs between sessions

### That's It!

You talk to Claude in natural language. Claude handles all the commands, git operations, issue tracking, and status updates.

For technical details, see [CLAUDE.md](./CLAUDE.md).

## Customization Guide

### 1. Project Context (CLAUDE.md)

Replace placeholders in CLAUDE.md:
- `[YOUR_PROJECT]` - Your project name
- `[YOUR_PLATFORM]` - Technology platform
- `[YOUR_BACKEND]` - Backend technology
- `[YOUR_FRAMEWORK]` - Development framework
- `[YOUR_*_REQUIREMENTS]` - Technical constraints

### 2. Specifications (docs/)

Create your project documentation:
- **PRD** - What you're building and why
- **TAD** - How you're building it (architecture, tech decisions)
- **Specs** - Detailed component/feature specifications

The @-reference pattern in CLAUDE.md lets Claude load these docs on demand.

### 3. BEADS Configuration (.beads/config.yaml)

Customize BEADS settings:
- Default priority levels
- Label schemes
- Issue type workflows
- Sync behavior

### 4. Repository Settings

Update via GitHub settings or gh CLI:
```bash
gh repo edit --description "Your project description"
gh repo edit --homepage "https://your-project.com"
```

## Key Features

### Automatic Conflict Prevention

When you say *"Let's work on issue #2"*, Claude:
- Creates an isolated workspace (feature branch + worktree)
- No conflicts with other agents/developers working on different issues
- Each issue gets its own clean environment

### Session Memory

**Claude remembers between sessions:**
- What you were working on
- What's completed vs in-progress
- Dependencies between tasks
- Discovered work that needs to be done

**How it works:**
- BEADS database synced to git (local agent memory)
- GitHub issues (team visibility)
- Both stay in sync automatically

### Work Discovery

**You:** *"I found a bug while working on the login feature"*

**Claude:**
- Creates a new task for the bug
- Links it to current work (traceability)
- Adds to backlog or marks as blocker
- Syncs to GitHub for team visibility

### Priority Management

Claude understands priorities:
- **P0** - Critical, drop everything
- **P1** - High priority, core features
- **P2** - Normal work (default)
- **P3** - Low priority
- **P4** - Backlog

**You:** *"What's the highest priority work?"* → Claude shows P0/P1 tasks first

## Resources

- **BEADS Documentation:** https://github.com/steveyegge/beads
- **CCPM Documentation:** See `.claude/README.md` and `.claude/COMMANDS.md`
- **Claude Code:** https://claude.ai/code

## Best Practices

1. **Always end sessions properly** - Say *"done"* or *"end session"* instead of closing the window
2. **Fill in your specs** - Better specs = better Claude suggestions
3. **Iterate with Claude** - Don't worry about perfect specs upfront - refine as you go
4. **Trust the workflow** - Let Claude handle git, branches, and issue tracking
5. **Check status regularly** - Say *"show me project status"* to stay oriented

## Troubleshooting

### "I closed the window without ending the session!"

**No problem!** Next session, Claude will detect uncommitted work and ask what to do with it.

**You:** *"I accidentally closed without ending the session"*

**Claude:**
- Detects the incomplete session
- Shows what was in progress
- Asks if you want to continue or commit the work
- Recovers gracefully

### "Multiple agents seem to be working on the same thing"

**You:** *"What's everyone working on?"*

**Claude:**
- Shows all in-progress work
- Shows who's working on what (via GitHub)
- Helps you pick something that won't conflict

The feature branch workflow prevents actual conflicts, but this helps with coordination.

### "Things seem out of sync"

**You:** *"Can you sync everything?"*

**Claude:**
- Pulls latest changes
- Syncs BEADS with git
- Updates GitHub issue status
- Shows current state

## Contributing to This Template

Found improvements to the workflow? Submit a PR!

## License

MIT License - See LICENSE file for details

---

## Ready to Start?

1. **Install the prerequisites** (BEADS and GitHub CLI)
2. **Use this template** to create your project
3. **Fill in your specs** (docs/PRD.md, docs/TAD.md)
4. **Open Claude Code** in the project directory
5. **Claude auto-detects and asks:** *"Would you like me to initialize the project?"*
6. **Say "yes"** and Claude handles everything

That's it! Claude will:
- Configure the project from your specs
- This README becomes WORKFLOW.md
- A new project-specific README is created
- Ask: *"Ready to break down your PRD into tasks?"*

**Remember:** You write the specs, Claude does the rest. That's the whole idea.
