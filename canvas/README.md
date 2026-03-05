# Anthony's Command Center

A personalized dashboard for managing the AI Voice Business.

## Access

**🌐 Public URL (always available):**
```
https://anthony-mc.loca.lt
```

Note: First visit may show a "Continue" page — just click through.

**Local Access (via SSH tunnel):**
```bash
ssh -L 18800:localhost:18800 clawdbot@147.93.41.128
# Then: http://localhost:18800/
```

## Persistence

Mission Control runs via PM2 and auto-restarts:
- `mission-control` — HTTP server on port 18800
- `mc-tunnel` — Public tunnel to loca.lt

Check status: `pm2 list`
View logs: `pm2 logs mission-control`

## Pages

### Main Dashboard (`index.html`)
- Advisory grade display
- Business metrics (leads, calls, demos, revenue)
- Today's priorities
- Quick actions
- **Call logging** with localStorage persistence
- Lead category breakdown
- Today's schedule

### Leads Viewer (`leads-viewer.html`)
- Searchable lead database
- Filter by category
- Filter by area
- Click-to-call phone links
- Quick call logging

## Features

### Call Logging
1. Enter business name
2. Select outcome (Connected, Voicemail, Gatekeeper, etc.)
3. Click "Log"
4. Calls are stored in browser localStorage
5. Call count updates automatically

### Quick Actions
- **Log Call**: Opens the call form
- **View Leads**: Opens the leads database
- **Ask Gru**: Send a message to Gru (placeholder)
- **Call Script**: Opens the cold call script on GitHub

## Data

The dashboard currently uses:
- Static data in `data.json`
- localStorage for call tracking
- Sample lead data (will be connected to real LEADS.md)

## Future Enhancements
- [ ] Real-time sync with TRACKING.md
- [ ] Calendar integration
- [ ] Retell AI call analytics
- [ ] Voice note transcription
- [ ] Direct Telegram integration

---

*Built by Gru 🦹 on 2026-03-04*
