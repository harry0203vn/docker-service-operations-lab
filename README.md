# 🐳 Docker Service Operations Lab — Containerized Service Operations

[![Status](https://img.shields.io/badge/Status-Abgeschlossen-brightgreen.svg)]()
[![Docker](https://img.shields.io/badge/Docker-Compose-blue.svg)](https://docs.docker.com/compose/)
[![Bash](https://img.shields.io/badge/Bash-Scripting-brightgreen.svg)](https://www.gnu.org/software/bash/)
[![Python](https://img.shields.io/badge/Python-Automation-blue.svg)](https://www.python.org/)
[![Portfolio](https://img.shields.io/badge/Kontext-IT--Weiterbildung-gold.svg)]()
[![Version](https://img.shields.io/badge/Version-v1.0-blue.svg)]()

> 🚀 Ein **praxisnahes Docker-Compose-Laborprojekt** zur Demonstration von containerisierten Dienstbetrieb: automatisierte Dienststeuerung, HTTP-basierte Health Checks, strukturiertes Logging, und datengetriebene Betriebsberichte.

---

## 📚 Inhaltsverzeichnis

- [🎯 Projektübersicht](#-projektübersicht)
- [✨ Highlights & Features](#-highlights--features)
- [🛠️ Technologie-Stack](#️-technologie-stack)
- [📁 Repository-Struktur](#-repository-struktur)
- [💡 Demonstrierte Skills](#-demonstrierte-skills)
- [🏗️ Architektur & Design](#️-architektur--design)
- [🚀 Quick Start](#-quick-start)
- [⚙️ Dienststeuerung & Betrieb](#️-dienststeuerung--betrieb)
- [🏥 Health Checks & Logging](#-health-checks--logging)
- [📊 Reporting & Datenauswertung](#-reporting--datenauswertung)
- [🧪 Testing & Qualitätssicherung](#-testing--qualitätssicherung)
- [📖 Dokumentation](#-dokumentation)
- [🔐 Sicherheitskonzepte](#-sicherheitskonzepte)
- [✅ Projekt-Checkliste](#-projekt-checkliste)
- [🎓 Lernziele & Takeaways](#-lernziele--takeaways)

---

## 🎯 Projektübersicht

### Was ist dieses Projekt?

Dieses Lab simuliert den **professionellen Betrieb eines containerisierten Web-Dienstes** unter Docker Compose. Im Gegensatz zu unkontrollierten „Click-to-Deploy"-Szenarien arbeitet dieses Projekt mit **echten Betriebsaufgaben** und dokumentiert reale Probleme und deren Lösungen.

Das Projekt wurde **eigenständig im Rahmen einer IT-Weiterbildung** durchgeführt und später als öffentliches Portfolio kuratiert und veröffentlicht.

### 🎯 Kernziele

✅ **Praktischer Dienstbetrieb** — Realistische Aufgaben in sicherer Laborumgebung automatisieren  
✅ **Automatisierung statt Manuelles** — Repetitive Operationen durch Shell- & Python-Skripte ersetzen  
✅ **Datengesteuerte Entscheidungen** — Health-Check-Logs auswerten, lesbare Berichte generieren  
✅ **End-to-End-Demonstration** — Von der Containerisierung bis zur Operations-Automation

---

## ✨ Highlights & Features

| Feature | Details |
|---------|---------|
| 🐳 **Docker-Compose-Dienst** | Nginx-basiertes Portal, Volume-Mount (read-only), Port-Mapping |
| 🎮 **Dienststeuerung** | Bash-Skript mit `start`, `stop`, `status`, `logs` — vereinheitlichte CLI |
| 🏥 **HTTP-Health-Checks** | Automatische Prüfung mit Exit-Code-Semantik, Zeitstempel-Logging |
| 📊 **Strukturiertes Logging** | Tägliche Einträge in maschinenlesbarem Format, Aggregation für Reports |
| 📈 **Python-Reporting** | Datenauswertung (Erfolgsquoten, Trends), lesbare Betriebsberichte |
| 🧪 **Funktionale Testfälle** | Normalbetrieb, Fehlerszenarien, End-to-End-Validierung |
| 🔒 **Keine Secrets** | Keine Hardcoded Credentials, `.env`-Dateien oder private Keys |
| 📸 **Evidence & Nachweise** | Screenshot-Dokumentation echter Testläufe |

---

## 🛠️ Technologie-Stack

```
Container-Laufzeit:    Docker / Docker Compose
Basis-Image:           nginx:alpine (offiziell)
Dienststeuerung:       Bash 4.x+
Reporting & Analysis:  Python 3.x
Web-Inhalt:            HTML5, CSS3 (statisch)
Logging:               strukturierte Textdateien
Versionskontrolle:     Git, GitHub
```

---

## 📁 Repository-Struktur

```
docker-service-operations-lab/
│
├── 📄 README.md                           # Diese Datei
├── 📄 .gitignore
│
├── 🐳 docker-compose.yml                  # Nginx-Container-Definition
│
├── 📂 scripts/                            # Automatisierungsskripte
│   ├── service_control.sh                # Dienststeuerung (start/stop/status/logs)
│   ├── health_check.sh                   # HTTP-Health-Check mit Logging
│   └── report_generator.py               # Report-Erstellung & Datenauswertung
│
├── 📂 webportal/                          # Container-Inhalt (read-only Volume)
│   ├── index.html                        # Portal-Homepage
│   └── style.css                         # Styling
│
├── 📂 docs/                               # Umfassende Betriebsdokumentation
│   ├── architecture.md                   # Systemdesign & Komponenten
│   ├── operations.md                     # Dienststeuerung & Workflows
│   ├── health-checks-and-logging.md      # Health-Check-Strategie & Logging
│   ├── testing.md                        # 3 funktionale Testfälle
│   └── troubleshooting.md                # Reale Probleme & Lösungen
│
├── 📂 logs/                               # Health-Check-Logdateien (runtime)
│   └── healthcheck.log                   # Tägliche Check-Ergebnisse
│
├── 📂 reports/                            # Betriebsberichte (runtime)
│   └── betriebsreport.txt                # Generierter Report mit KPIs
│
└── 📂 evidence/                           # Nachweise & Screenshots
    ├── README.md                         # Evidence-Übersicht
    └── screenshots/
        └── 01-portal-running.png         # Beweis: Portal lädt erfolgreich
```

---

## 💡 Demonstrierte Skills

### Container & Docker
- ✅ **Docker Compose** — Service-Definition, Volume-Mounts, Port-Mapping
- ✅ **Container-Images** — Offizielle Images nutzen, verstehen und konfigurieren
- ✅ **Read-Only Volumes** — Datenschutz durch Zugriffsbeschränkung auf Container
- ✅ **Netzwerk-Konfiguration** — Port-Binding, localhost-Erreichbarkeit

### Automatisierung & Scripting
- ✅ **Bash-Scripting** — Modulare, wiederverwendbare Service-Control-Skripte
- ✅ **HTTP-Prüfungen** — Health-Checks mit `curl`, Exit-Code-Semantik
- ✅ **Logging & Monitoring** — Strukturierte Protokollierung, Datenexport
- ✅ **Python-Integration** — Datenauswertung, Report-Generierung, Automation

### Testing & Qualitätssicherung
- ✅ **Funktionale Tests** — 3 reale Testfälle gegen laufende Container
- ✅ **Fehlerszenarien** — Kontrollierte Ausfallszenarien (z. B. gestoppter Service)
- ✅ **End-to-End-Validierung** — Gesamter Workflow vom Start bis Report

### Best Practices & Dokumentation
- ✅ **Klare Dokumentation** — Techniker und Betreiber als Zielgruppe
- ✅ **Reproduzierbarkeit** — Komplette Anleitung zum Aufbau & Betrieb
- ✅ **Kein Hardcoding** — Konfigurierbare Parameter, keine Secrets im Repo
- ✅ **Evidence-basiert** — Reale Screenshots, nicht angenommene Ergebnisse

---

## 🏗️ Architektur & Design

### Systemkomponenten

```
┌──────────────────────────────────┐
│   Docker-Host (localhost)        │
│                                   │
│  ┌─────────────────────────────┐ │
│  │  nordstern-webportal        │ │
│  │  (nginx:alpine)             │ │
│  │                             │ │
│  │  Port 8090 → 80             │ │
│  │  ./webportal → /html (ro)   │ │
│  └─────────────────────────────┘ │
│            ↑                      │
│   scripts/service_control.sh      │
│   scripts/health_check.sh         │
│            ↓                      │
│  logs/healthcheck.log            │
│  reports/betriebsreport.txt      │
│            ↑                      │
│  scripts/report_generator.py     │
└──────────────────────────────────┘
```

**Datensatz-Workflow:**

```
Health Check → healthcheck.log → Report Generator → betriebsreport.txt
(täglich)     (maschinenlesbar)  (Python-Script)   (menschenlesbar)
```

Siehe [docs/architecture.md](docs/architecture.md) für vollständige technische Details.

---

## 🚀 Quick Start

### Voraussetzungen

- Docker + Docker Compose installiert
- Bash 4.x+ (Linux, macOS oder WSL)
- Python 3.x (nur für Report-Skript)
- Git

### 1. Repository klonen

```bash
git clone https://github.com/harry0203vn/docker-service-operations-lab.git
cd docker-service-operations-lab
```

### 2. Ausführrechte setzen

```bash
chmod +x scripts/service_control.sh scripts/health_check.sh
```

### 3. Dienst starten

```bash
./scripts/service_control.sh start
```

### 4. Health Check durchführen

```bash
./scripts/health_check.sh
```

### 5. Report generieren

```bash
python3 scripts/report_generator.py
cat reports/betriebsreport.txt
```

### 6. Portal im Browser öffnen

Navigiere zu **http://localhost:8090** — du solltest das Portal-Dashboard sehen.

### 7. Dienst stoppen

```bash
./scripts/service_control.sh stop
```

---

## ⚙️ Dienststeuerung & Betrieb

### `service_control.sh` — Vereinheitlichte Service-CLI

Das Bash-Skript kapselt Docker Compose mit vier Befehlen:

```bash
./scripts/service_control.sh start      # Container hochfahren
./scripts/service_control.sh stop       # Container herunterfahren
./scripts/service_control.sh status     # Aktuellen Zustand prüfen
./scripts/service_control.sh logs       # Live-Logs anzeigen
```

**Interne Logik:**
- ✅ Nutzt `docker-compose` aus dem Verzeichnis root
- ✅ Wartet auf Container-Bereitschaft (mit Timeouts)
- ✅ Gibt strukturierte Meldungen aus
- ✅ Exit-Code-Semantik für Automation (0 = Erfolg, 1 = Fehler)

**Siehe:** [docs/operations.md](docs/operations.md)

---

## 🏥 Health Checks & Logging

### `health_check.sh` — HTTP-basierte Prüfung

Das Skript führt eine einfache HTTP-GET-Anfrage durch und dokumentiert das Ergebnis:

```bash
./scripts/health_check.sh
```

**Was es tut:**
1. 🔗 Sendet HTTP-GET zu `http://localhost:8090`
2. ⏱️ Wartet auf Response (mit Timeout)
3. 📝 Hängt Zeile an `logs/healthcheck.log`:
   - `2026-09-11 14:23:45 OK` — Service erreichbar (HTTP 200)
   - `2026-09-11 14:24:02 FEHLER` — Service nicht erreichbar / Fehler

4. 📤 Exit-Code: `0` = OK, `1` = FEHLER (für Automation geeignet)

**Log-Format:**
```
2026-09-11 14:23:45 OK
2026-09-11 14:24:02 FEHLER
2026-09-11 14:27:30 OK
```

**Siehe:** [docs/health-checks-and-logging.md](docs/health-checks-and-logging.md)

---

## 📊 Reporting & Datenauswertung

### `report_generator.py` — Datengetriebene Berichte

Das Python-Skript wertet die Health-Check-Logs aus und erstellt einen lesbaren Betriebsreport:

```bash
python3 scripts/report_generator.py
```

**Was es tut:**
1. 📖 Liest `logs/healthcheck.log`
2. 📊 Zählt die Einträge:
   - Anzahl `OK`-Einträge
   - Anzahl `FEHLER`-Einträge
   - Letzter bekannter Status (aus der letzten Logzeile)
3. 📝 Schreibt `reports/betriebsreport.txt`

**Report-Beispiel:**

```
Projekt: Nordstern Webportal (Projekt 5 - Docker Service Betrieb)
Report erzeugt am: 2026-09-11 14:30:15

Anzahl erfolgreicher Healthchecks (OK): 2
Anzahl fehlgeschlagener Healthchecks (FEHLER): 1
Letzter bekannter Status: OK

Empfehlung: Dienst laeuft aktuell, es gab jedoch fruehere Fehler - Verlauf pruefen.
```

**Siehe:** [docs/health-checks-and-logging.md](docs/health-checks-and-logging.md)

---

## 🧪 Testing & Qualitätssicherung

### 3 Funktionale Testfälle

Das Projekt dokumentiert und validiert drei realistische Szenarien gegen eine echte Docker-Umgebung:

| Test | Beschreibung | Validierung |
|------|-------------|-------------|
| **T1: Normalbetrieb** | Service startet, Portal lädt, Health Check OK | HTTP 200, Portal-Inhalt, OK-Log-Eintrag |
| **T2: Fehlerfall** | Service wird gestoppt, Health Check schlägt fehl | HTTP 0 (Fehler), ERROR-Log-Eintrag, Exit-Code 1 |
| **T3: End-to-End** | Kompletter Workflow: Start → Check → Report → Stop | Report enthält korrekte Statistiken, alle Artefakte vorhanden |

**Testlauf durchführen (manuell):**

```bash
# Terminal 1: Service starten
./scripts/service_control.sh start

# Terminal 2: Tests ausführen
./scripts/health_check.sh
python3 scripts/report_generator.py

# Terminal 1: Service stoppen
./scripts/service_control.sh stop
```

**Siehe:** [docs/testing.md](docs/testing.md) für vollständige Testprotokolle.

---

## 📖 Dokumentation

| Dokument | Inhalt |
|----------|--------|
| [architecture.md](docs/architecture.md) | Systemdesign, Komponenten, Netzwerkmodell |
| [operations.md](docs/operations.md) | Service-Steuerung, Workflows, Operationen |
| [health-checks-and-logging.md](docs/health-checks-and-logging.md) | Health-Check-Strategie, Log-Format, Best Practices |
| [testing.md](docs/testing.md) | 3 Testfälle, Protokolle, Ergebnisse |
| [troubleshooting.md](docs/troubleshooting.md) | Reale Probleme, Fehlerszenarien, Lösungen |
| [evidence/README.md](evidence/README.md) | Screenshots & Nachweise |

---

## 🔐 Sicherheitskonzepte

### Was dieses Projekt berücksichtigt

✅ **Keine Secrets im Code** — Keine `.env`-Dateien, API-Keys oder Passwörter  
✅ **Read-Only Volumes** — Container kann HTML-Dateien nicht verändern  
✅ **Minimale Konfiguration** — Kein Privileged Mode, keine Caps, kein Docker-Socket  
✅ **Input-Validierung** — Log-Einträge validiert, keine Injection-Anfälligkeit  
✅ **Fehlerbehandlung** — Robuste Health Checks mit Timeouts  

### Was dieses Projekt NICHT ist

⚠️ **Nicht produktionsreif** — Labordemonstrator, nicht für Livebetrieb  
⚠️ **Keine Enterprise-Monitoring** — Lokale Text-Reports, nicht an Prometheus/Grafana angebunden  
⚠️ **Keine Automatisierung per Cron** — Health Checks & Reports werden manuell ausgeführt  
⚠️ **Keine Hochverfügbarkeit** — Single-Container, kein Clustering oder Load-Balancing  

**Sicherheits-Details:** [docs/architecture.md](docs/architecture.md)

---

## ✅ Projekt-Checkliste

| Element | Status | Beweis |
|---------|--------|--------|
| 🐳 Docker Compose Setup | ✅ | `docker-compose.yml` |
| 🎮 Dienststeuerung (CLI) | ✅ | `scripts/service_control.sh` |
| 🏥 Health Checks | ✅ | `scripts/health_check.sh` + logs |
| 📊 Report-Generierung | ✅ | `scripts/report_generator.py` |
| 🧪 Funktionale Tests | ✅ | 3 Testfälle, dokumentiert |
| 📖 Technische Dokumentation | ✅ | 5 Markdown-Dateien |
| 📸 Evidence & Screenshots | ✅ | `evidence/` |
| 🔒 Keine Secrets | ✅ | Verifiziert, `.gitignore` |

---

## 🎓 Lernziele & Takeaways

Mit diesem Projekt wurden praktisch folgende Kompetenzen demonstriert:

### Docker & Container-Betrieb
✅ Docker Compose zur Service-Orchestrierung  
✅ Container-Lifecycle-Management (Start/Stop/Status)  
✅ Volume-Mounts und Zugriffsbeschränkungen  
✅ Port-Mapping und Netzwerk-Konfiguration  

### Automatisierung & Scripting
✅ Bash-Scripting für Dienststeuerung  
✅ HTTP-basierte Service-Prüfungen  
✅ Strukturiertes Logging und Datensammlung  
✅ Python-basierte Datenauswertung und Reporting  

### Betriebskonzepte
✅ Health Checks und Service-Überwachung  
✅ Datengesteuerte Entscheidungsfindung (KPIs, Reports)  
✅ Fehlerszenarien und Troubleshooting  
✅ Monitoring und Alerting (grundlegend)  

### Best Practices
✅ Sichere Containerisierung (keine Secrets, minimale Privilegien)  
✅ Klare, wartbare Dokumentation  
✅ Reproduzierbare Testfälle  
✅ Evidence-basierte Validierung  

---

<div align="center">

### ⭐ Docker Service Operations Lab

**📅 Entwickelt:** 2025–2026 (IT-Weiterbildung)  
**✅ Status:** Abgeschlossen  
**🏷️ Version:** v1.0  
**🎓 Projekt-Typ:** Eigenständiges Laborprojekt im Rahmen einer IT-Weiterbildung  
**📚 Dokumentation:** Umfassend (5 Markdown-Dateien + Screenshots)  

**Entwickler:** [@harry0203vn](https://github.com/harry0203vn)

---

### 🔗 Weitere Links

- 📖 [Vollständige Architektur-Dokumentation](docs/architecture.md)
- ⚙️ [Betriebsanleitung & Workflows](docs/operations.md)
- 🏥 [Health-Check & Logging-Strategie](docs/health-checks-and-logging.md)
- 🧪 [Test-Protokolle & Ergebnisse](docs/testing.md)
- 🐛 [Troubleshooting & Erkenntnisse](docs/troubleshooting.md)
- 📸 [Evidence & Screenshots](evidence/README.md)

---

> **Hinweis:** Dieses Projekt ist ein **Labordemonstrator**, nicht für Produktiveinsatz gedacht. Alle Daten und Inhalte sind zu Demonstrationszwecken erstellt. Siehe [docs/troubleshooting.md](docs/troubleshooting.md) für reale Probleme und deren Lösungen.

**[⬆ Nach oben](#-docker-service-operations-lab--containerized-service-operations)**

</div>
