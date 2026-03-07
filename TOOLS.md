# TOOLS.md - Local Notes

Skills define *how* tools work. This file is for *your* specifics — the stuff that's unique to your setup.

---

## Anthony's Accounts

### Google
- **Email:** anthonyjpretto@gmail.com
- **App Password:** stored locally (not in git)
- **Calendar OAuth:** configured, token at ~/.gcal_token.pickle
- **Calendars:** anthonyjpretto@gmail.com, Family, US Holidays
- **Configured:** 2026-03-02

### GitHub
- **Username:** ajpretto
- **Token:** stored at `~/.github_token_vab`
- **Repos:** github.com/ajpretto/VAB (AI voice business)
- **Configured:** 2026-03-02

---

## Scheduled Cron Jobs

| Name | Time (UTC) | Purpose |
|------|------------|---------|
| lead-gen-daily | 7:00 | Find 25+ Tampa leads |
| daily-capabilities-research | 9:00 | AI tools research |
| competitor-monitoring | 10:00 Tue/Thu | Track competitors |
| nightly-advisory-council | 3:00 | 8-advisor business analysis |
| dream-cycle | 4:00 | Memory consolidation |
| weekly-business-review | 20:00 Sun | Weekly summary |

---

## Math Study Schedule (Blitzer Algebra & Trig)

- **Book:** Blitzer Algebra and Trigonometry, 6th Edition
- **Goal:** 4 hrs/week, lock in concepts before calculus
- **Sessions:** 3x per week (Tue/Thu/Sun)
- **Calendar:** PENDING SETUP

| Day | Time | Focus |
|-----|------|-------|
| Tue | 7:00-8:20am | New section + worked examples |
| Thu | 7:00-8:20am | Review + new problems |
| Sun | Flexible 1hr 20min | Weekly review + hardest problems |

---

## Telegram
- **Chat ID:** 8530957928
- **Configured:** 2026-03-03

## VPS Info

- **Host:** srv1323962
- **User:** clawdbot
- **Workspace:** /home/clawdbot/clawd

---

---

## Twitter/X Link Handling

X.com blocks direct fetching. Use FxTwitter API:

**Convert:** `x.com` or `twitter.com` → `api.fxtwitter.com`

Example:
- Input: `https://x.com/dotta/status/123456`
- Fetch: `https://api.fxtwitter.com/dotta/status/123456`

Returns JSON with full tweet text, author, media, etc.

---

Add whatever helps you do your job. This is your cheat sheet.
