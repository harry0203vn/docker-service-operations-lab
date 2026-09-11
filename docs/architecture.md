# Architektur

## Überblick

Das Projekt betreibt einen einzigen containerisierten Dienst, der vollständig über Docker Compose definiert ist — es gibt kein eigenes `Dockerfile`, nur das offizielle Image `nginx:alpine`.

```yaml
services:
  webportal:
    image: nginx:alpine
    container_name: nordstern-webportal
    ports:
      - "8090:80"
    volumes:
      - ./webportal:/usr/share/nginx/html:ro
    restart: unless-stopped
```

## Komponenten

| Komponente | Aufgabe |
|---|---|
| `docker-compose.yml` | Definiert den einzigen Dienst `webportal`, sein Image, das Port-Mapping, das Volume und die Restart-Policy. |
| Container `nordstern-webportal` | Ein `nginx:alpine`-Container, der statische Dateien ausliefert. Es ist der einzige Container im Projekt. |
| `webportal/` | Statischer Seiteninhalt (`index.html`, `style.css`) für ein kleines Portal eines fiktiven Unternehmens, **read-only** in den Container eingebunden. |
| `scripts/service_control.sh` | Bash-Wrapper um `docker compose` zum Starten, Stoppen und Prüfen des Dienstes. |
| `scripts/health_check.sh` | Bash-Skript, das den laufenden Dienst per HTTP prüft und das Ergebnis protokolliert. |
| `scripts/report_generator.py` | Python-Skript, das aus dem Health-Check-Log einen kurzen Betriebsreport erzeugt. |
| `logs/healthcheck.log` | Append-only-Log, geschrieben von `health_check.sh`. |
| `reports/betriebsreport.txt` | Erzeugter Report, geschrieben von `report_generator.py`. |

## Daten-/Kontrollfluss

```
service_control.sh start
        │
        ▼
docker compose up -d  ──►  nordstern-webportal (nginx:alpine)
                                   │  lauscht auf Container-Port 80
                                   │  liefert ./webportal aus (read-only)
                                   ▼
                         http://localhost:8090  (Host-Port 8090 -> Container-Port 80)

health_check.sh  ──HTTP GET──►  http://localhost:8090
        │
        ▼
hängt "<Zeitstempel> OK" oder "<Zeitstempel> FEHLER" an logs/healthcheck.log an

report_generator.py  ──liest──►  logs/healthcheck.log
        │
        ▼
schreibt reports/betriebsreport.txt (Anzahl OK/FEHLER, letzter Status, Empfehlung)
```

## Designentscheidungen

- **Nur offizielles Image, kein eigenes `Dockerfile`.** Der Dienst muss lediglich statische Dateien ausliefern, daher wird `nginx:alpine` direkt verwendet. Das hält das Image klein und erspart die Pflege eines eigenen Builds.
- **Read-only Bind-Mount.** `./webportal:/usr/share/nginx/html:ro` bindet den Seiteninhalt read-only ein, sodass der laufende Container die Quelldateien auf dem Host nicht verändern kann.
- **`restart: unless-stopped`.** Der Container startet nach einem Host-Neustart oder Docker-Neustart automatisch neu, bleibt aber gestoppt, wenn er zuvor bewusst über `service_control.sh stop` beendet wurde.
- **Kein eigenes Docker-Netzwerk.** Bei nur einem Dienst genügt das Standardnetzwerk von Compose; eine Kommunikation zwischen mehreren Diensten ist nicht erforderlich.
- **Trennung der Zuständigkeiten.** Compose übernimmt den Container-Lebenszyklus, `service_control.sh` ist der bedienerfreundliche Einstiegspunkt für den Betrieb, `health_check.sh` übernimmt die Überwachung und `report_generator.py` das Reporting — jedes Skript hat genau eine Aufgabe.
