#!/bin/sh
# Start wrapper for PsiTransfer on Railway.
set -e

# Railway injects PORT; PsiTransfer reads PSITRANSFER_PORT.
export PSITRANSFER_PORT="${PSITRANSFER_PORT:-${PORT:-3000}}"
export PSITRANSFER_UPLOAD_DIR="${PSITRANSFER_UPLOAD_DIR:-/data}"

mkdir -p "$PSITRANSFER_UPLOAD_DIR"

if [ "$(id -u)" = "0" ]; then
  # A fresh Railway volume is owned by root: hand it to the node user once.
  if [ "$(stat -c %u "$PSITRANSFER_UPLOAD_DIR")" != "1000" ]; then
    chown -R node:node "$PSITRANSFER_UPLOAD_DIR"
  fi
  # Drop root inside Node itself (no extra packages needed), then start the app.
  exec node -e "process.setgroups([1000]); process.setgid(1000); process.setuid(1000); require('/app/app.js');"
fi

exec node /app/app.js
