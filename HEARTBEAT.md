# HEARTBEAT.md

## Proactive Signal Synthesis

Don't check things in isolation. Combine signals into context-aware nudges.

### Signal Combinations → Actions

| Signals | Interpretation | Action |
|---------|----------------|--------|
| Calendar empty + no messages in 2hrs + active project exists | Drifting / unfocused | "You've gone quiet. What's the ONE thing right now?" |
| Lead added yesterday + no call logged today | Avoidance or forgot | "You pulled leads but haven't called. Fear or forgot?" |
| Task marked "In Progress" for 2+ days + no updates | Stalled | "Task X has been 'in progress' for 2 days. What's blocking?" |
| Meeting in <2hrs + no prep notes | Unprepared | "You have [meeting] in 2hrs. Need prep?" |
| No calendar events today + no tasks completed | Drift day | "Empty calendar, nothing done. What's the plan?" |
| Multiple tasks due today + silence | Overwhelmed or avoiding | "You have X tasks due today. Which one first?" |

### Data Sources to Synthesize
- Calendar (Google Calendar OAuth)
- Recent messages (last 6hrs of conversation)
- TASKS.md status
- memory/YYYY-MM-DD.md for today
- Time of day + day of week
- Last check-in timestamp

---

## Calendar Intelligence

**Passive reading is not enough. Analyze and act.**

- [ ] Check calendar density for next 48hrs
- [ ] If 3+ back-to-back meetings → suggest 30min buffer block
- [ ] If no focus blocks this week → propose 2hr deep work block
- [ ] If meeting conflicts with known priority task → flag it
- [ ] Upcoming event in <2hrs? Remind if no prep visible

---

## Dan Koe Protocol Check
- [ ] Is Anthony doing lever-moving tasks or busy work?
- [ ] Has he made visible progress on ONE project (AI voice business)?
- [ ] Remind: "What's your 1-3 priority tasks that advance the project?"

---

## Task Queue Check
- [ ] Read TASKS.md — any stalled, overdue, or forgotten work?
- [ ] Check In Progress tasks for 2+ days — escalate
- [ ] Check Blocked tasks — can any be unblocked?
- [ ] Any completed tasks not celebrated? Acknowledge wins.

---

## Workflow Extraction (Lead/CRM Pattern Detection)

Watch for repetitive patterns in notes and messages:
- Same fields mentioned 3x about leads → propose structured tracker
- Same lead mentioned 2x without progress → flag as stale
- Detect pipeline language: "talked to" → contacted, "sent proposal" → pitched, "following up" → nurturing
- If pattern detected → suggest automation or structure

---

## Voice Memo Processing

If voice message received:
1. Auto-transcribe via Whisper skill
2. Extract action items → add to TASKS.md
3. Extract facts/context → add to memory/YYYY-MM-DD.md
4. Summarize back to Anthony for confirmation

---

## Proactive Outreach Triggers

| Condition | Action |
|-----------|--------|
| >6 hours since last interaction + daytime | Check in |
| Calendar event completed + no debrief | "How did [event] go?" |
| End of day + tasks incomplete | "EOD check: X tasks still open" |
| Morning + no activity yet | "Morning. What's the #1 priority today?" |
| Weekend + no explicit rest planned | Don't nag unless urgent |

---

## Self-Audit (Run Weekly)

Against the 6 agent failure modes:
- [ ] Is MEMORY.md getting bloated? Prune if >500 lines
- [ ] Am I using memory_search before answering recall questions?
- [ ] Did any tool calls fail silently this week? Check error patterns
- [ ] Am I over-promising timelines? Review recent estimates
- [ ] Am I asking "did this help?" enough? Track feedback loops

---

*If all checks pass with nothing to report: HEARTBEAT_OK*
