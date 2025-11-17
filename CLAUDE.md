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

All status tracked in BEADS + CCPM (GitHub Issues).

**Current epics:**
View with: `~/.local/bin/bd list --type epic` or `gh issue list --label epic`

**Check status:**
```bash
~/.local/bin/bd ready --limit 5           # Available work
~/.local/bin/bd list --status in_progress # Active work
~/.local/bin/bd blocked                   # Blocked tasks
~/.local/bin/bd stats                     # Statistics
gh pr list                                # Open pull requests
```

**GitHub Issues = Source of Truth**
- All epics tracked as GitHub issues
- Use `/pm:issue-start <number>` to begin work
- Feature branches created automatically
- BEADS tracks local state between sessions

## Session Start Protocol (AUTOMATIC)

**IMPORTANT: Run these steps AUTOMATICALLY at the start of EVERY session:**

1. Set PATH and sync:
   ```bash
   export PATH="$PATH:/Users/joemc3/.local/bin"
   git pull --rebase
   ~/.local/bin/bd sync
   ```

2. Show available work:
   ```bash
   ~/.local/bin/bd ready --limit 5
   ~/.local/bin/bd blocked
   ```

3. Load project context:
   ```bash
   /context:prime
   ```

4. Ask user: "Which issue would you like to work on?"
   - If GitHub issue number provided: `/pm:issue-start <number>` (creates feature branch + worktree)
   - If BEADS ID provided: `bd update <id> --status in_progress` and create feature branch manually

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
   - For each: `~/.local/bin/bd close <id> --reason "Description of what was done"`

2. **Ask about in-progress work:**
   - "Which issues are still in progress?"
   - For each: `~/.local/bin/bd update <id> --notes "Current state and next steps"`

3. **Sync BEADS to git:**
   ```bash
   ~/.local/bin/bd sync
   git add .beads/
   git commit -m "chore(session): update issue tracking

   Completed: [list completed issue IDs]
   In Progress: [list in-progress issue IDs]"
   git push
   ```

4. **Update GitHub issues (if working via CCPM):**
   - If issue was started with `/pm:issue-start <number>`:
     ```bash
     /pm:issue-sync <number>
     ```

5. **Ask about Pull Request:**
   - "Do you want to create a Pull Request? (yes/no)"
   - If yes:
     ```bash
     gh pr create --title "Title" --body "Description" --base main
     ```
   - If no: Feature branch remains for next session

6. **Show next work:**
   ```bash
   ~/.local/bin/bd ready --limit 3
   ```

7. **Summary:** Display what was accomplished, what's next, current branch

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

### Starting Work on a GitHub Issue

```bash
/pm:issue-start <number>
```

This command:
- Creates a feature branch (e.g., `feature/issue-123`)
- Creates a git worktree in `../epic-<name>/`
- Changes to that directory
- Loads issue context

**IMPORTANT:** All work should be done in the worktree, NOT on main branch.

### During Work

```bash
# Sync progress to GitHub (creates comment on issue)
/pm:issue-sync <number>

# Track locally in BEADS
~/.local/bin/bd update <beads-id> --notes "Progress update"
```

### Checking Status

```bash
/pm:status        # Overall project dashboard
/pm:standup       # Daily standup report
/pm:epic-show <epic-name>  # Epic details
/pm:next          # Next priority task
```

### Why This Workflow?

- **Feature branches prevent conflicts** - Multiple agents can work simultaneously
- **Worktrees isolate work** - No branch switching needed
- **GitHub issues provide visibility** - Team knows what's being worked on
- **BEADS provides agent memory** - Session-to-session continuity

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
# Most used BEADS commands
~/.local/bin/bd ready --limit 5           # Show available work
~/.local/bin/bd create "..." -t T -p N   # Create issue
~/.local/bin/bd update <id> --status S   # Update status
~/.local/bin/bd close <id> --reason "..." # Complete
~/.local/bin/bd show <id>                # View details
~/.local/bin/bd dep add <c> <p> --type T # Add dependency
~/.local/bin/bd stats                    # Statistics
~/.local/bin/bd list --status in_progress # What's being worked on

# Most used CCPM commands
/pm:issue-start <number>    # Start work (creates feature branch)
/pm:issue-sync <number>     # Sync progress to GitHub
/pm:status                  # Project dashboard
/pm:next                    # Next priority work
```

## Need Help?

- BEADS: `bd quickstart` or `bd --help`
- CCPM: `/pm:help`
- Specs: @docs/ directory
