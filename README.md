# 🐳 Docker Service Operations Lab

A small, focused Docker Compose lab that demonstrates operating a containerized service end-to-end: starting/stopping it, checking its health, logging results, and generating an automated operational report.

## Status

✅ Completed lab project — all three test cases below were executed against a real Docker environment (Docker Desktop + WSL Ubuntu) and passed.

> **Lab / training disclaimer:** This repository is a curated portfolio version of a completed training project ("Modul 2 — Docker Service Betrieb") built during an IT system administration course. It is a lab exercise, not production software, and is not affiliated with or certified by any certification body.

## Skills Demonstrated

- Defining and running a service with **Docker Compose** using an official base image (no custom `Dockerfile`)
- Writing a **Bash** control script for service lifecycle management (start/stop/status/logs)
- Writing a **Bash** health-check script with HTTP status checking, timestamped logging, and proper exit codes
- Writing a **Python** script that parses log data and generates a human-readable operational report
- Designing and executing real functional test cases against a running container, including a deliberate failure scenario
- Writing clear operational documentation for a service another engineer could run

## Architecture

```
┌─────────────────────────────┐
│   Docker host (localhost)   │
│                              │
│  scripts/service_control.sh ─┐
│  scripts/health_check.sh    ─┼─> nordstern-webportal (nginx:alpine)
│                              │        │  port 8090 -> 80
│  scripts/report_generator.py│        │  ./webportal -> /usr/share/nginx/html (read-only)
│         reads               │
│  logs/healthcheck.log       │
│         writes              │
│  reports/betriebsreport.txt │
└─────────────────────────────┘
```

See [`docs/architecture.md`](docs/architecture.md) for details.

## Technology Stack

| Layer | Technology |
|---|---|
| Container runtime | Docker / Docker Compose |
| Base image | `nginx:alpine` (Docker Official Image) |
| Service operations | Bash |
| Reporting | Python 3 |
| Web content | Static HTML/CSS |

## Service Overview

A single Nginx container (`nordstern-webportal`) serves a small static internal-portal page. The surrounding scripts handle starting/stopping it, checking that it's actually reachable, and turning the health-check history into a short report.

## Repository Structure

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

## Quick Start

```bash
git clone <this-repo-url>
cd docker-service-operations-lab
chmod +x scripts/service_control.sh scripts/health_check.sh

./scripts/service_control.sh start
./scripts/health_check.sh
python3 scripts/report_generator.py
cat reports/betriebsreport.txt
```

The portal is then reachable at **http://localhost:8090**.

Requirements: Docker + Docker Compose, and a Bash-capable shell (Linux, macOS, or Windows via WSL). Python 3 is needed only for the report script.

## Service Operations

`scripts/service_control.sh` wraps Docker Compose with four commands: `start`, `stop`, `status`, `logs`. See [`docs/operations.md`](docs/operations.md).

## Health Checks

`scripts/health_check.sh` checks `http://localhost:8090` and appends a timestamped `OK`/`FEHLER` line to `logs/healthcheck.log`, exiting `0` on success and `1` on failure. See [`docs/health-checks-and-logging.md`](docs/health-checks-and-logging.md).

## Report Generation

`scripts/report_generator.py` reads `logs/healthcheck.log` and writes `reports/betriebsreport.txt` with a success/failure count, the last known status, and a short recommendation. See [`docs/health-checks-and-logging.md`](docs/health-checks-and-logging.md).

## Testing

Three real test cases were executed against a live Docker environment: normal operation, a stopped-service failure case, and end-to-end report generation. See [`docs/testing.md`](docs/testing.md).

## Evidence

Selected, privacy-reviewed screenshots from the real test runs live in [`evidence/`](evidence/README.md).

## Troubleshooting / Lessons Learned

See [`docs/troubleshooting.md`](docs/troubleshooting.md) for real issues encountered during the build (e.g. missing original web assets) and how they were resolved.

## Security Considerations

- No secrets, credentials, or `.env` files are used anywhere in this project.
- The Nginx container mounts `webportal/` as a **read-only** bind mount — the container cannot modify the source files.
- No privileged mode, no Docker socket mount, no `cap_add`, no custom registry.
- The web content is a self-made placeholder for a fictional company; it contains no real personal or organizational data.

## Limitations

This is a compact lab project, not a production system:

- Single service, no reverse proxy, no TLS.
- No custom Docker network beyond Compose's default.
- Health checks and reports are run manually, not on a schedule (a cron job would be the natural next step).
- No alerting/monitoring integration (e.g. Prometheus/Grafana) is included — the report is a plain text file.

## Project Origin

This repository is a curated portfolio version of a completed IT training project ("Modul 2 — Docker Service Betrieb") built as part of an IT system administration course. The original submission also included a written report, a short presentation, and screenshot evidence; this repository focuses on the reusable technical artifacts.

## Author

**Harry** — [@harry0203vn](https://github.com/harry0203vn)
