# Betrieb

`scripts/service_control.sh` ist ein schlanker, sicherer Wrapper um `docker compose` für den Dienst `nordstern-webportal`. Das Skript ermittelt sein Projektverzeichnis immer relativ zu seinem eigenen Speicherort, sodass es unabhängig vom aktuellen Arbeitsverzeichnis funktioniert.

## Befehle

```
./scripts/service_control.sh {start|stop|status|logs}
```

| Befehl | Wirkung | Zugrunde liegender Compose-Aufruf |
|---|---|---|
| `start` | Startet den Dienst im Hintergrund. | `docker compose -f docker-compose.yml up -d` |
| `stop` | Stoppt den Dienst und entfernt den Container. | `docker compose -f docker-compose.yml down` |
| `status` | Zeigt, ob der Container aktuell läuft. | `docker compose -f docker-compose.yml ps` |
| `logs` | Gibt die letzten 50 Zeilen der Container-Logs aus. | `docker compose -f docker-compose.yml logs --tail=50` |

Wird das Skript ohne Argument oder mit einem unbekannten Argument aufgerufen, gibt es einen Hinweis zur Verwendung aus und beendet sich mit Exit-Code `1`, ohne etwas zu starten oder zu stoppen.

## Start

```bash
./scripts/service_control.sh start
```

Startet den Container `nordstern-webportal` über Docker Compose. Danach ist das Portal unter **http://localhost:8090** erreichbar.

## Stop

```bash
./scripts/service_control.sh stop
```

Stoppt den Container und entfernt ihn (`docker compose down`). Die statischen Dateien in `webportal/` bleiben unberührt, da sie auf dem Host liegen und nur read-only eingebunden sind.

## Status

```bash
./scripts/service_control.sh status
```

Zeigt den aktuellen Containerstatus (läuft / gestoppt) über `docker compose ps` an.

## Logs

```bash
./scripts/service_control.sh logs
```

Zeigt die letzten 50 Zeilen der eigenen Logs des Containers (Nginx-Zugriffs-/Fehlerausgabe) — nützlich, wenn der Health Check einen Fehler meldet und die tatsächliche Ursache im Container untersucht werden soll.

## Verhalten bei Fehlern

Bevor ein Compose-Befehl ausgeführt wird, prüft das Skript, ob `docker-compose.yml` am ermittelten Projektpfad tatsächlich existiert. Fehlt die Datei, gibt das Skript eine klare Fehlermeldung mit dem erwarteten Pfad aus und beendet sich mit Exit-Code `1`, statt mit einem rohen Docker-Fehler abzubrechen.
