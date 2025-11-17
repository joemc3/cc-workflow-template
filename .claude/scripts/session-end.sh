#!/bin/bash
set -e

echo "🛑 Ending Claude Code session..."

# Add bd to PATH
export PATH="$PATH:/Users/joemc3/.local/bin"

# 1. Prompt for issue cleanup
echo ""
echo "Issues to close? (space-separated IDs, or 'none')"
read -r close_issues
if [ "$close_issues" != "none" ]; then
  for id in $close_issues; do
    echo "Reason for closing $id?"
    read -r reason
    bd close "$id" --reason "$reason"
  done
fi

# 2. Sync BEADS
echo ""
echo "🔄 Syncing BEADS..."
bd sync

# 3. Commit changes
echo ""
echo "📝 Committing changes..."
if [ -f .beads/beads.jsonl ]; then
  git add .beads/beads.jsonl
  git commit -m "Session end: update issue tracking" || true
fi

# 4. Push to remote
echo ""
echo "📤 Pushing changes..."
git push

# 5. Show summary
echo ""
echo "📊 Session summary:"
bd stats

echo ""
echo "✅ Session ended cleanly!"
