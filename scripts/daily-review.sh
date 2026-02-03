#!/bin/bash
# scripts/daily-review.sh
# Runs nightly to review the day's work and compound learnings into memory

set -e

cd /home/clawdbot/clawd

LOG_FILE="logs/daily-review-$(date +%Y-%m-%d).log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=== Daily Review Started: $(date) ==="

# Ensure we're on main and up to date
git checkout main 2>/dev/null || true
git pull origin main 2>/dev/null || true

# Run the review via Claude
claude -p "
You are doing your nightly compound review. 

1. Read through today's memory file (memory/$(date +%Y-%m-%d).md) if it exists
2. Read through yesterday's memory file as well
3. Review what was accomplished, what was learned, what mistakes were made
4. Update AGENTS.md with any new patterns, gotchas, or workflow improvements
5. Update MEMORY.md with significant learnings worth keeping long-term
6. If MEMORY.md doesn't exist, create it with a summary of key context about this workspace

Be thorough but concise. Extract the signal, discard the noise.

After updating files, commit your changes with a message like 'compound: daily review [date]'
" --dangerously-skip-permissions

# Push changes
git add -A
git diff --cached --quiet || git commit -m "compound: daily review $(date +%Y-%m-%d)" 
git push origin main 2>/dev/null || true

echo "=== Daily Review Completed: $(date) ==="
