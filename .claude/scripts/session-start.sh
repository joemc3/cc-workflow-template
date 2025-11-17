#!/bin/bash
set -e

echo "🚀 Starting Claude Code session..."

# Add bd to PATH
export PATH="$PATH:/Users/joemc3/.local/bin"

# 1. Pull latest from git
echo "📥 Pulling latest changes..."
git pull --rebase

# 2. Import latest issues
echo "🔄 Syncing BEADS..."
bd sync

# 3. Show ready work
echo ""
echo "📋 Ready work:"
bd ready --limit 5

# 4. Show blockers
echo ""
echo "🚫 Blocked issues:"
bd blocked

# 5. Show project context
echo ""
echo "📚 To load context, run: /context:prime"

echo ""
echo "✅ Session ready!"
