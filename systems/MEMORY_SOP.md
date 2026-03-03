# Memory SOP — Preventing Context Loss

*Based on OpenClaw docs, Simon Hoiberg's approach, and best practices research*
*Created: 2026-03-02*

---

## Core Principle

> **If it's not written to a file, it doesn't exist.**

Memory is plain Markdown. The files are the source of truth. I only "remember" what gets written to disk.

---

## Memory Architecture

### Tier 1: Always Loaded (session start)
| File | Purpose |
|------|---------|
| `SOUL.md` | Who I am |
| `USER.md` | Who Anthony is |
| `AGENTS.md` | How I operate |
| `TASKS.md` | Current work queue |
| `memory/YYYY-MM-DD.md` | Today + yesterday's logs |

### Tier 2: Searchable (on demand)
| File | Purpose |
|------|---------|
| `MEMORY.md` | Long-term curated memory (main session only) |
| `memory/*.md` | Historical daily logs |
| `TOOLS.md` | Environment-specific notes |

### Tier 3: Project-Specific
| Location | Purpose |
|----------|---------|
| `projects/*/INDEX.md` | Project state |
| `systems/*.md` | SOPs and protocols |

---

## Write Rules

### ALWAYS Write When:
1. **Anthony says "remember this"** → Write to MEMORY.md or daily log
2. **Decision is made** → Log to daily memory with context
3. **Credentials/access granted** → Write to TOOLS.md immediately
4. **New task assigned** → Update TASKS.md before starting
5. **Setup completed** → Document in relevant file
6. **Preference expressed** → Update USER.md or MEMORY.md

### Write Format (Daily Log)
```markdown
### [Topic] (HH:MM UTC)
- What happened
- Decision made
- Next steps
- Any credentials/access (redacted if sensitive)
```

### Write Format (MEMORY.md)
```markdown
## [Category]
- Fact or preference
- Date learned: YYYY-MM-DD
- Context: brief
```

---

## Pre-Compaction Flush

When context is getting long, BEFORE it compacts:
1. Update TASKS.md with current state
2. Write key decisions to daily memory
3. Save any in-progress work to files
4. Commit code if applicable

**The system will remind me, but I should be proactive.**

---

## Session Start Protocol

1. Read SOUL.md, USER.md, AGENTS.md
2. Read TASKS.md — check for active work
3. Read memory/YYYY-MM-DD.md (today + yesterday)
4. If main session: Read MEMORY.md
5. Check for HEARTBEAT.md tasks

---

## Credential Storage

**IMMEDIATELY** when credentials are received:
```markdown
# TOOLS.md addition:

### [Service Name]
- Access type: [OAuth/API key/etc]
- Account: [email/username]
- Configured: YYYY-MM-DD
- Notes: [how to use]
```

**For sensitive tokens:** Store in `~/.credentials/` or environment, reference in TOOLS.md.

---

## What NOT to Rely On

❌ "Mental notes" — don't exist after compaction
❌ Conversation history — gets truncated
❌ "I'll remember" — I won't unless I write it
❌ Previous session context — starts fresh

---

## Recovery Checklist

If I seem to have forgotten something:
1. Check `memory/YYYY-MM-DD.md` for recent days
2. Check `MEMORY.md` for long-term facts
3. Check `TOOLS.md` for credentials/setup
4. Check `TASKS.md` for work state
5. Use `memory_search` for semantic recall

---

## Anthony's Directive

From 2026-03-02:
> "Stop letting your memory fade away"

**Action:** Write MORE aggressively. When in doubt, write it down. Files > brain.

---

*This SOP is now my operating protocol for memory management.*
