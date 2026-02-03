#!/bin/bash
# refresh-token.sh - VPS OAuth token refresh (no Keychain)
set -euo pipefail

CREDS_FILE="$HOME/.clawdbot/credentials/claude-oauth.json"
AUTH_FILE="$HOME/.clawdbot/agents/main/agent/auth-profiles.json"
LOG_FILE="$HOME/clawd/logs/claude-oauth-refresh.log"
CLIENT_ID="9d1c250a-e61b-44d9-88ed-5944d1962f5e"
TOKEN_URL="https://console.anthropic.com/v1/oauth/token"
REFRESH_BUFFER=30

log() { echo "[$(date -Iseconds)] $1" >> "$LOG_FILE"; }

# Load current credentials
if [[ ! -f "$CREDS_FILE" ]]; then
    log "ERROR: Credentials file not found: $CREDS_FILE"
    exit 1
fi

ACCESS_TOKEN=$(jq -r ".accessToken" "$CREDS_FILE")
REFRESH_TOKEN=$(jq -r ".refreshToken" "$CREDS_FILE")
EXPIRES_AT=$(jq -r ".expiresAt" "$CREDS_FILE")

# Check if refresh needed
NOW_MS=$(($(date +%s) * 1000))
BUFFER_MS=$((REFRESH_BUFFER * 60 * 1000))
THRESHOLD=$((EXPIRES_AT - BUFFER_MS))

if [[ "$NOW_MS" -lt "$THRESHOLD" ]] && [[ "${1:-}" != "--force" ]]; then
    MINS_LEFT=$(( (EXPIRES_AT - NOW_MS) / 60000 ))
    log "Token valid for ${MINS_LEFT}m, skipping refresh"
    exit 0
fi

log "Refreshing token..."

# Call OAuth refresh
RESPONSE=$(curl -s -X POST "$TOKEN_URL" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=refresh_token" \
    -d "client_id=$CLIENT_ID" \
    -d "refresh_token=$REFRESH_TOKEN")

if echo "$RESPONSE" | jq -e ".access_token" > /dev/null 2>&1; then
    NEW_ACCESS=$(echo "$RESPONSE" | jq -r ".access_token")
    NEW_REFRESH=$(echo "$RESPONSE" | jq -r ".refresh_token")
    EXPIRES_IN=$(echo "$RESPONSE" | jq -r ".expires_in")
    NEW_EXPIRES_AT=$((NOW_MS + EXPIRES_IN * 1000))

    # Update credentials file
    jq --arg at "$NEW_ACCESS" --arg rt "$NEW_REFRESH" --argjson exp "$NEW_EXPIRES_AT" \
        '.accessToken = $at | .refreshToken = $rt | .expiresAt = $exp' \
        "$CREDS_FILE" > "$CREDS_FILE.tmp" && mv "$CREDS_FILE.tmp" "$CREDS_FILE"
    chmod 600 "$CREDS_FILE"

    # Update auth-profiles.json (use .token field, not .key)
    jq --arg tok "$NEW_ACCESS" \
        '.profiles["anthropic:default"].token = $tok' \
        "$AUTH_FILE" > "$AUTH_FILE.tmp" && mv "$AUTH_FILE.tmp" "$AUTH_FILE"
    chmod 600 "$AUTH_FILE"

    log "SUCCESS: Token refreshed, expires in ${EXPIRES_IN}s"
else
    log "ERROR: Refresh failed: $RESPONSE"
    exit 1
fi
