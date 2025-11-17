# Claude Code Instructions - [YOUR_PROJECT]

## Project Overview

**[Replace with your project description]**

**Platform:** [YOUR_PLATFORM - e.g., Web, Mobile, Desktop]
**Backend:** [YOUR_BACKEND - e.g., Supabase, Firebase, PostgreSQL]
**Target:** [YOUR_TARGET_AUDIENCE or key requirements]

## Specifications

Key documents:
- PRD: @docs/PRD.md
- TAD: @docs/TAD.md
- Spec 1: @docs/specs/spec-1.md
- Spec 2: @docs/specs/spec-2.md
- Spec 3: @docs/specs/spec-3.md

Load sections with @ references as needed during implementation.

## Project Tracking

**Hybrid tracking system for maximum visibility:**

- **GitHub Issues** - Epics AND major tasks (visible to all)
- **BEADS** - Rich metadata, dependencies, agent memory (synced to git)

### Tracking Model

```
GitHub Issue #1 (Epic: Authentication)
  ├─ GitHub Issue #2 (Task: DB Schema) ←→ BEADS bd-a1b2
  ├─ GitHub Issue #3 (Task: Signup API) ←→ BEADS bd-c3d4
  └─ GitHub Issue #4 (Task: Login API) ←→ BEADS bd-e5f6
```

**Why this works:**
- ✅ Humans see everything on GitHub (no BEADS knowledge needed)
- ✅ Agents get rich dependency tracking via BEADS
- ✅ Multiple agents can work in parallel (separate feature branches)
- ✅ Easy handoff between agents/humans (GitHub has all context)

**Check status:**
```bash
# For humans (GitHub visibility)
gh issue list --label epic                # All epics
gh issue list --label task                # All tasks
gh pr list                                # Open pull requests

# For agents (BEADS tracking)
~/.local/bin/bd ready --limit 5           # Available work
~/.local/bin/bd list --status in_progress # Active work
~/.local/bin/bd blocked                   # Blocked tasks
~/.local/bin/bd stats                     # Statistics

# Dashboard view (combines both)
/pm:dashboard                             # Full project status
```

## Session Start Protocol (AUTOMATIC)

**IMPORTANT: Run these steps AUTOMATICALLY at the start of EVERY session:**

### Step 0: Project Initialization (First Time Only)

**If user says "Initialize the project" or similar:**
- Run `/project:init` command (see slash commands section)
- This only needs to happen once per project
- After initialization, skip to Step 1 for all future sessions

**If this is a new, uninitialized project:**
- User will say "Initialize the project" when ready
- Wait for user instruction before initializing

**If project is already initialized:**
- Continue with normal session start below (Steps 1-4)

---

### Step 1: Set PATH and Sync

```bash
export PATH="$PATH:/Users/joemc3/.local/bin"
git pull --rebase
~/.local/bin/bd sync
```

### Step 2: Show Available Work

```bash
~/.local/bin/bd ready --limit 5
~/.local/bin/bd blocked
```

### Step 3: Load Project Context

```bash
/context:prime
```

### Step 4: Ask User What to Work On

**Ask:** "Which issue would you like to work on?"

- If GitHub issue number provided: `/pm:issue-start <number>` (creates feature branch + worktree)
- If BEADS ID provided: `bd update <id> --status in_progress` and create feature branch manually
- If user says "break down the PRD": Run `/pm:epic-breakdown`

## During Development

**ALWAYS work in the feature branch/worktree created by `/pm:issue-start`**

```bash
# Update status locally
~/.local/bin/bd update <id> --notes "Progress update"

# Sync to GitHub periodically (every milestone or significant progress)
/pm:issue-sync <github-issue-number>

# Create discovered work (bugs, follow-up tasks found during development)
~/.local/bin/bd create "Found issue" -t bug/task -p 0-4 -l "labels"
~/.local/bin/bd dep add <new-id> <current-id> --type discovered-from

# Check dependencies
~/.local/bin/bd dep tree <id>

# View what other agents are working on (to avoid conflicts)
~/.local/bin/bd list --status in_progress
gh pr list  # Check open PRs
```

## Session End Protocol (AUTOMATIC)

**⚠️ CRITICAL: This only runs when user explicitly says "done", "end session", "stop", etc.**
**Ctrl-C / Ctrl-D / Closing window will NOT trigger this protocol!**

**IMPORTANT: Run these steps AUTOMATICALLY at the end of EVERY session (when user says "end session", "done", "stop", etc.):**

**Before starting, remind user:** "Ending session - running cleanup protocol..."

1. **Ask about completed work:**
   - "Which issues were completed in this session?"
   - For each completed issue:
     ```bash
     # Update BEADS
     ~/.local/bin/bd close <beads-id> --reason "Description of what was done"

     # Update GitHub issue (close with completion comment)
     gh issue close <github-number> --comment "✅ Completed

     [Summary of what was done]
     [Files changed]
     [Next steps or related issues]

     Completed in commit/branch: [details]"
     ```

2. **Ask about in-progress work:**
   - "Which issues are still in progress?"
   - For each in-progress issue:
     ```bash
     # Update BEADS
     ~/.local/bin/bd update <beads-id> --notes "Current state and next steps"

     # Update GitHub issue (add progress comment)
     gh issue comment <github-number> --body "**Progress Update:**

     [What was done this session]
     [Current state]
     [What's left to do]
     [Any blockers discovered]"
     ```

3. **Sync BEADS to git:**
   ```bash
   ~/.local/bin/bd sync
   git add .beads/
   git commit -m "chore(session): update issue tracking

   Completed: [list completed issue IDs and GitHub #s]
   In Progress: [list in-progress issue IDs and GitHub #s]"
   git push
   ```

4. **Ask about Pull Request:**
   - "Do you want to create a Pull Request? (yes/no)"
   - If yes:
     ```bash
     gh pr create \
       --title "feat/fix(scope): description" \
       --body "## Summary
       [Brief description]

       ## Part of
       Epic #N: [Epic name]
       Closes #M

       ## Test Plan
       - [ ] [Test item 1]
       - [ ] [Test item 2]

       🤖 Generated with [Claude Code](https://claude.com/claude-code)" \
       --base main
     ```
   - If no: Feature branch remains for next session

5. **Show next work:**
   ```bash
   ~/.local/bin/bd ready --limit 3
   ```

6. **Session Summary:** Display:
   - ✅ Completed issues (BEADS IDs + GitHub #s)
   - 📝 In-progress issues
   - 🔀 Pull requests created
   - 🎯 Next available work
   - 📊 Epic progress percentage
   - 🌿 Current branch status

## Recovery from Improper Session End

**If user accidentally closed without running session end protocol:**

Next session start will detect uncommitted work:
```bash
git status  # Shows uncommitted changes
~/.local/bin/bd list --status in_progress  # Shows what was being worked on
```

**Recovery steps:**
1. Review uncommitted changes: `git diff`
2. Commit work: `git add . && git commit -m "..."`
3. Update BEADS: `~/.local/bin/bd update <id> --notes "Session interrupted, recovered"`
4. Sync: `~/.local/bin/bd sync && git add .beads/ && git commit && git push`
5. Continue or close issue as appropriate

**Best Practice:** Always say "done" or "end session" - never just close the window!

## CCPM Integration

**Preferred Workflow:** Use GitHub issues as source of truth

### Breaking Down Epics (Automated)

When you ask Claude to break down an epic from your PRD/TAD:

```bash
# Claude runs this automatically:
/pm:epic-breakdown
```

This command will:
1. Read your PRD/TAD/specs
2. Identify major features (epics)
3. Create GitHub issue for the epic (labeled `epic`)
4. Create GitHub issues for each task (labeled `task`)
5. Create corresponding BEADS entries
6. Set up dependencies between tasks
7. Commit everything to git
8. Show you the breakdown for approval

**Result:** Epic + tasks visible on GitHub, tracked in BEADS, ready to work on.

### Starting Work on a GitHub Issue

```bash
/pm:issue-start <number>
```

This command:
- Creates a feature branch (e.g., `feature/issue-123`)
- Creates a git worktree in `../issue-<number>-<name>/`
- Changes to that directory
- Updates BEADS status to `in_progress`
- Loads issue context

**IMPORTANT:** All work should be done in the worktree, NOT on main branch.

### During Work

```bash
# Sync progress to GitHub (creates comment on issue)
/pm:issue-sync <number>

# Track locally in BEADS
~/.local/bin/bd update <beads-id> --notes "Progress update"

# Create new tasks discovered during work
/pm:task-create "Fix bug in auth validation" --parent <epic-number> --priority 1
```

### Checking Status

```bash
/pm:dashboard     # Full project dashboard (epics, tasks, progress)
/pm:status        # Overall project status
/pm:next          # Next priority task to work on
```

### Why This Workflow?

- **Feature branches prevent conflicts** - Multiple agents can work simultaneously
- **Worktrees isolate work** - No branch switching needed
- **GitHub issues provide visibility** - Team knows what's being worked on (no BEADS needed)
- **BEADS provides agent memory** - Session-to-session continuity with rich metadata
- **Automatic syncing** - Progress automatically posted to GitHub for human visibility

## Priority Levels

- **P0** (0): Critical, drop everything
- **P1** (1): High priority, core features
- **P2** (2): Normal work (default)
- **P3** (3): Low priority
- **P4** (4): Backlog

## Dependency Types

- `blocks`: Hard blocker
- `parent-child`: Hierarchical
- `discovered-from`: Found during work
- `related`: Soft connection

## Work Discovery

When finding bugs/TODOs during work:
1. Create issue: `bd create "..." -t TYPE -p N`
2. Link: `bd dep add <new> <current> --type discovered-from`
3. Continue current work (unless blocker)

## Development Guidelines

**Framework:** [YOUR_FRAMEWORK - e.g., React, Flutter, Django]
**Testing:** [YOUR_TESTING_STRATEGY - e.g., Unit tests, integration tests, E2E]
**Code Style:** [YOUR_CODE_STYLE - e.g., ESLint, Prettier, Black]
**Accessibility:** [YOUR_ACCESSIBILITY_REQUIREMENTS]

### Key Technical Constraints
- [YOUR_PERFORMANCE_REQUIREMENTS]
- [YOUR_SCALABILITY_REQUIREMENTS]
- [YOUR_SECURITY_REQUIREMENTS]
- [YOUR_COMPLIANCE_REQUIREMENTS]

### Commit Message Format
```
type(scope): description

fixes bd-xyz
closes #123
```

Types: feat, fix, refactor, test, docs, chore

## Issue References in Commits

Always reference issues:
- `fixes bd-a1b2` - Closes BEADS issue
- `closes #123` - Closes GitHub issue
- `ref bd-xyz` - References BEADS issue

## Quick Command Reference

**Note:** BEADS CLI is at `~/.local/bin/bd` - use full path in all commands

```bash
# Project Setup (Run Once)
/project:init                             # Initialize project from PRD/TAD (auto-detected)

# Epic & Task Management (CCPM Slash Commands)
/pm:epic-breakdown                        # Break down PRD into epics & tasks (auto)
/pm:task-create "..." --parent N --priority P  # Create new task
/pm:issue-start <number>                  # Start work (creates feature branch)
/pm:issue-sync <number>                   # Sync progress to GitHub
/pm:dashboard                             # Full project dashboard
/pm:status                                # Project status summary
/pm:next                                  # Next priority task

# Context Loading
/context:prime                            # Load project context (PRD/TAD/specs)

# BEADS Commands (for advanced usage)
~/.local/bin/bd ready --limit 5           # Show available work
~/.local/bin/bd create "..." -t T -p N   # Create issue
~/.local/bin/bd update <id> --status S   # Update status
~/.local/bin/bd close <id> --reason "..." # Complete
~/.local/bin/bd show <id>                # View details
~/.local/bin/bd dep add <c> <p> --type T # Add dependency
~/.local/bin/bd stats                    # Statistics
~/.local/bin/bd list --status in_progress # What's being worked on
~/.local/bin/bd sync                     # Sync with git

# GitHub Commands (if needed manually)
gh issue list --label epic               # List all epics
gh issue list --label task               # List all tasks
gh pr list                               # List open pull requests
gh issue view <number>                   # View issue details
```

## Need Help?

- BEADS: `bd quickstart` or `bd --help`
- CCPM: `/pm:help`
- Specs: @docs/ directory
