#!/usr/bin/env bash
set -euo pipefail

ZIP_GLOB="/Peacock/version/Peacock-*-linux.zip"
TMP_DIR="/tmp/peacock_payload"
RUNTIME="/opt/peacock_runtime"
TARGET_VOL="/Peacock"
HOST_SUBDIRS=(version userdata contracts contractSessions plugins)

err(){ echo "Peacock release missing or chunk0.js not found. Place the Linux ZIP in /Peacock/version or ensure chunk0.js is in /Peacock." >&2; exit 1; }

shopt -s nullglob
zips=( $ZIP_GLOB )
shopt -u nullglob

rm -rf "$RUNTIME"
mkdir -p "$RUNTIME" "$TMP_DIR"

if [ "${#zips[@]}" -gt 0 ]; then
  ZIP="${zips[0]}"
  unzip -q "$ZIP" -d "$TMP_DIR"
  found="$(find "$TMP_DIR" -type f -name chunk0.js -print -quit || true)"
  [ -n "$found" ] || { echo "Could not locate chunk0.js inside ZIP." >&2; ls -R "$TMP_DIR" >&2 || true; err; }
  src_root="$(dirname "$found")"
  cp -a "$src_root/." "$RUNTIME/"
  rm -rf "$TMP_DIR"
else
  found="$(find "$TARGET_VOL" -maxdepth 3 -type f -name chunk0.js -print -quit || true)"
  if [ -n "$found" ]; then
    srcdir="$(dirname "$found")"
    cp -a "$srcdir/." "$RUNTIME/" || true
  fi
fi

[ -f "$RUNTIME/chunk0.js" ] || err

for d in "${HOST_SUBDIRS[@]}"; do
  mkdir -p "$TARGET_VOL/$d"
done

exec "$@"
