#!/usr/bin/env bash
#
# service_control.sh
# Einfache Steuerung des Docker-Compose-Dienstes "nordstern-webportal".
#
# Verwendung:
#   ./service_control.sh start   -> Dienst starten
#   ./service_control.sh stop    -> Dienst stoppen
#   ./service_control.sh status  -> aktuellen Containerstatus anzeigen
#   ./service_control.sh logs    -> letzte Docker-Logs anzeigen
#
# Projekt 5: Docker Service Betrieb mit Bash und Python (Nordstern Services GmbH)

set -euo pipefail

# Projektverzeichnis ermitteln (ein Verzeichnis oberhalb von scripts/),
# damit das Skript unabhaengig vom aktuellen Arbeitsverzeichnis funktioniert.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
COMPOSE_FILE="$PROJECT_DIR/docker-compose.yml"
CONTAINER_NAME="nordstern-webportal"

usage() {
  echo "Verwendung: $(basename "$0") {start|stop|status|logs}"
}

check_compose_file() {
  if [[ ! -f "$COMPOSE_FILE" ]]; then
    echo "Fehler: docker-compose.yml wurde nicht gefunden unter: $COMPOSE_FILE"
    echo "Bitte pruefen Sie, ob das Projektverzeichnis vollstaendig ist."
    exit 1
  fi
}

cmd_start() {
  check_compose_file
  echo "Starte Dienst ueber Docker Compose ..."
  docker compose -f "$COMPOSE_FILE" up -d
  echo "Dienst gestartet. Webportal sollte unter http://localhost:8090 erreichbar sein."
}

cmd_stop() {
  check_compose_file
  echo "Stoppe Dienst ueber Docker Compose ..."
  docker compose -f "$COMPOSE_FILE" down
  echo "Dienst gestoppt."
}

cmd_status() {
  check_compose_file
  echo "Aktueller Containerstatus:"
  docker compose -f "$COMPOSE_FILE" ps
}

cmd_logs() {
  check_compose_file
  echo "Letzte Docker-Logs fuer $CONTAINER_NAME:"
  docker compose -f "$COMPOSE_FILE" logs --tail=50
}

if [[ $# -ne 1 ]]; then
  usage
  exit 1
fi

case "$1" in
  start)
    cmd_start
    ;;
  stop)
    cmd_stop
    ;;
  status)
    cmd_status
    ;;
  logs)
    cmd_logs
    ;;
  *)
    echo "Unbekannter Befehl: $1"
    usage
    exit 1
    ;;
esac
