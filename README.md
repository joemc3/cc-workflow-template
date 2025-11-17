# Claude Code Workflow Template

**A production-ready template for managing software projects with Claude Code, BEADS, and CCPM**

This repository provides a complete, battle-tested workflow for managing software development projects using:
- **Claude Code** - AI-powered development assistant
- **BEADS** - Local issue tracking with git-backed persistence
- **CCPM** (Claude Code Project Management) - GitHub Issues integration and multi-agent coordination

## What This Template Provides

### 1. Session Management Protocols
- **Automatic session start** - Syncs state, shows available work, loads context
- **Automatic session end** - Captures progress, syncs issues, commits tracking data
- **Recovery from interruptions** - Handles improper session endings gracefully

### 2. Issue Tracking Integration
- **BEADS** for local, git-backed issue tracking
- **GitHub Issues** as source of truth for team visibility
- **Bi-directional sync** between BEADS and GitHub
- **Dependency tracking** and work discovery patterns

### 3. Multi-Agent Coordination
- **Feature branch workflow** with git worktrees
- **Isolation** - Multiple agents work simultaneously without conflicts
- **Clear handoffs** - Issue status and progress always visible

### 4. Specification-Driven Development
- **Placeholder docs** ready for your project specs (PRD, TAD, component specs)
- **@-reference pattern** - Claude can load specific sections on demand
- **Traceability** - All work traces back to requirements

## Quick Start

### Prerequisites

1. **Install BEADS CLI:**
   ```bash
   # Follow installation instructions at:
   # https://github.com/steveyegge/beads

   # Verify installation
   ~/.local/bin/bd --version
   ```

2. **Install GitHub CLI:**
   ```bash
   # macOS
   brew install gh

   # Verify and authenticate
   gh auth login
   ```

3. **Add BEADS to PATH** (add to `~/.zshrc` or `~/.bashrc`):
   ```bash
   export PATH="$PATH:$HOME/.local/bin"
   ```

### Setup Your Project

1. **Clone this template:**
   ```bash
   git clone https://github.com/[YOUR_USERNAME]/cc-workflow-template.git my-project
   cd my-project
   ```

2. **Customize for your project:**
   ```bash
   # Update repository settings
   gh repo edit --name my-project-name

   # Customize CLAUDE.md
   # - Replace [YOUR_PROJECT] with your project name
   # - Fill in platform, backend, target audience
   # - Update development guidelines

   # Create your specification documents
   # - docs/PRD.md - Product requirements
   # - docs/TAD.md - Technical architecture
   # - docs/specs/ - Component specifications
   ```

3. **Initialize BEADS** (if needed):
   ```bash
   ~/.local/bin/bd init
   ```

4. **Start your first Claude Code session:**
   Open Claude Code in this directory and the session start protocol will run automatically.

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

### Daily Workflow

**Every session starts automatically with:**
1. Sync latest code and issue state
2. Show available work
3. Check for blockers
4. Ask which issue to work on

**During work:**
- Issues tracked locally in BEADS
- Synced to GitHub for team visibility
- Work happens in feature branches (via worktrees)
- Progress captured at milestones

**Every session ends with:**
1. Capture completed work
2. Update in-progress status
3. Sync BEADS to git
4. Optional PR creation
5. Preview next work

### Common Commands

**BEADS (Issue Tracking):**
```bash
~/.local/bin/bd ready --limit 5           # Show available work
~/.local/bin/bd create "Title" -t TYPE -p PRIORITY -l "labels"
~/.local/bin/bd update <id> --status STATUS
~/.local/bin/bd close <id> --reason "Done"
~/.local/bin/bd show <id>                 # View details
~/.local/bin/bd stats                     # Statistics
```

**CCPM (GitHub Integration):**
```bash
/pm:issue-start <number>    # Start work on GitHub issue (creates feature branch)
/pm:issue-sync <number>     # Sync progress to GitHub
/pm:status                  # Project dashboard
/pm:next                    # Next priority work
```

**Session Management:**
```bash
/context:prime              # Load project context
```

See [CLAUDE.md](./CLAUDE.md) for complete command reference and workflow details.

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

## Key Workflow Features

### Feature Branch + Worktree Workflow

When starting work on a GitHub issue:
```bash
/pm:issue-start <number>
```

This creates:
1. Feature branch: `feature/issue-<number>`
2. Git worktree in: `../epic-<name>/`
3. Isolated workspace for that feature

Multiple agents can work simultaneously without conflicts.

### Session Protocols

**Session Start** (Automatic):
- Pulls latest git changes
- Syncs BEADS database
- Shows ready work and blockers
- Loads project context

**Session End** (Say "done" or "end session"):
- Captures completed/in-progress work
- Syncs BEADS to git
- Commits tracking updates
- Optionally creates PR

### Issue Discovery

When finding bugs or follow-up work during development:
```bash
~/.local/bin/bd create "Found issue" -t bug -p 2
~/.local/bin/bd dep add <new-id> <current-id> --type discovered-from
```

Maintains traceability of all discovered work.

## Advanced Features

### Priority Levels
- **P0** - Critical, drop everything
- **P1** - High priority, core features
- **P2** - Normal work (default)
- **P3** - Low priority
- **P4** - Backlog

### Dependency Types
- `blocks` - Hard blocker (must complete first)
- `parent-child` - Hierarchical relationship
- `discovered-from` - Found during work
- `related` - Soft connection

### Commit Message Format
```
type(scope): description

fixes bd-xyz
closes #123
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`

## Resources

- **BEADS Documentation:** https://github.com/steveyegge/beads
- **CCPM Documentation:** See `.claude/README.md` and `.claude/COMMANDS.md`
- **Claude Code:** https://claude.ai/code

## Best Practices

1. **Never skip session end protocol** - Say "done" instead of closing window
2. **Work in feature branches** - Use `/pm:issue-start` for GitHub issues
3. **Update issue status** - Keep BEADS in sync with actual progress
4. **Reference issues in commits** - Use `fixes bd-xyz` or `closes #123`
5. **Document as you go** - Update specs when requirements change
6. **Sync regularly** - Push BEADS changes so other agents see progress

## Troubleshooting

**Session interrupted without proper end?**
```bash
git status  # See uncommitted changes
~/.local/bin/bd list --status in_progress  # See active work
# Commit changes and sync BEADS manually
```

**BEADS and GitHub out of sync?**
```bash
~/.local/bin/bd sync
/pm:issue-sync <number>
```

**Multiple agents conflicting?**
- Check open PRs: `gh pr list`
- Check active work: `~/.local/bin/bd list --status in_progress`
- Use feature branches to isolate work

## Contributing to This Template

Found improvements to the workflow? Submit a PR!

## License

MIT License - See LICENSE file for details

---

**Ready to start?** Customize CLAUDE.md and docs/, then open Claude Code to begin your first session!
