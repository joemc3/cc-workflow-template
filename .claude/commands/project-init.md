---
description: Initialize project configuration from PRD and TAD (auto-run on first session)
---

# Project Initialization

Initialize the project by extracting information from your PRD and TAD, updating configuration files, and setting up project-specific documentation.

## Prerequisites

Before running this command, ensure:
- `docs/PRD.md` is filled in (not placeholder content)
- `docs/TAD.md` is filled in (not placeholder content)

## Your Task

### 1. Read Project Documentation

Load and read:
```
@docs/PRD.md
@docs/TAD.md
@docs/specs/*.md (if any exist)
```

### 2. Extract Project Information

From the documents, intelligently extract:

**From PRD:**
- **Project name** (from title, heading, or introduction)
- **Description** (from overview, goals, or summary)
- **Target audience** (from user personas or target users section)
- **Key features** (from features or requirements section)
- **Success criteria** (from goals or objectives)
- **Performance requirements** (if mentioned)
- **Security requirements** (if mentioned)
- **Compliance requirements** (if mentioned)

**From TAD:**
- **Platform** (Web, Mobile, Desktop, etc.)
- **Frontend framework** (React, Flutter, Vue, etc.)
- **Backend technology** (Supabase, Firebase, Node.js, Django, etc.)
- **Database** (PostgreSQL, MongoDB, etc.)
- **Testing strategy** (Unit tests, E2E, integration, etc.)
- **Code style/tooling** (ESLint, Prettier, Black, etc.)
- **Accessibility requirements** (WCAG, ARIA, etc.)
- **Scalability requirements** (if mentioned)
- **Architecture overview** (high-level description)

**Smart Extraction Tips:**
- Be flexible with document structure - look for information in various sections
- If explicit labels aren't used, infer from content
- Handle variations (e.g., "React.js", "React", "ReactJS" all mean React)
- If something isn't specified, use "TBD" or a sensible default
- Extract exact wording when possible for accuracy

### 3. Update CLAUDE.md

Replace all placeholders in CLAUDE.md:

```markdown
# Claude Code Instructions - TaskMaster

## Project Overview

**A collaborative task management platform for remote teams**

**Platform:** Web
**Backend:** Supabase (PostgreSQL + Auth + Realtime)
**Target:** Remote teams managing complex projects

## Development Guidelines

**Framework:** React with TypeScript
**Testing:** Jest unit tests, Cypress E2E tests
**Code Style:** ESLint + Prettier (Airbnb config)
**Accessibility:** WCAG 2.1 AA compliance

### Key Technical Constraints
- Performance: Sub-200ms API response times
- Scalability: Support 10,000+ concurrent users
- Security: SOC 2 compliance required
- Compliance: GDPR and CCPA compliant data handling
```

Use `Edit` tool to replace the placeholder sections with extracted information.

### 4. Reorganize Documentation

**Rename current README:**
```bash
git mv README.md WORKFLOW.md
```

**Create new project README.md:**

Generate a new README.md with this structure:

```markdown
# [Project Name]

[Brief description from PRD]

## Overview

[Expanded description from PRD overview/goals]

## Features

- [Feature 1 from PRD]
- [Feature 2 from PRD]
- [Feature 3 from PRD]
- [Feature 4 from PRD]

## Tech Stack

**Platform:** [Platform from TAD]

**Frontend:**
- [Framework] - [Brief why/what from TAD]
- [Key libraries]

**Backend:**
- [Backend tech] - [Brief why/what from TAD]
- [Database]

**Infrastructure:**
- [Hosting/deployment info from TAD if available]

## Architecture

[High-level architecture summary from TAD]

[If TAD has architecture diagrams or detailed sections, reference them:
"See [Technical Architecture Document](docs/TAD.md) for detailed architecture."]

## Getting Started

### Prerequisites

- [List from TAD: Node.js version, tools, etc.]

### Installation

```bash
# Steps extracted from TAD or sensible defaults
git clone [repo-url]
cd [project-name]
npm install  # or yarn, pnpm, etc. based on TAD
```

### Development

```bash
# Start dev server
npm run dev

# Run tests
npm test
```

See [WORKFLOW.md](WORKFLOW.md) for detailed development workflow and Claude Code integration.

## Project Status

**Current Progress:** Setting up project infrastructure

View detailed status: [GitHub Issues](../../issues)

## Documentation

- **[Product Requirements (PRD)](docs/PRD.md)** - What we're building and why
- **[Technical Architecture (TAD)](docs/TAD.md)** - How we're building it
- **[Development Workflow](WORKFLOW.md)** - Claude Code workflow and project management
- **[Component Specifications](docs/specs/)** - Detailed component specs

## Development Workflow

This project uses [Claude Code](https://claude.com/claude-code) with automated project management via BEADS + GitHub Issues.

**Quick start for developers:**
1. See [WORKFLOW.md](WORKFLOW.md) for complete setup
2. Install BEADS and GitHub CLI
3. Open Claude Code in project directory
4. Say: "Show me what to work on"

## Contributing

[If PRD/TAD mention contribution guidelines, include them. Otherwise:]

See [WORKFLOW.md](WORKFLOW.md) for development practices and contribution workflow.

## License

[If specified in PRD/TAD, otherwise: MIT License]

---

🤖 This project uses [Claude Code](https://claude.com/claude-code) for AI-assisted development with automated issue tracking and project management.

**Setup Date:** [Current date]
**Last Updated:** [Current date]
```

Use the `Write` tool to create this new README.md with all extracted information filled in.

### 5. Validate Extraction

Before committing, show the user:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
         PROJECT INITIALIZATION COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Extracted Information:

Project Name:    TaskMaster
Description:     Collaborative task management platform for remote teams
Platform:        Web
Frontend:        React with TypeScript
Backend:         Supabase (PostgreSQL)
Database:        PostgreSQL
Target:          Remote teams

Features Extracted:
  ✓ 5 key features from PRD
  ✓ Architecture overview from TAD
  ✓ Tech stack details from TAD

Files Updated:
  ✓ CLAUDE.md - All placeholders replaced
  ✓ README.md → WORKFLOW.md (renamed)
  ✓ README.md - New project README created

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Does this look correct? (yes/no)
```

### 6. Commit Changes

If user confirms, commit:

```bash
git add CLAUDE.md WORKFLOW.md README.md
git commit -m "chore: initialize project configuration

Extracted project details from PRD and TAD:
- Project: [name]
- Platform: [platform]
- Stack: [framework] + [backend]

Updated:
- CLAUDE.md with project-specific configuration
- README.md → WORKFLOW.md (development workflow docs)
- Created new README.md with project overview

Project is now initialized and ready for development."

git push
```

### 7. Show Next Steps

```
✅ Project initialized successfully!

Next steps:
1. Review and refine docs/PRD.md if needed
2. Review and refine docs/TAD.md if needed
3. Ask me to: "Break down the PRD into epics and tasks"
4. Start building!

Ready to break down the PRD into actionable work items?
```

## Error Handling

### PRD/TAD Not Filled In

If docs still contain placeholder text:

```
⚠️  PRD and TAD contain placeholder content

I need you to fill these in first:
- docs/PRD.md - Your product requirements
- docs/TAD.md - Your technical architecture

Would you like help creating these documents? I can:
1. Interview you and create the PRD
2. Help design the architecture (TAD)
3. Skip for now and initialize manually later

What would you prefer?
```

### Extraction Confidence Low

If unable to extract clear information:

```
⚠️  Some information couldn't be extracted confidently

I found:
  ✓ Project name: [name]
  ✓ Platform: [platform]
  ⚠️  Backend: Unclear (mentions both Firebase and Supabase)
  ⚠️  Testing strategy: Not specified

Would you like to:
1. Let me make best guesses and you can edit CLAUDE.md later
2. Clarify the TAD sections I'm unsure about
3. Review each extraction for accuracy

What would you prefer?
```

### Already Initialized

If CLAUDE.md doesn't contain `[YOUR_PROJECT]`:

```
ℹ️  Project appears to be already initialized

Project: [current project name]
Platform: [current platform]

Do you want to:
1. Re-initialize (will overwrite current CLAUDE.md settings)
2. Update specific sections only
3. Cancel
```

## Integration with Session Start

This command should be offered automatically during session start if:
- CLAUDE.md contains `[YOUR_PROJECT]` (not initialized)
- docs/PRD.md exists and has content (not placeholder)
- docs/TAD.md exists and has content (not placeholder)

The session start protocol will detect this and say:

```
👋 Welcome! I notice this is a new project.

I can see you've filled in your PRD and TAD.
Would you like me to initialize the project configuration automatically?

This will:
- Extract project details from your documents
- Update CLAUDE.md with your project specifics
- Create a project-specific README
- Set up the development workflow

Initialize now? (yes/no)
```

Now extract the project information and initialize the configuration!
