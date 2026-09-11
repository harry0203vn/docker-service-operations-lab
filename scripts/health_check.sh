#!/usr/bin/env bash
#
# health_check.sh
# Prueft, ob das Webportal unter http://localhost:8090 erreichbar ist,
# und schreibt das Ergebnis mit Zeitstempel in logs/healthcheck.log.
#
# Rueckgabewert:
#   0 = Portal erreichbar (OK)
#   1 = Portal nicht erreichbar (FEHLER)
#
# Projekt 5: Docker Service Betrieb mit Bash und Python (Nordstern Services GmbH)

set -uo pipefail
# Hinweis: set -e wird hier bewusst NICHT verwendet, da ein fehlgeschlagener
# curl-Aufruf ein erwartetes Ergebnis ist (Dienst nicht erreichbar) und
# kontrolliert behandelt werden soll, statt das Skript abzubrechen.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/healthcheck.log"
URL="http://localhost:8090"

mkdir -p "$LOG_DIR"

TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

HTTP_CODE="$(curl -fsS -o /dev/null -w "%{http_code}" --max-time 5 "$URL" 2>/dev/null)"
CURL_EXIT=$?

if [[ $CURL_EXIT -eq 0 && "$HTTP_CODE" == "200" ]]; then
  echo "$TIMESTAMP OK" >> "$LOG_FILE"
  echo "Healthcheck OK: $URL ist erreichbar (HTTP $HTTP_CODE)."
  exit 0
else
  echo "$TIMESTAMP FEHLER" >> "$LOG_FILE"
  echo "Healthcheck FEHLER: $URL ist nicht erreichbar."
  exit 1
fi
