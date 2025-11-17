#!/bin/sh
set -e

# Simple backup script for Postgres database via docker compose.
# Usage:
#   ./OnlineJudge/deploy/backup.sh ./backups
# Will create timestamped SQL dump in provided directory.

TARGET_DIR="$1"
if [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <backup-output-directory>" >&2
  exit 1
fi
mkdir -p "$TARGET_DIR"
STAMP=$(date +%Y%m%d-%H%M%S)
OUT="$TARGET_DIR/oj-${STAMP}.sql"
echo "Backing up Postgres to $OUT" >&2
docker compose exec postgres pg_dump -U ${POSTGRES_USER:-onlinejudge} ${POSTGRES_DB:-onlinejudge} > "$OUT"
echo "Backup complete: $OUT" >&2
