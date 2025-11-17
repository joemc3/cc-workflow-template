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

4. **Say to Claude:** *"Initialize the project"*

   Claude will:
   - Read your PRD and TAD
   - Extract project details (name, platform, tech stack, features, etc.)
   - Configure CLAUDE.md with your project specifics
   - Rename this README to WORKFLOW.md (for developers)
   - Create a new project-specific README based on your specs
   - Commit everything to git
   - Ask: *"Ready to break down your PRD into tasks?"*

That's it! Your project is initialized and ready to start building.

---

## Migrating an Existing Project

**Already have a project?** You can apply this workflow to existing projects, even if you're already using GitHub issues or tracking work in docs.

See **[docs/MIGRATION.md](docs/MIGRATION.md)** for detailed guidance, or run:

```bash
/project-migrate
```

This interactive assistant will help you:
- Import existing GitHub issues into the workflow
- Extract tasks from documentation (CLAUDE.md, README, etc.)
- Create minimal PRD/TAD if you don't have formal specs
- Set up BEADS tracking for existing work
- Handle work in progress gracefully

**Common scenarios covered:**
- "We have GitHub issues but no BEADS"
- "Work is tracked in CLAUDE.md/README only"
- "Mix of issues and doc-based tracking"
- "No formal tracking at all"

The migration guide includes prompt templates you can use with Claude to automate the process.

---

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

## Example: Real-World Project Setup

Here's a real example from a Flutter mobile app project (this workflow works for **any** stack - web, backend, desktop, mobile, etc.):

### 1. Create Repository and Add Specifications

- Use this template to create a new repository
- Clone it locally
- Add your PRD, TAD, and specs to `docs/` as outlined in the README

### 2. Launch Claude Code and Initialize

Open Claude Code in your project directory, then:

```
You: "Initialize the project"
```

Claude reads your docs and configures everything automatically.

### 3. Generate Work Breakdown

Claude will ask: *"Ready to break down your PRD into tasks?"*

```
You: "Yes"
```

Claude creates all GitHub issues (epics + tasks) with proper dependencies.

### 4. Define Repository Structure

For multi-component projects (app, backend, infrastructure, etc.):

```
You: "I want the Flutter app in an 'app' folder (not the repo root). Same for
other components like Supabase. Create a repository structure spec in docs/specs
by analyzing the PRD, TAD, and other specs to figure out a clean directory
structure. Make sure CLAUDE.md knows about this spec for future sessions."
```

Claude generates the spec and ensures all future work follows it.

### 5. Create Expert Sub-Agents

For complex projects needing specialized expertise:

```
You: "Create a high-priority epic to analyze all our specs, epics, and tasks,
then determine what expert sub-agents we should create. We want to use specialized
agents wherever possible. Add tasks to create those sub-agents."
```

Claude identifies needed expertise (e.g., Flutter UI, Supabase backend, state management) and creates specialized agents.

### 6. Continue Setup or Start Building

From here, you can continue with project-specific setup or jump straight into development:

```
You: "Let's work on issue #5"
```

And you're building!

**Key Takeaway:** This exact workflow adapts to any tech stack - React, Python, Rust, mobile, microservices, etc. You define what you're building in your PRD/TAD, and the workflow handles the rest.

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
5. **Say:** *"Initialize the project"*

That's it! Claude will:
- Extract everything from your PRD and TAD
- Configure CLAUDE.md automatically
- This README becomes WORKFLOW.md
- A new project-specific README is created
- Ask: *"Ready to break down your PRD into tasks?"*

**Remember:** You write the specs, Claude does the rest. That's the whole idea.
