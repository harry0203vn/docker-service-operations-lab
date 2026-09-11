# 🐳 Docker Service Operations Lab

Ein kompaktes Docker-Compose-Laborprojekt, das den Betrieb eines containerisierten Dienstes von Anfang bis Ende zeigt: starten/stoppen, Zustand prüfen, Ergebnisse protokollieren und daraus automatisch einen Betriebsreport erzeugen.

## Status

✅ Abgeschlossenes Laborprojekt — alle drei unten beschriebenen Testfälle wurden gegen eine echte Docker-Umgebung (Docker Desktop mit WSL Ubuntu) ausgeführt und sind erfolgreich verlaufen.

> **Hinweis:** Dieses Repository ist die kuratierte Portfolio-Version eines abgeschlossenen Lernprojekts ("Modul 2 — Docker Service Betrieb") aus einer Weiterbildung zum IT-Systemadministrator. Es handelt sich um ein Laborprojekt, nicht um produktive Software, und es besteht keine Verbindung zu oder Zertifizierung durch eine Prüfungsstelle.

## Gezeigte Kenntnisse

- Definieren und Betreiben eines Dienstes mit **Docker Compose** auf Basis eines offiziellen Images (kein eigenes `Dockerfile`)
- Schreiben eines **Bash**-Skripts zur Dienststeuerung (Start/Stop/Status/Logs)
- Schreiben eines **Bash**-Health-Check-Skripts mit HTTP-Statusprüfung, Zeitstempel-Logging und sauberen Exit-Codes
- Schreiben eines **Python**-Skripts, das Logdaten auswertet und einen lesbaren Betriebsreport erzeugt
- Entwurf und Durchführung realer funktionaler Testfälle gegen einen laufenden Container, inklusive eines gezielten Fehlerszenarios
- Schreiben verständlicher Betriebsdokumentation für einen Dienst, den auch eine andere Person bedienen kann

## Architektur

```
┌─────────────────────────────┐
│   Docker-Host (localhost)   │
│                              │
│  scripts/service_control.sh ─┐
│  scripts/health_check.sh    ─┼─> nordstern-webportal (nginx:alpine)
│                              │        │  Port 8090 -> 80
│  scripts/report_generator.py│        │  ./webportal -> /usr/share/nginx/html (read-only)
│         liest                │
│  logs/healthcheck.log       │
│         schreibt             │
│  reports/betriebsreport.txt │
└─────────────────────────────┘
```

Details siehe [`docs/architecture.md`](docs/architecture.md).

## Verwendete Technologien

| Ebene | Technologie |
|---|---|
| Container-Laufzeitumgebung | Docker / Docker Compose |
| Basis-Image | `nginx:alpine` (offizielles Docker-Image) |
| Dienststeuerung | Bash |
| Reporting | Python 3 |
| Web-Inhalt | Statisches HTML/CSS |

## Dienstübersicht

Ein einzelner Nginx-Container (`nordstern-webportal`) liefert eine kleine statische Portalseite aus. Die begleitenden Skripte übernehmen das Starten/Stoppen, die Erreichbarkeitsprüfung und die Auswertung der Health-Check-Historie zu einem Report.

## Projektstruktur

```
docker-service-operations-lab/
├── README.md
├── .gitignore
├── docker-compose.yml
├── scripts/
│   ├── service_control.sh
│   ├── health_check.sh
│   └── report_generator.py
├── webportal/
│   ├── index.html
│   └── style.css
├── docs/
│   ├── architecture.md
│   ├── operations.md
│   ├── health-checks-and-logging.md
│   ├── testing.md
│   └── troubleshooting.md
└── evidence/
    ├── README.md
    └── screenshots/
```

## Voraussetzungen

Docker + Docker Compose sowie eine Bash-fähige Shell (Linux, macOS oder Windows über WSL). Python 3 wird nur für das Report-Skript benötigt.

## Schnellstart

```bash
git clone <this-repo-url>
cd docker-service-operations-lab
chmod +x scripts/service_control.sh scripts/health_check.sh

./scripts/service_control.sh start
./scripts/health_check.sh
python3 scripts/report_generator.py
cat reports/betriebsreport.txt
```

Das Portal ist danach unter **http://localhost:8090** erreichbar.

## Dienststeuerung

`scripts/service_control.sh` kapselt Docker Compose mit vier Befehlen: `start`, `stop`, `status`, `logs`. Details siehe [`docs/operations.md`](docs/operations.md).

## Health Check

`scripts/health_check.sh` prüft `http://localhost:8090` und hängt eine Zeile mit Zeitstempel und Status (`OK`/`FEHLER`) an `logs/healthcheck.log` an. Exit-Code `0` bei Erfolg, `1` bei Fehler. Details siehe [`docs/health-checks-and-logging.md`](docs/health-checks-and-logging.md).

## Report-Erstellung

`scripts/report_generator.py` liest `logs/healthcheck.log` und schreibt `reports/betriebsreport.txt` mit Anzahl erfolgreicher/fehlgeschlagener Healthchecks, letztem bekanntem Status und einer kurzen Empfehlung. Details siehe [`docs/health-checks-and-logging.md`](docs/health-checks-and-logging.md).

## Testfälle

Drei reale Testfälle wurden gegen eine laufende Docker-Umgebung ausgeführt: Normalbetrieb, ein gestoppter Dienst als Fehlerfall, und die End-to-End-Reporterstellung. Details siehe [`docs/testing.md`](docs/testing.md).

## Nachweise

Ausgewählte, auf Privatsphäre geprüfte Screenshots der echten Testläufe liegen unter [`evidence/`](evidence/README.md).

## Fehlerbehebung / Erkenntnisse

Siehe [`docs/troubleshooting.md`](docs/troubleshooting.md) für reale Probleme, die beim Aufbau aufgetreten sind (z. B. fehlende Original-Webdateien), und wie sie gelöst wurden.

## Sicherheitsaspekte

- Es werden im gesamten Projekt keine Secrets, Zugangsdaten oder `.env`-Dateien verwendet.
- Der Nginx-Container bindet `webportal/` **read-only** ein — der Container kann die Quelldateien nicht verändern.
- Kein Privileged Mode, kein Docker-Socket-Mount, kein `cap_add`, keine benutzerdefinierte Registry.
- Der Web-Inhalt ist ein selbst erstellter Platzhalter für ein fiktives Unternehmen und enthält keine echten personenbezogenen oder organisatorischen Daten.

## Einschränkungen

Dies ist ein kompaktes Laborprojekt, kein Produktivsystem:

- Ein einzelner Dienst, kein Reverse Proxy, kein TLS.
- Kein eigenes Docker-Netzwerk über das Compose-Standardnetzwerk hinaus.
- Health Checks und Reports werden manuell ausgeführt, nicht zeitgesteuert (ein Cronjob wäre ein naheliegender nächster Schritt).
- Keine Anbindung an Monitoring/Alerting (z. B. Prometheus/Grafana) — der Report ist eine einfache Textdatei.

**Mögliche Erweiterung:** zeitgesteuerte Ausführung von Health Check und Report per Cron, sowie eine einfache Benachrichtigung bei `FEHLER`-Status.

## Projektkontext

Dieses Repository ist die kuratierte Portfolio-Version eines abgeschlossenen IT-Weiterbildungsprojekts ("Modul 2 — Docker Service Betrieb") im Rahmen einer Ausbildung zum IT-Systemadministrator. Die ursprüngliche Abgabe umfasste zusätzlich einen schriftlichen Bericht, eine kurze Präsentation und Screenshot-Nachweise; dieses Repository konzentriert sich auf die wiederverwendbaren technischen Artefakte.

## Autor

**Harry** — [@harry0203vn](https://github.com/harry0203vn)
