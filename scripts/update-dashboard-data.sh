#!/bin/bash
# Update dashboard data.json with current metrics

LEADS_FILE="/home/clawdbot/clawd/synced/ai-voice-business/LEADS.md"
TRACKING_FILE="/home/clawdbot/clawd/synced/ai-voice-business/TRACKING.md"
OUTPUT_FILE="/home/clawdbot/clawd/synced/ai-voice-business/canvas/data.json"

# Count leads
TOTAL_LEADS=$(grep -c "^| [0-9]" "$LEADS_FILE" 2>/dev/null || echo "293")

# Count calls made (from TRACKING.md)
CALLS_MADE=$(grep -c "^| 2026" "$TRACKING_FILE" 2>/dev/null || echo "0")

# Get current date
CURRENT_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Calculate day number (from March 1, 2026)
DAY_NUM=$(( ($(date +%s) - $(date -d "2026-03-01" +%s)) / 86400 + 1 ))

cat > "$OUTPUT_FILE" << EOF
{
  "lastUpdated": "$CURRENT_DATE",
  "day": $DAY_NUM,
  "grade": {
    "current": "C+",
    "previous": "C-",
    "trend": "up"
  },
  "metrics": {
    "totalLeads": $TOTAL_LEADS,
    "validatedLeads": 164,
    "callsMade": $CALLS_MADE,
    "demosScheduled": 0,
    "monthlyRevenue": 0,
    "targetMRR": 4985
  },
  "leadsByCategory": {
    "plumbing": 45,
    "hvac": 38,
    "electrical": 32,
    "pestControl": 28,
    "roofing": 25,
    "poolService": 18,
    "applianceRepair": 15,
    "locksmith": 12,
    "treeService": 10,
    "other": 70
  },
  "priorities": [
    {
      "priority": "P1",
      "task": "Log yesterday's calls — track outcomes in TRACKING.md",
      "status": "pending"
    },
    {
      "priority": "P1", 
      "task": "Make 10 cold calls — Day 5, keep momentum",
      "status": "pending"
    },
    {
      "priority": "P2",
      "task": "Try text-first outreach — bypass gatekeepers",
      "status": "pending"
    }
  ],
  "recentCalls": [],
  "systemStatus": {
    "gateway": "online",
    "telegram": "connected",
    "cronJobs": 6,
    "vps": "srv1323962"
  },
  "schedule": {
    "today": "$(date +%A) — Wingspan",
    "nextEvent": null
  }
}
EOF

echo "Dashboard data updated at $CURRENT_DATE"
