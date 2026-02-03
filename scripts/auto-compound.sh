#!/bin/bash
# scripts/auto-compound.sh  
# Runs nightly after daily-review to pick and implement the top priority

set -e

cd /home/clawdbot/clawd

LOG_FILE="logs/auto-compound-$(date +%Y-%m-%d).log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=== Auto-Compound Started: $(date) ==="

# Fetch latest (including tonight's review updates)
git fetch origin main 2>/dev/null || true
git checkout main 2>/dev/null || true
git pull origin main 2>/dev/null || true

# Check if priorities file exists
if [ ! -f "tasks/priorities.md" ]; then
    echo "No priorities.md found. Nothing to do."
    exit 0
fi

# Run the implementation via Claude
claude -p "
You are doing your nightly auto-compound implementation run.

1. Read tasks/priorities.md
2. Identify the #1 priority item (the first item under 'Active Priorities')
3. If there's no active priority, log that and exit
4. Read all relevant AGENTS.md, MEMORY.md, and context files to understand the codebase/project
5. Implement the priority item:
   - Create a feature branch if appropriate
   - Do the actual work (write code, create files, etc.)
   - Test what you can
   - Commit your changes with clear commit messages
6. Update tasks/priorities.md:
   - Move the completed item to the 'Done' section with today's date
   - Or add notes if partially complete
7. Write a summary of what you did to memory/$(date +%Y-%m-%d).md

Be autonomous. Make decisions. Ship something real.
If you hit a blocker that requires human input, document it clearly and move on.
" --dangerously-skip-permissions

# Push all changes
git add -A
git diff --cached --quiet || git commit -m "compound: auto-compound $(date +%Y-%m-%d)"
git push origin main 2>/dev/null || true

echo "=== Auto-Compound Completed: $(date) ==="
