#!/bin/bash
# Installs/refreshes the daily launchd job that runs `claude -p "/aso-doc-agent"`
# headless on this machine. macOS only (launchd). See ../skills/aso-doc-agent/USAGE.md.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PLIST_LABEL="com.sandsinh.aso-doc-agent"
PLIST_PATH="$HOME/Library/LaunchAgents/${PLIST_LABEL}.plist"
LOG_DIR="$REPO_ROOT/.claude/skills/aso-doc-agent/state"
CLAUDE_BIN="$(command -v claude || true)"

if [ -z "$CLAUDE_BIN" ]; then
  echo "ERROR: 'claude' not found on PATH. Install Claude Code CLI first." >&2
  exit 1
fi

mkdir -p "$LOG_DIR"

# Daily at 07:53 local (off-minute, before typical work hours). Edit StartCalendarInterval
# below and re-run this script to change the schedule.
cat > "$PLIST_PATH" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${PLIST_LABEL}</string>
    <key>ProgramArguments</key>
    <array>
        <string>${CLAUDE_BIN}</string>
        <string>-p</string>
        <string>/aso-doc-agent</string>
    </array>
    <key>WorkingDirectory</key>
    <string>${REPO_ROOT}</string>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>7</integer>
        <key>Minute</key>
        <integer>53</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>${LOG_DIR}/launchd.out.log</string>
    <key>StandardErrorPath</key>
    <string>${LOG_DIR}/launchd.err.log</string>
    <key>RunAtLoad</key>
    <false/>
</dict>
</plist>
EOF

launchctl unload "$PLIST_PATH" >/dev/null 2>&1 || true
launchctl load "$PLIST_PATH"

echo "Installed and loaded: $PLIST_PATH"
echo "Runs daily at 07:53 local time as: $CLAUDE_BIN -p \"/aso-doc-agent\" (cwd: $REPO_ROOT)"
echo "Logs: $LOG_DIR/launchd.out.log / launchd.err.log"
echo ""
echo "Useful commands:"
echo "  launchctl list | grep ${PLIST_LABEL}     # confirm it's loaded"
echo "  launchctl start ${PLIST_LABEL}           # trigger a run right now"
echo "  launchctl unload ${PLIST_PATH}           # stop the schedule"
